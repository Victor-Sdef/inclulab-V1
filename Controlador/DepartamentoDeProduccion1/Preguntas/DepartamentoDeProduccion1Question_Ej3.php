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

// Asumimos que la discapacidad visual se identifica con el id 1
// y la versión original se mostrará cuando el id sea distinto de 1
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
  <!-- EJERCICIO 3 ADAPTADO PARA LA DISCAPACIDAD VISUAL -->
  <div class="ejercicio">
    <h2>Ejercicio 3 ADAPTADO PARA LA DISCAPACIDAD VISUAL / Actividades de Evaluación de la competencia generación de ideas y pensamiento analítico</h2>
    <p>
      <strong>Indicación:</strong> A continuación, se presentarán 4 "imágenes" que consisten en círculos con ramificaciones. Cada imagen se muestra con fondo blanco y formas en negro para mejorar el contraste, y se acompaña de una descripción en texto.
    </p>
    
    <div class="secuencia">
       <!-- Imagen 1 -->
       <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/ejercicio3.1.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/ejercicio3.1.png" 
           alt="Imagen 1: Recuadro con un círculo con 6 ramificaciones en su interior.
                Imagen 2: Recuadro con un Círculo con 4 ramificaciones en su interior
                Imagen 3: Recuadro con un círculo con 2 ramificaciones en su interior.
                Imagen 4: Recuadro con un signo de pregunta en su interior que debes identificar la opcion correcta." 
           class="img-option-center"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/ejercicio3.1.png';">
      </a>
    </div>

      <strong>Descripción de las imágenes:</strong>
      <ul>
      <p>Imagen 1: Recuadro con un círculo con 6 ramificaciones en su interior.</p>
      <p>Imagen 2: Recuadro con un Círculo con 4 ramificaciones en su interior.</p>
      <p>Imagen 3: Recuadro con un círculo con 2 ramificaciones en su interior.</p>
      <p>Imagen 4: Recuadro con un signo de interrogacion o pregunta en su interior que debes identificar la opcion correcta.</p>
      </ul>
      </a>
    <p><strong>Opciones de Respuesta:</strong></p>

    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="A" required>
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/AA.png" 
                A 
                alt="Opción A" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/AA.png';"> 
          A) Cuarta imagen: Recuadro con un círculo con 4 ramificaciones en su interior.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="B">
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/BB.png" 
               alt="Opción B" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/BB.png';"> 
          B) Cuarta imagen: Recuadro con un círculo con 2 ramificaciones en su interior.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="C">
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/CC.png" 
               alt="Opción C" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/CC.png';"> 
          C) Cuarta imagen: Recuadro con un círculo con 1 ramificación en su interior.
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="D">
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/DD.png" 
               alt="Opción D" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/DD.png';"> 
          D) Cuarta imagen: Recuadro con un círculo sin ramificaciones en su interior.
        </label>
      </div>
    </div>

</ejercicio>
<?php else: ?>
  <!-- EJERCICIO 3 ORIGINAL -->
  <div class="ejercicio">
    <h2>Ejercicio 3 / Actividades de Evaluación de la competencia generación de ideas y pensamiento analítico</h2>
    <p>
      <strong>Indicación:</strong> Va a observar una serie de imágenes que siguen un patrón de secuencia. 
      Descubra el patrón y elija la imagen que falta para completar la secuencia.
    </p>
    <!-- Muestra de la secuencia -->
    <div class="secuencia">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/ejercicio3.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/ejercicio3.png" 
           A
           accesskey=""alt="Secuencia 1" 
           class="img-option-center"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/ejercicio3.png';"> 
    </a>  
    <p><strong>Opciones de Respuesta:</strong></p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="A" required>
          A
          <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/A.png" data-lightbox="galeria">
          <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/A.png" 
               alt="Opción A" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/A.png';">
        </label>
      </a>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3" value="B">
          B
          <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/B.png" data-lightbox="galeria">
          <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/B.png" 
               alt="Opción B" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/B.png';">
        </label>
      </a>
      </div>
      <div class="opcion">
        <label>
          C
          <input type="radio" name="respuestaE3" value="C">
          <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/C.png" data-lightbox="galeria">
          <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/C.png" 
               alt="Opción C" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/C.png';">
        </label>
      </a>
      </div>
      <div class="opcion">
        <label>
          D
          <input type="radio" name="respuestaE3" value="D">
          <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/D.png" data-lightbox="galeria">
          <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/D.png" 
               alt="Opción D" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano2/ejercicio3/literales/D.png';">
        </label>
      </a>
      </div>
    </div>
  </div><?php endif; ?>
</body>
</html>