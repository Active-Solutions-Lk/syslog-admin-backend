<?php
// EncryptionHandler.php
class EncryptionHandler
{
    public static function decryptData($encryptedB64, $token)
    {
        $key = hash('sha256', $token, true);
        $ivLength = openssl_cipher_iv_length('aes-256-cbc');
        
        $encryptedData = base64_decode($encryptedB64, true);
        if ($encryptedData === false || strlen($encryptedData) < $ivLength + 1) {
            throw new Exception('Invalid encrypted data format', 102);
        }
        
        $iv = substr($encryptedData, 0, $ivLength);
        $ciphertext = substr($encryptedData, $ivLength);
        
        $decrypted = openssl_decrypt($ciphertext, 'aes-256-cbc', $key, OPENSSL_RAW_DATA, $iv);
        if ($decrypted === false) {
            throw new Exception('Decryption failed – wrong token or corrupted data', 103);
        }
        
        return $decrypted;
    }
}