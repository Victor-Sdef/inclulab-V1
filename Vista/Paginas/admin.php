<?php
session_start();
if (!isset($_SESSION['user'])) {
    header('Location: ../ingreso.php?action=login');
    exit();
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Admin - Panel de Administración</title>
  <!-- Importa tu CSS global si lo tienes -->
  <link rel="stylesheet" href="/assets/css/inicio.css">
  <!-- Estilos específicos para el panel de administración -->
  <style>
    /* Fuente personalizada (opcional, se puede usar Google Fonts) */
    @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap');

    body {
      font-family: 'Roboto', sans-serif;
      background: linear-gradient(135deg, #f8f9fa, #e3f2fd);
      margin: 0;
      padding: 0;
    }

    .admin-container {
      max-width: 800px;
      margin: 60px auto;
      padding: 40px 20px;
      background-color: #ffffff;
      border: 1px solid #0044cc;
      border-radius: 15px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
      text-align: center;
    }

    .admin-container h1 {
      font-size: 3rem;
      color: #0044cc;
      margin-bottom: 40px;
      text-transform: uppercase;
      letter-spacing: 1px;
    }

    .admin-option {
      display: inline-block;
      margin: 20px 15px;
      padding: 20px 30px;
      border: 2px solid #0044cc;
      border-radius: 10px;
      background-color: #f1f8e9;
      color: #0044cc;
      font-size: 1.8rem;
      text-decoration: none;
      transition: all 0.3s ease;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .admin-option:hover {
      background-color: #dcedc8;
      color: #003399;
      transform: translateY(-3px);
      box-shadow: 0 8px 12px rgba(0,0,0,0.15);
    }
  </style>
</head>
<body>
  <!-- Barra superior -->
  <div class="admin-container">
    <h1>Panel de Administración</h1>
    <a href="admin/usuarios.php" class="admin-option">Usuarios</a>
    <a href="admin/preguntas.php" class="admin-option">Preguntas</a>
    <a href="salir.php" class="admin-option">Salir</a>
  </div>
</body>
</html>