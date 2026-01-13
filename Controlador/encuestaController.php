<?php
require_once 'Modelo/encuestaModel.php';

class EncuestaController
{
    public function mostrarFormulario()
    {
        require 'views/encuesta.php';
    }

    public function procesarFormulario()
    {
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            $modelo = new EncuestaModel();

            $departamento = $_POST['departamento'];
            $cargo = $_POST['cargo'];

            unset($_POST['departamento'], $_POST['cargo']);

            foreach ($_POST as $pregunta => $respuesta) {
                $modelo->guardarRespuesta($departamento, $cargo, $pregunta, $respuesta);
            }

            // Puedes redirigir a una página de éxito o resultado
            header("Location: /views/resultado.php");
        }
    }
}
