<?php
session_start(); // Iniciar la sesión

// Activa la visualización de errores para depuración (desactívala en producción)
error_reporting(E_ALL);
ini_set('display_errors', 1);

// Incluir la clase de conexión (ajusta la ruta según tu estructura)
require_once '../Modelo/conexion.php';

// Establecer la conexión usando PDO
$conn = Conexion::conectar();

// Verificar que se haya enviado el formulario (método POST)
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // Recoger y sanitizar los datos del formulario
    // 'login' puede ser el nombre o el correo del usuario
    $login = isset($_POST['login']) ? trim($_POST['login']) : '';
    $pwd   = isset($_POST['pwd'])   ? trim($_POST['pwd'])   : '';

    // Consulta para buscar un usuario cuyo correo o nombre coincida
    $sql = "SELECT * FROM usuarios WHERE email = :login OR nombre = :login LIMIT 1";
    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':login', $login, PDO::PARAM_STR);
    $stmt->execute();
    $user = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        // Verificar la contraseña
        if (password_verify($pwd, $user['password'])) {
            // Contraseña correcta, iniciar sesión
            $_SESSION['user'] = $user; // Almacenar los datos del usuario en sesión

            // Revisar la columna 'id_estado_rol' para redirigir según rol
            // Asegúrate de que en tu base de datos:
            // 1 = Admin, 2 = Usuario (o los valores que tú hayas definido)
            if ($user['id_estado_rol'] == 1) {
                // Es admin
                header("Location: ../Vista/Paginas/admin.php");
                exit();
            } elseif ($user['id_estado_rol'] == 2) {
                // Es usuario
                header("Location: ../Vista/Paginas/inicio.php");
                exit();
            } else {
                // Si el valor es diferente a 1 o 2, se maneja otro caso
                echo "<script>
                        alert('Estado de usuario no reconocido');
                        window.location.href='../Vista/ingreso.php';
                      </script>";
                exit();
            }
        } else {
            // Contraseña incorrecta
            echo "<script>
                    alert('Contraseña incorrecta');
                    window.location.href='../Vista/ingreso.php';
                  </script>";
            exit();
        }
    } else {
        // No se encontró usuario con ese login
        echo "<script>
                alert('No se encontró un usuario con ese nombre o correo');
                window.location.href='../Vista/ingreso.php';
              </script>";
        exit();
    }
}
?>
