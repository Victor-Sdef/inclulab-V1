<?php
// AnalistaDeNomina.php
session_start();

// Verificar si el usuario ha iniciado sesión; de lo contrario, redirigir
if (!isset($_SESSION['user'])) {
    header('Location: ../ingreso.php?action=login');
    exit();
}

// Obtener el nombre de usuario desde la sesión (si existe)
$nombreUsuario = isset($_SESSION['user']['nombre']) ? $_SESSION['user']['nombre'] : 'Usuario';
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Evaluación - Departamento de Producción 1</title>
  <!-- Estilos en línea o archivo CSS externo -->
 
</head>
<link rel="stylesheet" href="../../../assets/css/logo.css">
<link rel="stylesheet" href="../../../assets/css/DepartamentoDeTalentoHumano2/DepartamentoDeTalentoHumano2.css">
<link rel="stylesheet" href="../../../assets/css/Inicio/accesibilidad.css">
 <!-- FontAwesome -->
 <script src="https://kit.fontawesome.com/32a65358fa.js" crossorigin="anonymous"></script>


<body>

<!-- Encabezado -->
<link rel="stylesheet" href="../../../assets/css/logo.css">
<div class="header-container1">
    <div class="logo">
      <img src="../../../../assets/imagenes/logo.png" alt="Logo de IncluLab" 
           onerror="this.onerror=null; this.src='/04.PDO-MYSQL-V1/assets/imagenes/logo.png';">
      <h1>IncluLab</h1>
    </div>
    <a href="../../salir.php" class="logout-btn" aria-label="Cerrar sesión">
      <i class="fas fa-sign-out-alt"></i> Cerrar sesión
    </a>
  </div>

  <h1>Evaluación - Departamento de Producción 1 (Supervisor de Mantenimiento electrico)</h1>
  <h2>Bienvenido/a, <?php echo htmlspecialchars($nombreUsuario); ?></h2>

  <div class="form-container">
    <!-- Formulario que agrupa todos los ejercicios -->
    <form id="form-ejercicios" method="POST" onsubmit="enviarFormulario(event)">

      <!-- Campos ocultos con prefijos (departamento, cargo, discapacidad) -->
      <input type="hidden" name="prefijoDepartamento" value="Departamento de Producción 1">
      <input type="hidden" name="prefijoCargo" value="Supervisor de Mantenimiento electrico">
      <input type="hidden" name="prefijoDiscapacidad" value="auditiva">

      <!-- =========================================
           INCLUSIÓN DE EJERCICIOS QUE NECESITAS
           Solo Ejercicio 1 y 4, por ejemplo
      ========================================= -->
      <?php 
        
         include '../../../../Controlador/DepartamentoDeProduccion1/Preguntas/DepartamentoDeProduccion1Question_Ej1.php'; 
         include '../../../../Controlador/DepartamentoDeProduccion1/Preguntas/DepartamentoDeProduccion1Question_Ej2.php'; 
         include '../../../../Controlador/DepartamentoDeProduccion1/Preguntas/DepartamentoDeProduccion1Question_Ej3.php'; 
         include '../../../../Controlador/DepartamentoDeProduccion1/Preguntas/DepartamentoDeProduccion1Question_Ej4.php'; 
         include '../../../../Controlador/DepartamentoDeProduccion1/Preguntas/DepartamentoDeProduccion1Question_Ej5.php'; 
        // include '../../../../Controlador/DepartamentoHumano2/Preguntas/DeapartamentoHumano2Question_Ej6.php'; 
      ?>

      <!-- Si no quieres mostrar Ejercicio 2 o 3, NO incluyas sus archivos. -->

      <hr>
      <button type="submit" class="btn-primary">Enviar Respuestas</button>
    </form>
  </div>

  <!-- Div donde se mostrarán los resultados (respuesta del controlador) -->
  <div id="resultados"></div>

  <!-- agregar un bton que diga realizar encuesta y ara que se abra una ventana de emergencia para realizar dicha encuesta -->
<button id="realizarEncuesta" class="btn btn-primary" onclick="abrirEncuesta()">Realizar Encuesta</button>

<style>
  /* Posiciona el botón en la parte inferior izquierda de la pantalla */
  #realizarEncuesta {
    position: fixed;
    bottom: 20px; /* Ajusta el espacio desde abajo */
    left: 20px;   /* Ajusta el espacio desde la izquierda */
    z-index: 1000; /* Asegura que el botón esté encima de otros elementos */
  }
</style>

<script>
  function abrirEncuesta() {
    // Abre una ventana emergente (popup) con las dimensiones especificadas.
    // Reemplaza 'ruta_encuesta.php' por la URL o ruta que corresponda al formulario de la encuesta.
    window.open('../DepartamentoDeProduccion1Ecuesta.php', 'Encuesta', 'width=6000,height=800');
  }
</script>

<!-- Tus dos archivos JS separados -->
<script src="../../../assets/js/Inicio/accesibilidad.js"></script>

<script src="../../../assets/js/DepartamentoDeProduccion1/DepartamentoDeProduccion1.js"></script>

</body>
</html>