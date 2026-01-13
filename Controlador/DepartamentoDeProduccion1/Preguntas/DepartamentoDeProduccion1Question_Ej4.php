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
    <fieldset>
    <p><em>Ejemplo:</em> <strong>DEDO</strong> es a <strong>MANO</strong> como <strong>LADRILLO</strong> es a <strong>MURO</strong>.</p>
    </fieldset>

    <ul>
      <li>a) GUANTE – PINTURA</li>
      <li>b) MANO – LADRILLO</li>
      <li>c) PIE – SUELO</li>
      <li>d) CUERPO – CASA</li>
    </ul>
    <p><strong>Respuesta:</strong> b</p>
    
    <hr>
    <!-- Nueva analogía -->
    <p><strong>_____</strong> es a AGUA DULCE como MAR es a <strong>_____</strong></p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="A" required>
          A) rio - olas
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
          C) lago - agua salada
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Analogias" value="D">
          D) lago - sal
        </label>
      </div>
    </div>
  </div>
  
  <!-- Reactivos con dibujos -->
  <?php if($esVisual): ?>
    <!-- Versión adaptada para discapacidad visual -->
    <div class="ejercicio">
      <h3>Adaptación del ejercicio con dibujos para la discapacidad visual</h3>
      <p>
        Se describen una serie de elementos que corresponden a departamentos de una empresa.
        Ud. debe analizar y descubrir a qué departamento pertenecen dichos elementos.
      </p>
      <p>
        <em>Imagen adaptada:</em> (Esta imagen se presenta con fondo blanco y formas en negro para mejorar el contraste)
      </p>
      <div class="opciones">
        <div class="opcion">
          <span class="literal">A) Casco de protección </span>
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/A.png" 
               alt="Estantería industrial" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/A.png';">
        </div>
        <div class="opcion">
          <span class="literal">B) Overol</span>
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/B.png" 
               alt="Materiales de oficina" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/B.png';">
        </div>
        <div class="opcion">
          <span class="literal">C) Gafas</span>
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/C.png" 
               alt="Equipos de protección personal" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/C.png';">
        </div>
        <div class="opcion">
          <span class="literal">D) Guantes</span>
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/D.png" 
               alt="Artículos de carga" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/D.png';">
        </div>
        <div class="opcion">
          <span class="literal">E) Audífonos</span>
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/E.png" 
               alt="Artículos de carga" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/E.png';">
               <div class="opcion">
          <span class="literal">F) Mascarilla</span>
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/F.png" 
               alt="Artículos de carga" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/F.png';">
        </div>
        <div class="opcion">
          <span class="literal">G) Botas </span>
          <img src="/04.PDO-MYSQL-V1/assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/G.png" 
               alt="Artículos de carga" 
               class="img-option"
               onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeProduccion1/ejercicio4/literales/G.png';">
        </div>
        </div>
      </div>
      <p><strong>¿Los elementos descritos a qué Departamento pertenecen?</strong></p>
      <div class="pregunta">
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="A" required>
            A) Casco de protección
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="B">
            B) Overol
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="C">
            C) Gafas
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="D">
            D) Guantes
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="E">
            E) Audifono
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="F">
            F) Mascarilla
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="G">
            G) Botas
          </label>
        </div>
      </div>
    </div>
  <?php else: ?>
    <!-- Versión original para discapacidad auditiva y física -->
    <div class="ejercicio">
      <h3>Reactivos con Dibujos</h3>
      <p>
        <strong>Indicación:</strong> Observe el dibujo y seleccione el nombre correcto para la figura a la que pertenece.
      </p>
   
      <p>
      <a href="../../../../assets/imagenes/DepartamentoDeProduccion1/ejercicio4/ejercicio4.2.png" data-lightbox="galeria">
        <img src="/04.PDO-MYSQL-V1--/assets/imagenes/DepartamentoDeProduccion1/ejercicio4/ejercicio4.2" 
             alt="Almacén con estanterías" 
             class="img-option-center"
             onerror="this.onerror=null; this.src='../../../../assets/imagenes/DepartamentoDeProduccion1/ejercicio4/ejercicio4.2.png';">
      </a>
      </p>
      <div class="pregunta">
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="A" required>
            A) Material De Oficina
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="B">
            B) Material De Protección Personal
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="C">
            C) Artículos de Carga
          </label>
        </div>
        <div class="opcion">
          <label>
            <input type="radio" name="respuesta4_Dibujos1" value="D">
            D) Bodega
          </label>
        </div>
      </div>
    </div>
  <?php endif; ?>

  <!-- Reactivos verbales (aplican para todas las discapacidades) -->
  <div class="ejercicio">
    <h3>Reactivos verbales</h3>
    <p>
      <strong>Indicación:</strong> A continuación, se le presentará varios significados.  
      Debe elegir la palabra correcta para enlazarla al significado que Ud. considere correcto.
    </p>
    <p><em>Instrumento que tiene por objeto multiplicar la capacidad productiva del trabajo humano.</em></p>
    <div class="pregunta">
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Verbal" value="MAQUINARIA" required>
          A) MAQUINARIA
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Verbal" value="SUPERVISORES">
          B) SUPERVISORES
        </label>
      </div>
      <div class="opcion">
        <label>
          <input type="radio" name="respuesta4_Verbal" value="OBREROS">
          C) OBREROS
        </label>
      </div>
    </div>
  </div>
</body>
</html>