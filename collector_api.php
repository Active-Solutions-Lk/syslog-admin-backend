<?php
//collector_api.php
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
    $decrypted = EncryptionHandler::decryptData(trim($rawData), STATIC_TOKEN);
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
$required = ['token', 'col_id', 'col_ip', 'activation_key', 'cpu_count', 'ram_usage', 'log_count', 'type'];
try {
    RequestValidator::validateRequiredFields($data, $required);
} catch (Exception $e) {
    $errorCode = $e->getCode();
    echo ResponseBuilder::error($e->getMessage(), $errorCode);
    exit;
}

// Extract data
$token         = $data['token'];
$col_id        = (int)$data['col_id'];
$col_ip        = $data['col_ip'];
$activation_key = $data['activation_key'];
$cpu_count     = (int)$data['cpu_count'];
$ram_usage     = (int)$data['ram_usage'];
$log_count     = (int)$data['log_count'];
$type          = strtolower(trim($data['type']));

// Validate request type
try {
    RequestValidator::validateRequestType($type); // Uses default collector types
} catch (Exception $e) {
    $errorCode = $e->getCode();
    echo ResponseBuilder::error($e->getMessage(), $errorCode);
    exit;
}

// TOKEN VALIDATION
try {
    RequestValidator::validateToken($token, STATIC_TOKEN);
} catch (Exception $e) {
    // Log the rejection to api_logs
    Logger::logRejection($pdo, null, $cpu_count, $ram_usage, $log_count, $type, 'Request rejected - invalid token');
    
    $errorCode = $e->getCode();
    echo ResponseBuilder::error($e->getMessage(), $errorCode);
    exit;
}

// PROJECT VALIDATION (activation_key)
try {
    $project = RequestValidator::validateActivationKey($pdo, $activation_key, true); // true for collector
    $project_id = $project['id'];
} catch (Exception $e) {
    // Log the rejection to api_logs
    $errorCode = $e->getCode();
    if ($errorCode == 301) {
        Logger::logRejection($pdo, null, $cpu_count, $ram_usage, $log_count, $type, 'Request rejected - invalid activation key');
    } elseif ($errorCode == 302) {
        Logger::logRejection($pdo, $project['id'] ?? null, $cpu_count, $ram_usage, $log_count, $type, 'Request rejected - project is not active or expired');
    } elseif ($errorCode == 305) {
        Logger::logRejection($pdo, $project['id'] ?? null, $cpu_count, $ram_usage, $log_count, $type, 'Request rejected - activation key already registered for collector');
    }
    
    echo ResponseBuilder::error($e->getMessage(), $errorCode);
    exit;
}

// HANDLE DIFFERENT REQUEST TYPES

if ($type === 'coll-reg') {
    // Check if collector exists in the collectors table
    try {
        $collectorCheckStmt = $pdo->prepare("SELECT id, ip FROM collectors WHERE id = ? LIMIT 1");
        $collectorCheckStmt->execute([$col_id]);
        $existingCollector = $collectorCheckStmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$existingCollector) {
            // Log the rejection to api_logs
            Logger::logRejection($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, 'Registration rejected - collector ID does not exist');
            echo ResponseBuilder::error('Collector ID does not exist', 306);
            exit;
        }
        
        // Update collector IP if needed
        DatabaseHandler::registerCollector($pdo, $col_id, $col_ip);
        
        // Link collector to project
        DatabaseHandler::linkCollectorToProject($pdo, $col_id, $project_id);
        
        // Update is_active_coll to 1 to indicate the key has been used for collector
        $updateKeyStatusStmt = $pdo->prepare("UPDATE projects SET is_active_coll = 1 WHERE id = ?");
        $updateKeyStatusStmt->execute([$project_id]);
        
        // Log successful registration
        Logger::logSuccess($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, 'Registration Successful');
        
        // Return success for registration
        echo ResponseBuilder::success(
            'Registration successful',
            $project_id,
            $col_id,
            $type,
            ['registered' => true]
        );
        exit;
    } catch (Exception $e) {
        // Log the rejection to api_logs
        Logger::logRejection($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, 'Request rejected - ' . $e->getMessage());
        echo ResponseBuilder::error($e->getMessage(), 501);
        exit;
    }
} elseif ($type === 'coll-health') {
    // For health check, update collector status and log as normal
    try {
        // Check if collector exists in the collectors table
        $collectorCheckStmt = $pdo->prepare("SELECT id, ip FROM collectors WHERE id = ? LIMIT 1");
        $collectorCheckStmt->execute([$col_id]);
        $existingCollector = $collectorCheckStmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$existingCollector) {
            // Log the rejection to api_logs
            Logger::logRejection($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, 'Health check rejected - collector ID does not exist');
            echo ResponseBuilder::error('Collector ID does not exist', 306);
            exit;
        }
        
        // Check if the provided IP matches the collector's IP in the database
        if ($existingCollector['ip'] !== $col_ip) {
            // Log the rejection to api_logs
            Logger::logRejection($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, 'Health check rejected - provided IP does not match collector IP');
            echo ResponseBuilder::error('Provided IP does not match collector IP', 307);
            exit;
        }
        
        DatabaseHandler::registerCollector($pdo, $col_id, $col_ip);
    } catch (Exception $e) {
        // Log the rejection to api_logs
        Logger::logRejection($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, 'Request rejected - failed to update collector during health check');
        echo ResponseBuilder::error('Failed to update collector', 401);
        exit;
    }
    
    // Insert into api_logs for health check
    Logger::logSuccess($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, 'Collector Health Update');
} else {
    // For 'collector' and 'analyzer' types (existing behavior)
    try {
        // Check if collector exists in the collectors table
        $collectorCheckStmt = $pdo->prepare("SELECT id, ip FROM collectors WHERE id = ? LIMIT 1");
        $collectorCheckStmt->execute([$col_id]);
        $existingCollector = $collectorCheckStmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$existingCollector) {
            // Log the rejection to api_logs
            Logger::logRejection($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, 'Request rejected - collector ID does not exist');
            echo ResponseBuilder::error('Collector ID does not exist', 306);
            exit;
        }
        
        DatabaseHandler::registerCollector($pdo, $col_id, $col_ip);
    } catch (Exception $e) {
        // Log the rejection to api_logs
        Logger::logRejection($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, 'Request rejected - failed to update collector');
        echo ResponseBuilder::error('Failed to update collector', 401);
        exit;
    }
    
    // Insert into api_logs
    Logger::logSuccess($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, ucfirst($type) . ' heartbeat');
}

// For coll-health and other types, return the standard success response
if ($type !== 'coll-reg') {
    echo ResponseBuilder::success(
        'Activation successful',
        $project_id,
        $col_id,
        $type,
        ['activated' => true]
    );
}

?>