<?php
session_start();

// Vaciar el array de sesión
$_SESSION = array();

// Si se usa cookie para la sesión, se borra la cookie también
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Destruir la sesión
session_destroy();

// Redirigir a la página de inicio
echo '<script> window.location = "../index.php?pagina=inicio"; </script>';
?>
