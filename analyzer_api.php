<?php
//analyzer_api.php
require_once __DIR__ . '/components/EncryptionHandler.php';
require_once __DIR__ . '/components/RequestValidator.php';
require_once __DIR__ . '/components/DatabaseHandler.php';
require_once __DIR__ . '/components/Logger.php';
require_once __DIR__ . '/components/ResponseBuilder.php';
require_once __DIR__ . '/connection.php';

header('Content-Type: application/json');

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo ResponseBuilder::error('Method not allowed', 100);
    exit;
}

// Read raw POST data
$rawData = file_get_contents('php://input');

if (empty($rawData)) {
    echo ResponseBuilder::error('No data received', 101);
    exit;
}

// DECRYPTION
try {
    $decrypted = EncryptionHandler::decryptData(trim($rawData), AN_TOKEN);
} catch (Exception $e) {
    $errorCode = $e->getCode();
    echo ResponseBuilder::error($e->getMessage(), $errorCode);
    exit;
}

// Parse JSON payload
$data = json_decode($decrypted, true);
if (json_last_error() !== JSON_ERROR_NONE || !is_array($data)) {
    echo ResponseBuilder::error('Invalid JSON payload', 104);
    exit;
}

// Validate required fields
$required = ['token', 'an_id', 'an_ip', 'activation_key', 'cpu_load', 'ram_load', 'log_count', 'type'];
try {
    RequestValidator::validateRequiredFields($data, $required);
} catch (Exception $e) {
    $errorCode = $e->getCode();
    echo ResponseBuilder::error($e->getMessage(), $errorCode);
    exit;
}

// Extract data
$token         = $data['token'];
$an_id         = (int)$data['an_id'];
$an_ip         = $data['an_ip'];
$activation_key = $data['activation_key'];
$cpu_load      = (int)$data['cpu_load'];
$ram_load      = (int)$data['ram_load'];
$log_count     = (int)$data['log_count'];
$type          = strtolower(trim($data['type']));
$last_sign_in_timestamp = $data['last_sign_in_timestamp'] ?? null;

// Validate request type
try {
    RequestValidator::validateRequestType($type, ['an-reg', 'an-health']);
} catch (Exception $e) {
    $errorCode = $e->getCode();
    echo ResponseBuilder::error($e->getMessage(), $errorCode);
    exit;
}

// TOKEN VALIDATION
try {
    RequestValidator::validateToken($token, AN_TOKEN);
} catch (Exception $e) {
    // Log the rejection to api_logs
    Logger::logRejection($pdo, null, $cpu_load, $ram_load, $log_count, $type, 'Request rejected - invalid token');
    
    $errorCode = $e->getCode();
    echo ResponseBuilder::error($e->getMessage(), $errorCode);
    exit;
}

// PROJECT VALIDATION (activation_key)
try {
    $project = RequestValidator::validateActivationKey($pdo, $activation_key, false, $type); // false for analyzer, passing request type
    $project_id = $project['id'];
} catch (Exception $e) {
    // Log the rejection to api_logs
    $errorCode = $e->getCode();
    if ($errorCode == 301) {
        Logger::logRejection($pdo, null, $cpu_load, $ram_load, $log_count, $type, 'Request rejected - invalid activation key');
    } elseif ($errorCode == 302) {
        Logger::logRejection($pdo, $project['id'] ?? null, $cpu_load, $ram_load, $log_count, $type, 'Request rejected - project is not active or expired');
    } elseif ($errorCode == 305) {
        Logger::logRejection($pdo, $project['id'] ?? null, $cpu_load, $ram_load, $log_count, $type, 'Request rejected - activation key already registered for analyzer');
    }
    
    echo ResponseBuilder::error($e->getMessage(), $errorCode);
    exit;
}

// HANDLE DIFFERENT REQUEST TYPES

