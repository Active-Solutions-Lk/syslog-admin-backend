<?php
// an_client.php
// Client-side implementation to communicate with analyzer_api.php

class AnalyzerAPIClient 
{
    private $apiUrl;
    private $encryptionKey;
    
    public function __construct($apiUrl, $encryptionKey) 
    {
        $this->apiUrl = $apiUrl;
        $this->encryptionKey = $encryptionKey;
    }
    
    /**
     * Encrypt data using AES-256-CBC
     */
    private function encryptData($data, $key) 
    {
        $method = 'AES-256-CBC';
        $ivLength = openssl_cipher_iv_length($method);
        
        // Hash the key using SHA-256 (same as in EncryptionHandler::decryptData)
        $hashedKey = hash('sha256', $key, true);
        
        $iv = openssl_random_pseudo_bytes($ivLength);
        
        $encrypted = openssl_encrypt(json_encode($data), $method, $hashedKey, OPENSSL_RAW_DATA, $iv);
        if ($encrypted === false) {
            throw new Exception('Encryption failed', 201);
        }
        
        return base64_encode($iv . $encrypted);
    }
    
    /**
     * Register an analyzer
     */
    public function registerAnalyzer($anId, $anIp, $activationKey, $cpuLoad, $ramLoad, $logCount, $token) 
    {
        $requestData = [
            'token' => $token,
            'an_id' => $anId,
            'an_ip' => $anIp,
            'activation_key' => $activationKey,
            'cpu_load' => $cpuLoad,
            'ram_load' => $ramLoad,
            'log_count' => $logCount,
            'type' => 'an-reg',
            'last_sign_in_timestamp' => date('Y-m-d H:i:s')
        ];
        
        return $this->sendRequest($requestData);
    }
    
    /**
     * Send health check for an analyzer
     */
    public function sendHealthCheck($anId, $anIp, $activationKey, $cpuLoad, $ramLoad, $logCount, $token) 
    {
        $requestData = [
            'token' => $token,
            'an_id' => $anId,
            'an_ip' => $anIp,
            'activation_key' => $activationKey,
            'cpu_load' => $cpuLoad,
            'ram_load' => $ramLoad,
            'log_count' => $logCount,
            'type' => 'an-reg',
            'last_sign_in_timestamp' => date('Y-m-d H:i:s')
        ];
        
        return $this->sendRequest($requestData);
    }
    
    /**
     * Send request to the API
     */
    private function sendRequest($data) 
    {
        $encryptedData = $this->encryptData($data, $this->encryptionKey);
        
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $this->apiUrl);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $encryptedData);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        // Note: No Content-Type header is set since we're sending encrypted data, not JSON
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        
        $response = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        $error = curl_error($ch);
        curl_close($ch);
        
        if ($error) {
            throw new Exception('CURL Error: ' . $error);
        }
        
        if ($httpCode !== 200) {
            // Attempt to decode the error response to get more meaningful error details
            $errorResponse = json_decode($response, true);
            $errorMessage = $errorResponse && isset($errorResponse['error']) 
                ? $errorResponse['error'] 
                : 'HTTP Error: ' . $httpCode;
            $errorCode = $errorResponse && isset($errorResponse['code']) 
                ? $errorResponse['code'] 
                : $httpCode;
            
            throw new Exception($errorMessage . ' (Code: ' . $errorCode . ')', $errorCode);
        }
        
        return json_decode($response, true);
    }
    
    /**
     * Debug method to test encryption
     */
    public function debugEncrypt($data) 
    {
        $method = 'AES-256-CBC';
        $ivLength = openssl_cipher_iv_length($method);
        
        // Hash the key using SHA-256 (same as in EncryptionHandler::decryptData)
        $hashedKey = hash('sha256', $this->encryptionKey, true);
        
        $iv = openssl_random_pseudo_bytes($ivLength);
        
        $encrypted = openssl_encrypt(json_encode($data), $method, $hashedKey, OPENSSL_RAW_DATA, $iv);
        if ($encrypted === false) {
            return 'Encryption failed';
        }
        
        $result = base64_encode($iv . $encrypted);
        return $result;
    }
}

