<?php
require_once 'database/conexion.php';    
//         ../../../Modelo/conexion.php';      
class EncuestaModel
{
    private $db;

    public function __construct()
    {
        // Usamos el método estático de la clase Conexion para obtener la conexión PDO
        $this->db = Conexion::conectar(); // Cambio para PDO
    }

    public function guardarRespuesta($departamento, $cargo, $pregunta, $respuesta)
    {
        // Preparar la consulta SQL con PDO
        $sql = "INSERT INTO encuesta_respuestas (departamento, cargo, pregunta, respuesta) VALUES (:departamento, :cargo, :pregunta, :respuesta)";
        
        // Preparar el statement usando PDO
        $stmt = $this->db->prepare($sql);
        
        // Bindear los parámetros con PDO
        $stmt->bindParam(':departamento', $departamento, PDO::PARAM_STR);
        $stmt->bindParam(':cargo', $cargo, PDO::PARAM_STR);
        $stmt->bindParam(':pregunta', $pregunta, PDO::PARAM_STR);
        $stmt->bindParam(':respuesta', $respuesta, PDO::PARAM_STR);
        
        // Ejecutar la consulta
        $stmt->execute();
        
        // Cerrar el statement
        $stmt->closeCursor(); // En PDO se usa closeCursor() en lugar de close()
    }
}