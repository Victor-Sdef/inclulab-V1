<?php

class Conexion
{
    // Método estático para establecer la conexión a la base de datos
    static public function conectar()
    {
        try {
            $link = new PDO(
                "mysql:host=127.0.0.1;dbname=inclulab",
                "root",
                ""
            );
            $link->exec("set names utf8");
            return $link;
        } catch (PDOException $e) {
            die("Conexión fallida: " . $e->getMessage());
        }
    }
}