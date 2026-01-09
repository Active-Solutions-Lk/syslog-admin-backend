<?php
// ResponseBuilder.php
class ResponseBuilder
{
    public static function error($message, $code)
    {
        http_response_code(400);
        return json_encode(['success' => false, 'error' => $message, 'code' => $code]);
    }
    
    public static function success($message, $project_id, $collector_id, $type, $additionalData = [])
    {
        $response = [
            'success' => true,
            'message' => $message,
            'project_id' => $project_id,
            'collector_id' => $collector_id,
            'type' => $type,
            'timestamp' => date('c')
        ];
        
        foreach ($additionalData as $key => $value) {
            $response[$key] = $value;
        }
        
        return json_encode($response);
    }
}