<?php
// registro.php

// Incluir la clase de conexión
require_once '../Modelo/conexion.php';
$conn = Conexion::conectar();

// Preparar la consulta para obtener los tipos de discapacidad
$query = "SELECT tipo FROM discapacidad ORDER BY tipo ASC";
$stmt = $conn->prepare($query);
if(!$stmt->execute()){
    die("Error en la consulta de discapacidades.");
}
$discapacidades = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registro - Evaluación de Competencias - Modo Accesible</title>
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  
  <!-- CSS personalizados -->
  <link rel="stylesheet" href="../../assets/css/style.css">
  <link rel="stylesheet" href="../../assets/css/accesibilidad.css">
  
  <!-- jQuery, Popper y Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  
  <!-- FontAwesome -->
  <script src="https://kit.fontawesome.com/32a65358fa.js" crossorigin="anonymous"></script>
  
  <!-- Script para mostrar/ocultar contraseña -->
  <script>
    function togglePassword() {
      var pwdField = document.getElementById("pwd");
      pwdField.type = (pwdField.type === "password") ? "text" : "password";
    }
  </script>
  
  <!-- Estilos para el foco en elementos interactivos -->
  <style>
    a:focus, button:focus, input:focus, select:focus, textarea:focus {
      outline: 2px solid #007BFF;
    }
    /* Botón flotante de ayuda accesible (modo voz) */
    .btn-accesible {
      position: fixed;
      bottom: 100px; /* Ubicado arriba de la burbuja de ajustes */
      right: 20px;
      z-index: 1000;
    }
    /* Burbuja de ajustes (botón flotante) */
    .ajustes-burbuja {
      position: fixed;
      bottom: 20px;
      right: 20px;
      width: 60px;
      height: 60px;
      background-color: #0044cc;
      border-radius: 50%;
      box-shadow: 0 4px 8px rgba(0,0,0,0.3);
      display: flex;
      align-items: center;
      justify-content: center;
      color: #fff;
      font-size: 28px;
      cursor: pointer;
      z-index: 1001;
    }
    /* Panel de ajustes de estilo, inicialmente oculto */
    .panel-ajustes {
      position: fixed;
      bottom: 100px;
      right: 20px;
      background-color: #fff;
      border: 2px solid #0044cc;
      border-radius: 10px;
      padding: 15px;
      width: 300px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.3);
      display: none;
      z-index: 1001;
    }
    .panel-ajustes h5 {
      margin-top: 0;
      color: #0044cc;
    }
    .panel-ajustes label {
      font-size: 18px;
      color: #0044cc;
    }
    .panel-ajustes input, 
    .panel-ajustes select {
      margin-bottom: 10px;
      width: 100%;
      padding: 5px;
    }
    /* Temas de color */
    .theme-claro {
      background-color: #ffffff;
      color: #0044cc;
    }
    .theme-oscuro {
      background-color: #222;
      color: #ffffff; /* Texto en blanco para modo oscuro */
    }
    /* Para que el contenido interno herede el color en modo oscuro */
    .theme-oscuro * {
      color: inherit !important;
      background-color: transparent !important;
    }
    .theme-daltonismo {
      background-color: #ffffe0; /* Fondo claro */
      color: #000080; /* Azul oscuro para contraste */
    }
    .theme-amarillo {
      background-color:rgb(255, 247, 0); /* Fondo amarillo */
      color:rgb(0, 0, 0); /* texto oscuro para contraste */
    }
    .theme-amarillo * {
    color: inherit !important;
    background-color: transparent !important;
    }
    .theme-contrasteInvertido {
      background-color:rgb(0, 0, 0); /* Fondo oscuro */
      color: rgb(255, 247, 0); /* texto Amarillo oscuro para contraste */
    }
    .theme-contrasteInvertido * {
    color: inherit !important;
    background-color: transparent !important;
}
  </style>
  
  <!-- Script para cargar ajustes guardados desde localStorage -->
  <script>
    document.addEventListener("DOMContentLoaded", () => {
      // Recuperar configuración de fuente, tamaño, tema y modo accesible
      const savedFontFamily = localStorage.getItem("fontFamily");
      const savedFontSize = localStorage.getItem("fontSize");
      const savedTheme = localStorage.getItem("theme");
      const savedModoAccesible = localStorage.getItem("modoAccesible") === "true";

      if (savedFontFamily) {
        document.body.style.fontFamily = savedFontFamily;
        const fontFamilySelect = document.getElementById("fontFamilySelect");
        if (fontFamilySelect) {
          fontFamilySelect.value = savedFontFamily;
        }
      }
      if (savedFontSize) {
        document.body.style.fontSize = savedFontSize + "px";
        const fontSizeRange = document.getElementById("fontSizeRange");
        const fontSizeValue = document.getElementById("fontSizeValue");
        if (fontSizeRange && fontSizeValue) {
          fontSizeRange.value = savedFontSize;
          fontSizeValue.innerText = savedFontSize;
        }
      }
      if (savedTheme) {
        document.body.classList.remove("theme-claro", "theme-oscuro", "theme-daltonismo");
        document.body.classList.add(savedTheme);
        const themeSelect = document.getElementById("themeSelect");
        if (themeSelect) {
          themeSelect.value = savedTheme;
        }
      }
      // Aplicar el estado del modo accesible
      const toggleButton = document.getElementById("toggleAccesibilidad");
      if (savedModoAccesible) {
        toggleButton.innerText = "Desactivar ayuda para personas con problemas visuales";
      } else {
        toggleButton.innerText = "Activar ayuda para personas con problemas visuales";
      }
      // Guardar el estado en una variable global
      window.modoAccesible = savedModoAccesible;
    });
  </script>
