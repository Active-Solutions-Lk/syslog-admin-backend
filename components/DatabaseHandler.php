<?php
// DatabaseHandler.php
class DatabaseHandler
{
    public static function registerCollector($pdo, $col_id, $col_ip)
    {
        $stmt = $pdo->prepare("INSERT INTO collectors (id, ip, is_active, updated_at) VALUES (?, ?, 1, NOW()) ON DUPLICATE KEY UPDATE ip = VALUES(ip), is_active = 1, updated_at = NOW()");
        $stmt->execute([$col_id, $col_ip]);
    }
    
    public static function linkCollectorToProject($pdo, $col_id, $project_id)
    {
        $stmt = $pdo->prepare("UPDATE projects SET collector_ip = ? WHERE id = ?");
        $stmt->execute([$col_id, $project_id]);
    }
    
    public static function checkCollectorExists($pdo, $col_ip, $col_id)
    {
        $stmt = $pdo->prepare("SELECT id FROM collectors WHERE ip = ? AND id = ? LIMIT 1");
        $stmt->execute([$col_ip, $col_id]);
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

}