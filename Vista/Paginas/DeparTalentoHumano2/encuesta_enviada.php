<?php
session_start();
if (!isset($_SESSION['user'])) {
    header('Location: ../../../ingreso.php?action=login');
    exit();
}

$nombreUsuario = $_SESSION['user']['nombre'] ?? 'Usuario';
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Encuesta Enviada</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            background: #f0f8ff;
            font-family: 'Segoe UI', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .mensaje-container {
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 16px rgba(0, 123, 255, 0.1);
            text-align: center;
            max-width: 500px;
        }

        h1 {
            color: #007BFF;
            margin-bottom: 20px;
        }

        p {
            font-size: 1.1em;
            color: #555;
        }

        .boton-regresar {
            display: inline-block;
            margin-top: 30px;
            padding: 12px 24px;
            font-size: 1em;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 8px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .boton-regresar:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="mensaje-container">
    <h1>¡Gracias, <?php echo htmlspecialchars($nombreUsuario); ?>! ✔️✔️</h1>
    <p>Tu encuesta ha sido guardada exitosamente.<br>
    Agradecemos tu tiempo y tu postulación!!'.</p>

    <a href="../inicio.php" class="boton-regresar">Volver al Panel</a>
</div>

</body>
</html>