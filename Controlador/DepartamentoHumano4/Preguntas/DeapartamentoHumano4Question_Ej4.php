<?php
// Verificar si la sesión no está iniciada antes de llamarla
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

require_once '../../../../Modelo/conexion.php';

// Verificar que el usuario haya iniciado sesión
$id_usuario = $_SESSION['user']['id_usuario'] ?? null;
if (!$id_usuario) {
    header('Location: ../../../ingreso.php?action=login');
    exit();
}

// Obtener el id de discapacidad del usuario desde la sesión
$usuarioIdDiscapacidad = $_SESSION['user']['id_discapacidad'] ?? null;

// Si
// Si el usuario tiene discapacidad visual (id_discapacidad == 1), no mostramos este ejercicio.
$esVisual = ($usuarioIdDiscapacidad == 4);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 1 - Evaluación de Competencias</title>
  <link rel="stylesheet" href="/assets/css/style.css">
  <style>
    /* Puedes incluir aquí estilos específicos para el ejercicio */
    .ejercicio {
      margin-bottom: 40px;
      padding: 20px;
      border: 2px solid #0044cc;
      border-radius: 10px;
      background-color: #e3f2fd;
    }
    .pregunta {
      margin: 15px 0;
      padding: 15px;
      background-color: #fff;
      border: 1px dashed #0044cc;
      border-radius: 8px;
    }
    .opcion {
      margin: 10px 0;
      padding: 10px;
      background-color: #f1f8e9;
      border: 1px solid #c5e1a5;
      border-radius: 8px;
    }
    .opcion label {
      font-size: 32px;
      color: #0044cc;
    }
  </style>
</head>
<body>
<?php if(!$esVisual): ?>
  
<?php endif; ?>
</body>
</html>
