<div?php
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
// Para este ejercicio, se asume que si el usuario tiene discapacidad visual (id_discapacidad == 1)
// el ejercicio no se muestra.
$esVisual = ($usuarioIdDiscapacidad == 1);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 4 - Evaluación de Competencias</title>
  <link rel="stylesheet" href="/assets/css/style.css">
  <style>
    /* Estilos básicos para imágenes y contenedores */
    .img-option {
      width: 100px;
      height: auto;
      border: 1px solid #ccc;
      margin: 10px;
      border-radius: 4px;
    }
    .img-option-center {
      display: block;
      margin: 20px auto;
      width: 300px;
      height: auto;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    .literal {
      font-size: 32px;
      font-weight: bold;
      color: #0044cc;
      margin-right: 5px;
    }
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
  <!-- EJERCICIO 4: Versión para usuarios sin discapacidad visual -->
  <div class="ejercicio">
    <h2>Ejercicio 4 / Actividades de Evaluación de la Competencia: Organización y Recopilación de la Información</h2>
    
    <!-- 4.1 Analogías verbales -->
    <h3>Analogías verbales</h3>
    <p>
      <strong>Indicación:</strong> A continuación, va a leer (o escuchar) una frase incompleta. 
      Complete la idea descubriendo la relación existente entre las dos palabras. Elija la opción correcta.
    </p>
    <fieldset><p><em>Ejemplo:</em> <strong>DEDO</strong> es a <strong>MANO</strong> como <strong>LADRILLO</strong> es a <strong>MURO</strong>.</p></fieldset>
    <p><em>Elija la opción correcta.</em></p>
    <hr>
    <!-- Nueva analogía -->
    <p><strong>BOTELLA</strong> es a ____ como ____ es a <strong>PLATO</strong></p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="A" required>
          A) CRISTAL – POSTRE
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="B">
          B) VINO – AGUA
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="C">
          C) LIQUIDO – SOLIDO
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="D">
          D) VINO – LENTEJAS
        </label>
      </div>
    </div>
  </div>
  
<!-- Reactivos con dibujos -->
<div class="ejercicio">
  <h3>Reactivos con Dibujos</h3>
  <p>
    <strong>Indicación:</strong> Observe los dibujos, seleccione el nombre correcto a la figura a la que pertenece.<br>
    Imagen 1
  </p>
  <p>
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio4/ejercicio4.2.png" data-lightbox="galeria">
    <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio4/ejercicio4.2.png" 
         alt="Almacén con estanterías" 
         class="img-option-center"
         onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano3/ejercicio4/ejercicio4.2.png';">
  </p>
</a>
    <strong>Indicación:</strong> Seleccione el nombre correcto a la figura a la que pertenece.
  <div class="pregunta">
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta4_Dibujos1" value="A" required>
        A) Material de oficina
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta4_Dibujos1" value="B">
        B) Material de protección personal
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta4_Dibujos1" value="C">
        C) Artículos de carga
      </label>
    </div>
    <div class="opcion">
      <label>
        <input type="radio" name="respuesta4_Dibujos1" value="D">
        D) Bodega
      </label>
    </div>
  </div>
</div>


<?php else: ?>
  <!-- Para usuarios con discapacidad visual -->
  <p style="text-align:center; font-size:24px; color:#0044cc;">
    Este ejercicio no está disponible para usuarios con discapacidad visual.
  </p>
<?php endif; ?>
</body>
</html>