// Example usage (only run when script is executed directly):
if (basename(__FILE__) == basename($_SERVER['SCRIPT_NAME'])) {
try {
    // Configuration
    $apiUrl = 'http://localhost/syslog-console-api/analyzer_api.php'; // Update with your actual API URL
    $anToken = 'I3UYA2HSQPB86XpsdVUb9szDu5tn2W3fOpg8'; // This should match the AN_TOKEN in connection.php
    
    // Create API client instance
    $client = new AnalyzerAPIClient($apiUrl, $anToken);
    
    // Example data for analyzer registration
    $anId = 2;           // Analyzer ID
    $anIp = '192.168.1.100'; // Analyzer IP
    $activationKey = 'QPV6-0869-00AQ'; // Activation key - must exist in database with status=1 and is_active_an=0
    $cpuLoad = 45;          // CPU load percentage
    $ramLoad = 60;          // RAM load percentage
    $logCount = 1500;       // Number of logs processed
    
    // Register analyzer
    echo "Registering analyzer...\n";
    $result = $client->registerAnalyzer(
        $anId, 
        $anIp, 
        $activationKey, 
        $cpuLoad, 
        $ramLoad, 
        $logCount, 
        $anToken
    );
    
    if (isset($result['success']) && $result['success']) {
        echo "Analyzer registration successful!\n";
        echo "Response: " . json_encode($result, JSON_PRETTY_PRINT) . "\n";
    } else {
        echo "Analyzer registration failed!\n";
        echo "Error: " . ($result['error'] ?? 'Unknown error') . "\n";
        echo "Code: " . ($result['code'] ?? 'N/A') . "\n";
        
        // Provide more context based on error codes
        if (isset($result['code'])) {
            switch ($result['code']) {
                case 101:
                    echo "Context: No data received by the API\n";
                    break;
                case 104:
                    echo "Context: Invalid JSON payload after decryption\n";
                    break;
                case 105:
                    echo "Context: Missing required field in request\n";
                    break;
                case 201:
                    echo "Context: Invalid token provided\n";
                    break;
                case 301:
                    echo "Context: Invalid activation key\n";
                    break;
                case 302:
                    echo "Context: Project is not active or expired\n";
                    break;
                case 305:
                    echo "Context: Activation key already registered\n";
                    break;
                default:
                    echo "Context: Check API logs for more details\n";
            }
        }
    }
    
    // Example data for health check
    echo "\nSending health check...\n";
    $healthResult = $client->sendHealthCheck(
        $anId, 
        $anIp, 
        $activationKey, 
        $cpuLoad, 
        $ramLoad, 
        $logCount, 
        $anToken
    );
    
    if (isset($healthResult['success']) && $healthResult['success']) {
        echo "Health check successful!\n";
        echo "Response: " . json_encode($healthResult, JSON_PRETTY_PRINT) . "\n";
    } else {
        echo "Health check failed!\n";
        echo "Error: " . ($healthResult['error'] ?? 'Unknown error') . "\n";
        echo "Code: " . ($healthResult['code'] ?? 'N/A') . "\n";
        
        // Provide more context based on error codes
        if (isset($healthResult['code'])) {
            switch ($healthResult['code']) {
                case 101:
                    echo "Context: No data received by the API\n";
                    break;
                case 104:
                    echo "Context: Invalid JSON payload after decryption\n";
                    break;
                case 105:
                    echo "Context: Missing required field in request\n";
                    break;
                case 201:
                    echo "Context: Invalid token provided\n";
                    break;
                case 301:
                    echo "Context: Invalid activation key\n";
                    break;
                case 302:
                    echo "Context: Project is not active or expired\n";
                    break;
                case 305:
                    echo "Context: Activation key already registered\n";
                    break;
                default:
                    echo "Context: Check API logs for more details\n";
            }
        }
    }
    
} catch (Exception $e) {
    echo "Error: " . $e->getMessage() . "\n";
    
    // Provide guidance based on common error codes
    $message = $e->getMessage();
    if (strpos($message, '(Code: 201') !== false) {
        echo "Guidance: Verify that the AN_TOKEN in an_client.php matches the one in connection.php\n";
    } else {
        $has301 = strpos($message, '(Code: 301') !== false;
        $has302 = strpos($message, '(Code: 302') !== false;
        $has305 = strpos($message, '(Code: 305') !== false;
        
        if ($has301 || $has302 || $has305) {
            echo "Guidance: Check that the activation key exists in the projects table with status=1 and is_active_an=0\n";
        } elseif (strpos($message, 'HTTP Error: 400') !== false && strpos($message, '(Code: 400') === false) {
            echo "Guidance: The API returned an HTTP 400 error. This usually means there's an issue with the request format or validation.\n";
        }
    }
}
} // End of direct execution check
?>