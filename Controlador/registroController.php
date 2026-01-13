<?php
// registroController.php

// Activa la visualización de errores para depuración (opcional en producción)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Incluir la clase de conexión (ajusta la ruta según tu estructura)
require_once '../Modelo/conexion.php';

// Establecer la conexión usando PDO
$conn = Conexion::conectar();

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Recoger y sanitizar los datos del formulario
    $nombre = isset($_POST['nombre']) ? trim($_POST['nombre']) : '';
    $email = isset($_POST['email']) ? strtolower(trim($_POST['email'])) : '';
    $pwd = isset($_POST['pwd']) ? password_hash(trim($_POST['pwd']), PASSWORD_DEFAULT) : '';
    // Se asume que en el formulario se envía el tipo de discapacidad (por ejemplo, 'visual')
    $discapacidad_input = (isset($_POST['discapacidad']) && !empty($_POST['discapacidad'])) ? trim($_POST['discapacidad']) : '';

    // Buscar en la tabla discapacidad el id correspondiente al tipo enviado
    $sql_disc = "SELECT id_discapacidad FROM discapacidad WHERE tipo = :tipo LIMIT 1";
    $stmt_disc = $conn->prepare($sql_disc);
    $stmt_disc->bindParam(':tipo', $discapacidad_input, PDO::PARAM_STR);
    $stmt_disc->execute();
    $id_discapacidad = $stmt_disc->fetchColumn();

    // Si no se encontró el tipo, se puede asignar un valor por defecto (por ejemplo, 0 o detener la ejecución)
    if (!$id_discapacidad) {
        echo "<script>
                alert('El tipo de discapacidad no es válido.');
                window.location.href='../Vista/registro.php';
              </script>";
        exit();
    }

    // Verificar si el correo o el nombre ya están registrados
    $checkSql = "SELECT COUNT(*) FROM usuarios WHERE email = :email OR nombre = :nombre";
    $checkStmt = $conn->prepare($checkSql);
    $checkStmt->bindParam(':email', $email, PDO::PARAM_STR);
    $checkStmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
    $checkStmt->execute();
    $count = $checkStmt->fetchColumn();

    if ($count > 0) {
        echo "<script>
                if (confirm('El correo o el nombre ya están registrados. ¿Desea ingresar datos diferentes?')) {
                    window.location.href='../Vista/registro.php';
                } else {
                    window.location.href='../Vista/index.php';
                }
              </script>";
        exit();
    }

    // Asignar valores predeterminados para un nuevo registro
    // Por ejemplo: 
    //   id_estado = 3 (activo) 
    //   id_estado_rol = 2 (usuario)
    $id_estado = 3;      
    $id_estado_rol = 2;  

    // Preparar la consulta SQL para insertar en la tabla usuarios
    $sql = "INSERT INTO usuarios (nombre, email, password, id_discapacidad, id_estado, id_estado_rol) 
            VALUES (:nombre, :email, :password, :id_discapacidad, :id_estado, :id_estado_rol)";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':nombre', $nombre, PDO::PARAM_STR);
    $stmt->bindParam(':email', $email, PDO::PARAM_STR);
    $stmt->bindParam(':password', $pwd, PDO::PARAM_STR);
    $stmt->bindParam(':id_discapacidad', $id_discapacidad, PDO::PARAM_INT);
    $stmt->bindParam(':id_estado', $id_estado, PDO::PARAM_INT);
    $stmt->bindParam(':id_estado_rol', $id_estado_rol, PDO::PARAM_INT);

    if ($stmt->execute()){
        echo "<script>
                alert('Registro exitoso');
                window.location.href='../Vista/index.php';
              </script>";
        exit();
    } else {
        $errorInfo = $stmt->errorInfo();
        echo "<script>
                alert('Error: " . addslashes($errorInfo[2]) . "');
                window.location.href='../Vista/registro.php';
              </script>";
        exit();
    }
} else {
    header("Location: ../Vista/registro.php");
    exit();
}
?>