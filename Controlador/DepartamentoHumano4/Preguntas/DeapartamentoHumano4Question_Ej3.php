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
// Si el usuario tiene discapacidad visual (por ejemplo, id_discapacidad == 4) no mostramos el ejercicio.
$esVisual = ($usuarioIdDiscapacidad == 4);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Ejercicio 1 - Evaluación de Competencias</title>
  <link rel="stylesheet" href="/assets/css/style.css">
  <style>

    
   /* ================================
   Estilos amigables para niños
   ================================ */

/* Recuadros de ejercicios y preguntas */
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
  background-color: #FFFACD; /* Fondo amarillo claro para preguntas */
  border: 1px dashed #0044cc;
  border-radius: 8px;
  text-align: center;
}

/* Opciones de respuesta */
.opcion {
  margin: 10px 0;
  padding: 10px;
  background-color: #FFFACD;
  border: 1px solid #c5e1a5;
  border-radius: 8px;
}

.opcion label {
  font-size: 32px;
  color: #0044cc;
  display: block;
  text-align: left;
}

/* Imágenes */
.img-option-center {
  display: block;
  margin: 20px auto;
  max-width: 300px;
  height: auto;
  border: 1px solid #ccc;
  border-radius: 4px;
}

/* ================================
   Estilos para grid 2×2 de imágenes
   ================================ */
.grid-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
  max-width: 500px;
  margin: 20px auto;
  text-align: center;
}

.grid-item {
  background-color: #FFFACD; /* Fondo amarillo claro */
  padding: 10px;
  border: 2px solid #FFA07A;  /* Borde LightSalmon */
  border-radius: 10px;
}

.grid-item img {
  width: 100%;
  height: auto;
  border: none;
}

.grid-item p {
  margin-top: 10px;
  font-size: 1.5em;
  color: #0044cc;
}


  </style>
</head>
<body>
<?php if(!$esVisual): ?>
  <!-- Aquí se incluirían otras secciones (Ejercicio 1, Ejercicio 2, etc.) si ya están en otros archivos -->
  
  <!-- ===================================================== -->
  <!-- SECCIÓN: EJERCICIO 3 - Organización y Recopilación de la Información -->
  <!-- ===================================================== -->
  <div class="ejercicio">
    <h2>Ejercicio 3 / Competencia: Organización y Recopilación de la Información</h2>
    
    <!-- Pregunta 1: Analogías verbales -->
    <div class="pregunta">
      <p><strong>1) Analogías verbales </strong></p>
      <p><strong>Indicación:</strong> Complete la siguiente frase incompleta descubriendo la relación entre las palabras.  
         <fieldset>Ejemplo: <strong>DEDO</strong> es a <strong>MANO</strong> como <strong>LADRILLO</strong> es a <strong>MURO</strong></fieldset>
      </p>
      <p><strong>……... es a AGUA DULCE como MAR es a ....</strong></p>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Analogias" value="A" required>
          A) azúcar - agua salada
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Analogias" value="B">
          B) río - olas
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Analogias" value="C">
          C) lago - agua salada
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Analogias" value="D">
          D) lago – sal
        </label>
      </div>
    </div>
    
    <hr>
    
    <!-- Pregunta 2: Reactivos con Dibujos -->
    <?php if ($usuarioIdDiscapacidad != 1): ?>
      
      <div class="pregunta">
  <p><strong>2) Reactivos con Dibujos </strong></p>
  <p><strong>Indicación:</strong> Observe la imagen y seleccione el nombre correcto a la figura a la que pertenece.</p>
  <p><strong>Imagen:</strong></p>
  <!-- Imagen con URL de respaldo en caso de error -->
  <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/ejercicio4.1.png" data-lightbox="galeria">
  <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/ejercicio4.1.png" 
       alt="Imagen de ejemplo" 
       class="img-option-center"
       onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/ejercicio4.1.png';">
    </a>
       <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="A" required>
      A) Material de oficina
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="B">
      B) Material de protección personal
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="C">
      C) Artículos de carga
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="D">
      D) Bodega
    </label>
  </div>
</div>
    <?php else: ?>
</style>

      
      <div class="pregunta">
  <p style="text-align:center; color:#0044cc; font-size:18px;">
    Adaptación para usuarios con discapacidad visual:
  </p>
  <p><strong>2) Reactivos con Dibujos</strong></p>
  <p><strong>Indicación:</strong> Se describirán elementos que corresponden a un departamento. Analice y determine a qué departamento pertenecen dichos elementos.</p>
  <p><strong>Imagen:</strong></p>
  <div class="grid-container">
    <div class="grid-item">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/A.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/A.png" 
           alt="Palets" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/A.png';">
      <p>Palets</p>
    </a>
    </div>
    <div class="grid-item">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/B.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/B.png" 
           alt="Camión" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/B.png';">
      <p>Camión</p>
    </a>
    </div>
    <div class="grid-item">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/C.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/C.png" 
           alt="Carro de plataforma" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/C.png';">
      <p>Carro de plataforma</p>
    </a>
    </div>
    <div class="grid-item">
    <a href="../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/D.png" data-lightbox="galeria">
      <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/D.png" 
           alt="Montacarga" 
           class="img-option"
           onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeTalentoHumano4/ejercicio4/literales/D.png';">
      <p>Montacarga</p>
    </a>
    </div>
  </div>
  <!-- Luego las opciones de respuesta -->
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="A" required>
      A) Material de oficina
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="B">
      B) Material de protección personal
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="C">
      C) Artículos de carga
    </label>
  </div>
  <div class="opcion">
    <label>
      <input type="radio" name="respuestaE3_Dibujos" value="D">
      D) Bodega
    </label>
  </div>
</div>
    <?php endif; ?>
    
    <hr>
    
    <!-- Pregunta 3: Reactivo verbal (sin condición) -->
    <div class="pregunta">
      <p><strong>3) Reactivo verbal</strong></p>
      <p><strong>Indicación:</strong> Se le presenta el siguiente significado. Elija la palabra correcta que lo describa.</p>
      <p><strong>Persona que tiene como función principal la de vigilar el cumplimiento de las órdenes e instrucciones:</strong></p>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Verbal" value="SUPERVISOR" required>
          SUPERVISOR
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Verbal" value="MAQUINARIA">
          MAQUINARIA
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuestaE3_Verbal" value="OBREROS">
          OBREROS
        </label>
      </div>
     
    </div>
  </div>
<?php endif; ?>
</body>
</html>