</head>
<body class="theme-claro">
  <!-- Logo y Título -->
  <div class="container-fluid text-center">
    <img src="../assets/imagenes/logo.png" alt="Logo de IncluLab" style="width: 150px; height: auto;">
    <h1 style="font-size: 50px;">IncluLab</h1>
  </div>
  
  <!-- Barra de navegación -->
  <div class="container-fluid bg-light">
    <div class="container">
      <ul class="nav nav-justified py-2 nav-pills">
        <li class="nav-item">
          <a class="nav-link" href="index.php" tabindex="0">Inicio</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="ingreso.php" tabindex="0">Ingreso</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="registro.php" tabindex="0">Registro</a>
        </li>
      </ul>
    </div>
  </div>
  
  <!-- Formulario de Registro Accesible -->
  <div class="container py-5">
    <h2 tabindex="0">Registro de Usuario</h2>
    <form action="../Controlador/registroController.php" method="POST">
      <!-- Campo Nombre -->
      <div class="form-group">
        <label for="nombre" class="font-weight-bold">
          <i class="fa fa-user" aria-hidden="true"></i> Nombre:
        </label>
        <input type="text" class="form-control" id="nombre" name="nombre" 
          placeholder="Ingrese su nombre de usuario para el registro" required tabindex="0" 
          aria-required="true" style="font-size: 22px; padding: 12px;">
      </div>
      
      <!-- Campo Correo Electrónico -->
      <div class="form-group">
        <label for="email" class="font-weight-bold">
          <i class="fa fa-envelope" aria-hidden="true"></i> Correo Electrónico:
        </label>
        <input type="email" class="form-control" id="email" name="email" 
          placeholder="Ingrese su correo para el registro" required tabindex="0" 
          aria-required="true" style="font-size: 22px; padding: 12px;">
      </div>
      
      <!-- Campo Contraseña -->
      <div class="form-group">
        <label for="pwd" class="font-weight-bold">
          <i class="fa fa-lock" aria-hidden="true"></i> Contraseña:
        </label>
        <div class="input-group">
          <input type="password" class="form-control" id="pwd" name="pwd" 
            placeholder="Ingrese una contraseña para el registro (sugerida:12345)" required tabindex="0" 
            aria-required="true" style="font-size: 22px; padding: 12px;">
          <div class="input-group-append">
            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword()" 
              aria-label="Mostrar u ocultar contraseña" tabindex="0">
              <i class="fa fa-eye" aria-hidden="true"></i>
            </button>
          </div>
        </div>
      </div>
      
      <!-- Campo Discapacidad -->
      <div class="form-group">
        <label for="discapacidad" class="font-weight-bold">
          <i class="fa fa-wheelchair" aria-hidden="true"></i> Discapacidad:
        </label>
        <select class="form-control" id="discapacidad" name="discapacidad" tabindex="0" 
          aria-required="true" style="font-size: 22px; padding: 5px;">
          <option value="">Seleccione...</option>
          <?php foreach ($discapacidades as $d): ?>
            <option value="<?php echo htmlspecialchars($d['tipo']); ?>">
              <?php echo htmlspecialchars($d['tipo']); ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>
      
      <!-- Botón de Registro -->
      <button type="submit" class="btn btn-primary btn-lg btn-block" 
        style="font-size: 24px; padding: 14px;" tabindex="0">
        <i class="fa fa-user-plus" aria-hidden="true"></i> Registrar
      </button>
    </form>
  </div>
  <!-- Tus dos archivos JS separados -->
<link rel="stylesheet" href="assets/css/Inicio/accesibilidad.css">

<script src="assets/js/Inicio/accesibilidad.js"></script>

<?php include '../Controlador/accesibilidad.php'; ?>

  <!-- Footer -->
  <?php include '../Vista/Paginas/footer.php'; ?>
</body>
</html>