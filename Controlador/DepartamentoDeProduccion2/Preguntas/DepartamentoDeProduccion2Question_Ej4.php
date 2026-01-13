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
// y la versión original (para auditiva y física) se mostrará cuando el id sea distinto de 1
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
  </style>
</head>
<body>
  <!-- EJERCICIO 4: Analogías verbales -->
  <div class="ejercicio">
    <h2>Ejercicio 4 / Competencia de organización de la información y recopilación de la información</h2>
    
    <!-- 4.1 Analogías verbales -->
    <h3>Analogías verbales</h3>
    <p>
      <strong>Indicación:</strong> A continuación, va a leer (o escuchar) una frase incompleta.  
      Debe completar la idea descubriendo la relación existente entre las dos palabras.  
      Elija la opción correcta.
    </p>
    <fieldset><p><em>Ejemplo:</em> <strong>DEDO</strong> es a <strong>MANO</strong> como <strong>LADRILLO</strong> es a <strong>MURO</strong>.</p>
    <ul>
      <li>a) GUANTE – PINTURA</li>
      <li>b) MANO – LADRILLO</li>
      <li>c) PIE – SUELO</li>
      <li>d) CUERPO – CASA</li>
    </ul>
    <p><strong>Respuesta:</strong> b</p>
    </fieldset>
    
    <hr>
    <!-- Nueva analogía -->
    <p><strong>PISCINA </strong> es a _____ como _____ es a <strong>Gasolina</strong></p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="A" required>
          A) depósito - cisterna
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="B">
          B) agua - depósito
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="C">
          C) verano - invierno
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="D">
          D) líquido – gas
        </label>
      </div>
    </div>
  </div>
   <!-- 4.2 Reactivo con dibujos -->
<p><strong>Reactivo con dibujos:</strong> Observe la imagen y seleccione el nombre correcto para la figura.</p>
<p><em>Imagen 2:</em></p>
<p>
<a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio4/ejercicio4.2.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio4/ejercicio4.2.png" 
       alt="Imagen 2" 
       class="img-option-center"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano1/ejercicio4/ejercicio4.2.png';">
</a>
</p>
<div class="opcion">
  <label><input type="radio" name="respuesta4_2" value="A" required> A) Material de oficina</label>
</div>
<div class="opcion">
  <label><input type="radio" name="respuesta4_2" value="B"> B) Material de protección personal</label>
</div>
<div class="opcion">
  <label><input type="radio" name="respuesta4_2" value="C"> C) Artículos de carga</label>
</div>
<div class="opcion">
  <label><input type="radio" name="respuesta4_2" value="D"> D) Bodega</label>
</div>
<hr>

    <!-- 4.3 Reactivos verbales -->
    <p><strong>Reactivos verbales:</strong> Seleccione la palabra que corresponde al siguiente significado.</p>
    <p><em>Persona que vigila el cumplimiento de las órdenes e instrucciones.</em></p>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_3" value="SUPERVISOR" required> SUPERVISOR</label>
    </div>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_3" value="MAQUINARIA"> MAQUINARIA</label>
    </div>
    <div class="opcion">
      <label><input type="radio" name="respuesta4_3" value="OBREROS"> OBREROS</label>
    </div>
  </div>
 
</body>
</html>
