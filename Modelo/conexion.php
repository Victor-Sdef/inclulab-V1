<?php

class Conexion
{
    // Método estático para establecer la conexión a la base de datos
    static public function conectar()
    {
        // Variables de entorno para producción (Render + freesqldatabase.com)
        // Configura estas variables en el panel de Render:
        // DB_HOST, DB_NAME, DB_USER, DB_PASS, DB_PORT
        
        $host = getenv('DB_HOST') ?: '127.0.0.1';
        $dbname = getenv('DB_NAME') ?: 'inclulab';
        $user = getenv('DB_USER') ?: 'root';
        $pass = getenv('DB_PASS') ?: '';
        $port = getenv('DB_PORT') ?: '3306';

        try {
            $link = new PDO(
                "mysql:host={$host};port={$port};dbname={$dbname}",
                $user,
                $pass
            );
            $link->exec("set names utf8");
            $link->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $link;
        } catch (PDOException $e) {
            die("Conexión fallida: " . $e->getMessage());
        }
    }
}