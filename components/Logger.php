<?php
// Logger.php
class Logger
{
    public static function logRejection($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, $description, $logProjectId = null)
    {
        try {
            $stmt = $pdo->prepare("INSERT INTO api_logs (project_id, cpu_status, ram_status, log_count, type, device_count, last_login_date, description, created_at, updated_at) VALUES (?, ?, ?, ?, ?, 0, NOW(), ?, NOW(), NOW())");
            $stmt->execute([$logProjectId ?? $project_id, $cpu_count, $ram_usage, $log_count, $type, $description]);
        } catch (Exception $e) {
            // Log error but continue with response
        }
    }
    
    public static function logSuccess($pdo, $project_id, $cpu_count, $ram_usage, $log_count, $type, $description)
    {
        try {
            $stmt = $pdo->prepare("INSERT INTO api_logs (project_id, cpu_status, ram_status, log_count, type, device_count, last_login_date, description, created_at, updated_at) VALUES (?, ?, ?, ?, ?, 0, NOW(), ?, NOW(), NOW())");
            $stmt->execute([$project_id, $cpu_count, $ram_usage, $log_count, $type, $description]);
        } catch (Exception $e) {
            // Log error but continue with response
        }
    }
}