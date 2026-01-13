<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Ingreso - Evaluación de Competencias - Modo Accesible</title>
  
  <!-- Import de style.css -->
  <link rel="stylesheet" href="../../assets/css/style.css">
  <link rel="stylesheet" href="../../assets/css/accesibilidad.css">
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  
  <!-- jQuery library -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
  
  <!-- Popper JS -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  
  <!-- FontAwesome -->
  <script src="https://kit.fontawesome.com/32a65358fa.js" crossorigin="anonymous"></script>
  
    <style>
      /* Estilo para elementos en foco */
      a:focus, button:focus, input:focus, select:focus, textarea:focus {
        outline: 2px solid #007BFF;
      }
      /* Estilos para el botón de modo accesible (ubicado arriba de la burbuja de ajustes) */
      .btn-accesible {
        position: fixed;
        bottom: 100px;
        right: 20px;
        z-index: 1000;
      }
      /* Estilos para la burbuja de ajustes (botón flotante) */
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
  
  <!-- Atajos de teclado -->
  <script>
    document.addEventListener('keydown', function(e) {
      if (e.altKey) { 
        switch(e.key.toLowerCase()){
          case 'i':
            window.location.href = 'index.php';
            break;
          case 'r':
            window.location.href = 'registro.php';
            break;
          case 'h':
            window.location.href = 'index.php';
            break;
        }
      }
    });
  </script>
  
  <!-- Script para mostrar/ocultar contraseña -->
  <script>
    function togglePassword() {
      var pwdField = document.getElementById("pwd");
      pwdField.type = (pwdField.type === "password") ? "text" : "password";
    }
  </script>
</head>
<body class="theme-claro">
  <!-- Contenido de la página (logo, menú, etc.) -->
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
          <a class="nav-link active" href="ingreso.php" tabindex="0">Ingreso</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="registro.php" tabindex="0">Registro</a>
        </li>
      </ul>
    </div>
  </div>

  <!-- Formulario de Ingreso -->
  <div class="container py-5">
    <h2 tabindex="0">Ingreso de Usuario</h2>
    <form action="../Controlador/ingresoController.php" method="POST">
      <!-- Campo Correo -->
      <div class="form-group">
        <label for="login" class="font-weight-bold">
          <i class="fa fa-envelope" aria-hidden="true"></i> Correo Electrónico:
        </label>
        <input type="text" class="form-control" id="login" name="login" 
          placeholder="Ingrese el mismo correo electrónico registrado" required tabindex="0" 
          aria-required="true" aria-describedby="emailHelp" 
          style="font-size: 22px; padding: 12px;">
        <small id="emailHelp" class="form-text text-muted">Ejemplo: usuario@correo.com</small>
      </div>
      
      <!-- Campo Contraseña -->
      <div class="form-group">
        <label for="pwd" class="font-weight-bold">
          <i class="fa fa-lock" aria-hidden="true"></i> Contraseña:
        </label>
        <div class="input-group">
          <input type="password" class="form-control" id="pwd" name="pwd" 
            placeholder="Ingrese la misma contraseña registrada(12345)" required tabindex="0" 
            aria-required="true" style="font-size: 22px; padding: 12px;">
          <div class="input-group-append">
            <button class="btn btn-outline-secondary" type="button" onclick="togglePassword()" 
              aria-label="Mostrar u ocultar contraseña" tabindex="0">
              <i class="fa fa-eye" aria-hidden="true"></i>
            </button>
          </div>
        </div>
      </div>
      
      <!-- Recordarme -->
      <div class="form-group form-check">
        <input type="checkbox" class="form-check-input" id="remember" tabindex="0">
        <label class="form-check-label" for="remember">Recordarme</label>
      </div>
      
      <!-- Botón de Ingreso -->
      <button type="submit" class="btn btn-primary btn-lg btn-block" 
        style="font-size: 24px; padding: 14px;" tabindex="0">
        <i class="fa fa-sign-in" aria-hidden="true"></i> Ingresar
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