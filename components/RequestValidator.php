<?php
// RequestValidator.php
class RequestValidator
{
    public static function validateRequiredFields($data, $requiredFields)
    {
        foreach ($requiredFields as $field) {
            if (!isset($data[$field]) || $data[$field] === '') {
                throw new Exception("Missing field: $field", 105);
            }
        }
    }
    
    public static function validateRequestType($type, $allowedTypes = null)
    {
        if ($allowedTypes === null) {
            // Default to collector types if no allowed types specified
            $allowedTypes = ['coll-reg', 'coll-health'];
        }
        
        if (!in_array($type, $allowedTypes, true)) {
            throw new Exception('Invalid type', 106);
        }
    }
    
    public static function validateToken($token, $expectedToken)
    {
        if ($token !== $expectedToken) {
            throw new Exception('Invalid token', 201);
        }
    }
    
    public static function validateActivationKey($pdo, $activationKey, $forCollector = true, $requestType = 'coll-reg')
    {
        if ($forCollector) {
            $stmt = $pdo->prepare("SELECT id, status, is_active_coll FROM projects WHERE activation_key = ? LIMIT 1");
        } else {
            $stmt = $pdo->prepare("SELECT id, status, is_active_an FROM projects WHERE activation_key = ? LIMIT 1");
        }
        
        $stmt->execute([$activationKey]);
        $project = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$project) {
            throw new Exception('Invalid activation key', 301);
        }
        
        if ($project['status'] != 1) {
            throw new Exception('Project is not active or expired', 302);
        }
        
        // Check if the activation key is already used for the specific component type
        // Only check for duplicate registration on registration requests, not health checks
        if ($forCollector && $requestType === 'coll-reg') {
            // For collector registration, check if is_active_coll is already set to 1
            if ($project['is_active_coll'] == 1) {
                throw new Exception('Activation key already registered for collector', 305);
            }
        } elseif (!$forCollector && $requestType === 'an-reg') {
            // For analyzer registration, check if is_active_an is already set to 1
            if ($project['is_active_an'] == 1) {
                throw new Exception('Activation key already registered for analyzer', 305);
            }
        }
        
        return $project;
    }
}