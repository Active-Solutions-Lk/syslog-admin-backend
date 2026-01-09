<?php
// connection.php

// Database configuration
define('DB_HOST', 'localhost');
define('DB_USER', 'root');          // change to your DB user
define('DB_PASS', '');              // change to your DB password
define('DB_NAME', 'remote_admin');

// Static token - THIS MUST MATCH THE ONE USED ON CLIENT SIDE
define('STATIC_TOKEN', 'I3UYA2HSQPB86XpsdVUb9szDu5tn2W3fOpg8'); // Secret Key for collector requests
define('AN_TOKEN','I3UYA2HSQPB86XpsdVUb9szDu5tn2W3fOpg8'); // Secret Key for analyzer requests

// Create PDO connection
try {
    $pdo = new PDO(
        "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4",
        DB_USER,
        DB_PASS,
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Database connection failed']);
    exit;
}
?>