if ($type === 'an-reg') {
    // For registration, check if this activation key already has an analyzer registered
    try {
        // Check if this activation key already has an analyzer registered (is_active_an = 1)
        $stmt = $pdo->prepare("SELECT is_active_an FROM projects WHERE id = ? LIMIT 1");
        $stmt->execute([$project_id]);
        $project = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($project && $project['is_active_an'] == 1) {
            // Log the rejection to api_logs
            Logger::logRejection($pdo, $project_id, $cpu_load, $ram_load, $log_count, $type, 'Registration rejected - analyzer already registered to this activation key');
            echo ResponseBuilder::error('Analyzer already registered to this activation key', 303);
            exit;
        }
        
        // Register/update the analyzer
        $stmt = $pdo->prepare("INSERT INTO analyzers (id, ip, status, created_at, updated_at) VALUES (?, ?, 1, NOW(), NOW()) ON DUPLICATE KEY UPDATE ip = VALUES(ip), status = 1, updated_at = NOW()");
        $stmt->execute([$an_id, $an_ip]);
        
        // Update is_active_an to 1 to indicate the key has been used for analyzer
        $updateKeyStatusStmt = $pdo->prepare("UPDATE projects SET is_active_an = 1 WHERE id = ?");
        $updateKeyStatusStmt->execute([$project_id]);
        
        // Log successful registration
        Logger::logSuccess($pdo, $project_id, $cpu_load, $ram_load, $log_count, $type, 'Analyzer Registration Successful');
        
        // Get project details for response
        $projectDetails = getProjectDetails($pdo, $project_id);
        
        // Get additional data (log_count, device_count, log_duration) from api_logs
        $additionalData = getAdditionalData($pdo, $project_id);
        
        // Return success for registration
        echo ResponseBuilder::success(
            'Registration successful',
            $project_id,
            $an_id,
            $type,
            [
                'activated' => true,
                'activation_status' => 'active',
                'project_details' => $projectDetails,

                'log_count' => $additionalData['log_count'] ?? 0,
                'log_duration' => $additionalData['log_duration'] ?? 0,
                'device_count' => $additionalData['device_count'] ?? 0
            ]
        );
        exit;
    } catch (Exception $e) {
        // Log the rejection to api_logs
        Logger::logRejection($pdo, $project_id, $cpu_load, $ram_load, $log_count, $type, 'Request rejected - ' . $e->getMessage());
        echo ResponseBuilder::error($e->getMessage(), 501);
        exit;
    }
} elseif ($type === 'an-health') {
    // For health check, update analyzer status and log as normal
    try {
        // Update analyzer status and info
        $stmt = $pdo->prepare("INSERT INTO analyzers (id, ip, status, updated_at) VALUES (?, ?, 1, NOW()) ON DUPLICATE KEY UPDATE ip = VALUES(ip), status = 1, updated_at = NOW()");
        $stmt->execute([$an_id, $an_ip]);
    } catch (Exception $e) {
        // Log the rejection to api_logs
        Logger::logRejection($pdo, $project_id, $cpu_load, $ram_load, $log_count, $type, 'Request rejected - failed to update analyzer during health check');
        echo ResponseBuilder::error('Failed to update analyzer', 401);
        exit;
    }
    
    // Insert into api_logs for health check
    Logger::logSuccess($pdo, $project_id, $cpu_load, $ram_load, $log_count, $type, 'Analyzer Health Update');
    
    // Get project details for response
    $projectDetails = getProjectDetails($pdo, $project_id);
    
    // Get additional data (log_count, device_count, log_duration) from api_logs
    $additionalData = getAdditionalData($pdo, $project_id);
    
    // Return success response for health check
    echo ResponseBuilder::success(
        'Activation successful',
        $project_id,
        $an_id,
        $type,
        [
            'activated' => true,
            'activation_status' => 'active',
            'project_details' => $projectDetails,

            'log_count' => $additionalData['log_count'] ?? 0,
            'log_duration' => $additionalData['log_duration'] ?? 0,
            'device_count' => $additionalData['device_count'] ?? 0
        ]
    );
} else {
    // Invalid type
    echo ResponseBuilder::error('Invalid type', 106);
    exit;
}

// Function to get project details including end customer company name, package name, and package ending date
function getProjectDetails($pdo, $project_id) {
    $stmt = $pdo->prepare("
        SELECT 
            p.id,
            p.activation_key,
            p.logger_ip,
            p.collector_ip,
            p.status,
            p.created_at,
            p.updated_at,
            p.end_customer_id,
            p.port_id,
            ec.company as company_name,
            pkg.name as package_name,
            pkg.project_duration,
            p.created_at as package_start_date,
            DATE_ADD(p.created_at, INTERVAL pkg.project_duration DAY) as package_end_date,
            prt.port,
            c.id as collector_id,
            c.name as collector_name,
            c.ip as collector_ip_addr,
            c.domain as collector_domain,
            c.secret_key as collector_secret_key,
            c.is_active as collector_is_active
        FROM projects p
        LEFT JOIN end_customer ec ON p.end_customer_id = ec.id
        LEFT JOIN packages pkg ON p.pkg_id = pkg.id
        LEFT JOIN ports prt ON p.port_id = prt.id
        LEFT JOIN collectors c ON p.collector_ip = c.id
        WHERE p.id = ?
    ");
    $stmt->execute([$project_id]);
    $project = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$project) {
        return null;
    }
    
    return [
        'id' => $project['id'],
        'activation_key' => $project['activation_key'],
        'company_name' => $project['company_name'],
        'package_name' => $project['package_name'],
        'package_start_date' => $project['package_start_date'],
        'package_end_date' => $project['package_end_date'],
        'port' => $project['port'],
        'collector' => [
            'id' => $project['collector_id'],
            'name' => $project['collector_name'],
            'ip' => $project['collector_ip_addr'],
            'domain' => $project['collector_domain'],
            'secret_key' => $project['collector_secret_key'],
            'is_active' => $project['collector_is_active']
        ]
    ];
}

// Function to get additional data (log_count, log_duration, device_count) for a project
function getAdditionalData($pdo, $project_id) {
    // Get package information for this project
    $stmt = $pdo->prepare("SELECT pkg.log_count, pkg.log_duration, pkg.device_count 
                          FROM projects p 
                          JOIN packages pkg ON p.pkg_id = pkg.id 
                          WHERE p.id = ?");
    $stmt->execute([$project_id]);
    $packageData = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($packageData) {
        return [
            'log_count' => $packageData['log_count'],
            'log_duration' => $packageData['log_duration'],
            'device_count' => $packageData['device_count']
        ];
    } else {
        // If no package data exists, return default values
        return [
            'log_count' => 0,
            'log_duration' => 0,
            'device_count' => 0
        ];
    }
}

?>