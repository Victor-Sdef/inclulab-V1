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

// Si/ Asumimos que la discapacidad visual se identifica con el id 2 
// y la versión original se mostrará cuando el id sea distinto de 2
$esVisual = ($usuarioIdDiscapacidad == 1);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 3 - Evaluación de Competencias</title>
  <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
<?php if($esVisual): ?>
  <!-- Para usuarios con discapacidad visual -->
 <p style="text-align:center; font-size:24px; color:#0044cc;">
    Este ejercicio no está disponible para usuarios con discapacidad visual.
  </p>



<?php else: ?>
 
 <!-- EJERCICIO 3 ADAPTADO PARA LA DISCAPACIDAD VISUAL -->
<div class="ejercicio">
  <h1>Ejercicio 3 - Evaluación de Competencias generación de ideas y pensamiento analítico</h1>
  <h1>Reactivo de matrices</h1>
  <h2>Ejercicio 3 ADAPTADO PARA LA DISCAPACIDAD VISUAL </h2>
  <p>
    <strong>Indicación:</strong> A continuación, se presentarán 4 "imágenes" que consisten en círculos con ramificaciones. Cada imagen se muestra con fondo blanco y formas en negro para mejorar el contraste, y se acompaña de una descripción en texto.
  </p>
  
  <div class="secuencia">
    <!-- Imagen 1 con fallback -->
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/ejercicio3.1.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/ejercicio3.1.png" 
         alt="Imagen 1: Círculo con 6 ramificaciones" 
         class="img-option-center"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/ejercicio3.1.png';">
  </div>
</a>
 
  <p><strong>Opciones de Respuesta:</strong></p>

  <div class="pregunta">
    <div class="opcion">
      <label>
        A
        <input type="radio" name="respuestaE3" value="A" required>
        <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/A.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/A.png" 
             alt="Opción A" 
             class="img-option"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/A.png';"> 
      </label>
</a>
    </div>
    <div class="opcion">
      <label>
        B
        <input type="radio" name="respuestaE3" value="B">
        <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/B.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/B.png" 
             alt="Opción B" 
             class="img-option"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/B.png';"> 
      </label>
</a>
    </div>
    <div class="opcion">
      <label>
        C
        <input type="radio" name="respuestaE3" value="C">
        <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/C.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/C.png" 
             alt="Opción C" 
             class="img-option"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/C.png';"> 
      </label>
</a>
    </div>
    <div class="opcion">
      <label>
        D
        <input type="radio" name="respuestaE3" value="D">
        <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/D.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/D.png" 
             alt="Opción D" 
             class="img-option"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio3/literales3.1/D.png';"> 
      </label>
</a>
    </div>
  </div>
</div>

    <?php endif; ?>