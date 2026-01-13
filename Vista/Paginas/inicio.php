<?php
session_start();

// Verificar si el usuario ha iniciado sesión; de lo contrario, redirigir al formulario de ingreso
if (!isset($_SESSION['user'])) {
    header('Location: ../ingreso.php?action=login');
    exit();
}

// Obtener el nombre del usuario desde la sesión
$nombreUsuario = isset($_SESSION['user']['nombre']) ? $_SESSION['user']['nombre'] : 'Usuario';

// Función para obtener los departamentos y sus roles
function obtenerDepartamentos() {
    return [
        'DepartamentoDeGerenciaGeneral' => [
            'nombre_visible' => 'Departamento De Gerencia General',
            'roles' => [
                'Asistente De Gerencia' => 'DeparGerenciaGeneral/AsistenteDeGerencia/AsistenteDeGerencia.php',
                'Jefe Coordinador De Comunicación Organizacional' => 'DeparGerenciaGeneral/JefeCoordinadorDeComunicaciónOrganizacional/JefeCoordinadorDeComunicacionOrganizacional.php',
                'Jefe Coordinador Jurídico' => 'DeparGerenciaGeneral/JefeCoordinadorJurídico/JefeCoordinadorJuridico.php',
                'Asistente De Comunicación Organizacional' => 'DeparGerenciaGeneral/AsistenteDeComunicaciónOrganizacional/AsistenteDeComunicacionOrganizacional.php',
                'Asistente Jurídico' => 'DeparGerenciaGeneral/AsistenteJurídico/AsistenteJuridico.php'
            ]
        ],
        'DepartamentoDeTalentoHumano1' => [
            'nombre_visible' => 'Departamento De Talento Humano',
            'roles' => [
                'Jefe Coordinador de Talento Humano' => 'DeparTalentoHumano1/JefeCoordinadorDeTalentoHumano/JefeCoordinadorDeTalentoHumano.php',
                'Analista de Talento Humano' => 'DeparTalentoHumano1/AnalistaDeTalentoHumano/AnalistaDeTalentoHumano.php',
                'Médico Ocupacional' => 'DeparTalentoHumano1/MédicoOcupacional/MedicoOcupacional.php',
                'Analista de Capacitación y Desarrollo' => 'DeparTalentoHumano1/AnalistaDeCapacitaciónYDesarrollo/AnalistaDeCapacitacionYDesarrollo.php',
                'Recepcionista' => 'DeparTalentoHumano2/Recepcionista/Recepcionista.php',
                'Trabajadora Social' => 'DeparTalentoHumano2/TrabajadoraSocial/TrabajadoraSocial.php',
                'Analista de nómina' => 'DeparTalentoHumano2/AnalistaDeNómina/AnalistaDeNomina.php',
                'Auxiliar de nómina' => 'DeparTalentoHumano2/AuxiliarDeNómina/AuxiliarDeNomina.php',
                'Analista de selección de personal' => 'DeparTalentoHumano2/AnalistaDeSeleccionDePersonal/AnalistaDeSeleccionDePersonal.php',
                'Auxiliar de Selección de Personal' => 'DeparTalentoHumano3/AuxiliarDeSeleccionDePersonal/AuxiliarDeSeleccionDePersonal.php',
                'Auxiliar de Capacitación y Desarrollo' => 'DeparTalentoHumano3/AuxiliarDeCapacitaciónYDesarrollo/AuxiliarDeCapacitacionYDesarrollo.php',
                'Auxiliar de Talento Humano' => 'DeparTalentoHumano3/AuxiliarDeTalentoHumano/AuxiliarDeTalentoHumano.php',
                'Técnico de Seguridad y Salud Ocupacional' => 'DeparTalentoHumano3/TecnicoDeSeguridadYSaludOcupacional/TecnicoDeSeguridadYSaludOcupacional.php',
                'Auxiliar de Seguridad y Salud Ocupacional' => 'DeparTalentoHumano3/AuxiliarDeSeguridadYSaludOcupacional/AuxiliarDeSeguridadYSaludOcupacional.php',
                'Auxiliar de Servicios Generales' => 'DeparTalentoHumano4/AuxiliarDeServiciosGenerales/AuxiliarDeServiciosGenerales.php',
                'Mensajero' => 'DeparTalentoHumano4/Mensajero/Mensajero.php'
            ]  
        ],
        'DepartamentoAdministrativo1' => [
            'nombre_visible' => 'Departamento Administrativo',
            'roles' => [
                'Jefe  Coordinador de Compras' => 'DeparAdministrativo/JefeCoordinadorDeCompras/JefeCoordinadorDeCompras.php',
                 'Jefe  Coordinador de Sistema' => 'DeparAdministrativo2/JefeCordinarDeSistema/JefeCordinarDeSistema.php',
                'Asistente de Compras Proveedores Nacionales' => 'DeparAdministrativo2/AsistenteDeComprasProvedoresNacionales/AsistenteDeComprasProvedoresNacionales.php',
                'Asistente de Compras Proveedores Extranjeros' => 'DeparAdministrativo2/AsistenteDeComprasProvedoresExtranjeros/AsistenteDeComprasProvedoresExtranjeros.php',
                'Asistente Bodega ' => 'DeparAdministrativo2/AsistenteBodega/AsistenteBodega.php',
                'Asistente de Sistemas' => 'DeparAdministrativo2/AsistenteDeSistemas/AsistenteDeSistemas.php'
                ]
            ],
        'DepartamentoFinanciero' => [
            'nombre_visible' => 'Departamento Financiero',
            'roles' => [
                'Jefe Coordinador De Contabilidad' => 'DeparFinanciero/JefeCoordinadorDeContabilidad/JefeCoordinadorDeContabilidad.php',
                'Jefe De Coordinador De Crédito y Cobranzas' => 'DeparFinanciero/JefeDeCoordinadorDeCréditoYCobranzas/JefeDeCoordinadorDeCréditoYCobranzas.php',
                'Analista De Contabilidad' => 'DeparFinanciero/AnalistaDeContabilidad/AnalistaDeContabilidad.php',
                'Analista De Tesorería' => 'DeparFinanciero/AnalistaDeTesoreria/AnalistaDeTesoreria.php',
                'Jefe Coordinador De Tesorería' => 'DeparFinanciero/JefeCoordinadorDeTesoreria/JefeCoordinadorDeTesoreria.php',
                'Auxiliar De Contabilidad' => 'DeparFinanciero/AuxiliarDeContabilidad/AuxiliarDeContabilidad.php',
                'Auxiliar De Crédito y Cobranzas ' => 'DeparFinanciero/AuxiliarDeCreditoYCobranzas/AuxiliarDeCreditoYCobranzas.php'
            ]
        ],
        'DepartamentoComercial' => [
            'nombre_visible' => 'Departamento Comercial',
            'roles' => [
                'Jefe Coordinador de ventas' => 'DeparComercial/JefeCoordinadorDeVentas/JefeCoordinadorDeVentas.php',
                'Jefe de Coordinador de Marketing' => 'DeparComercial/JefeDeCoordinadorDeMarketing/JefeDeCoordinadorDeMarketing.php',
                'Asistente de Atención al Cliente' => 'DeparComercial/AsistenteDeAtencionAlCliente/AsistenteDeAtencionAlCliente.php',
                'Vendedor' => 'DeparComercial/Vendedor/Vendedor.php',
                'Asistente de Marketing' => 'DeparComercial/AsistenteDeMarketing/AsistenteDeMarketing.php',
                'Cajero Facturador' => 'DeparComercial/CajeroFacturador/CajeroFacturador.php'
            ]
            ],
            'DepartamentoDeProduccion1' => [
            'nombre_visible' => 'Departamento de Produccion',
            'roles' => [
                'Asistente de Planificación' => 'DepartamentoDeProduccion1/AsistenteDePlanificacion/AsistenteDePlanificacion.php',
                'Jefe Coordinador de Producción ' => 'DepartamentoDeProduccion1/JefeCoordinadorDeProduccion/JefeCoordinadorDeProduccion.php',
                'Jefe Coordinador de Mantenimiento' => 'DepartamentoDeProduccion1/JefeCoordinadorDeMantenimiento/JefeCoordinadorDeMantenimiento.php',
                'Supervisor de Sección ' => 'DepartamentoDeProduccion1/SupervisorDeSeccion/SupervisorDeSeccion.php',
                'Supervisor de Mantenimiento Eléctrico ' => 'DepartamentoDeProduccion1/SupervisorDeMantenimientoElectrico/SupervisorDeMantenimientoElectrico.php',
                'Supervisor de Mantenimiento Mecánico' => 'DepartamentoDeProduccion1/SupervisorDeMantenimientoMecanico/SupervisorDeMantenimientoMecanico.php',
                'Supervisor de Mantenimiento Automotriz' => 'DepartamentoDeProduccion1/SupervisorDeMantenimientoAutomotriz/SupervisorDeMantenimientoAutomotriz.php',
                'Auxiliar de Mantenimiento Eléctrico ' => 'DepartamentoDeProduccion1/AuxiliarDeMantenimientoElectrico/AuxiliarDeMantenimientoElectrico.php',
                'Auxiliar de Mantenimiento Mecánico' => 'DepartamentoDeProduccion1/AuxiliarDeMantenimientoMecanico/AuxiliarDeMantenimientoMecanico.php',
                'Auxiliar de Mantenimiento Automotriz' => 'DepartamentoDeProduccion1/AuxiliarDeMantenimientoAutomotriz/AuxiliarDeMantenimientoAutomotriz.php',
                'Operario General' => 'DepartamentoDeProduccion2/OperarioGeneral/OperarioGeneral.php',
                'Ayudante General' => 'DepartamentoDeProduccion2/AyudanteGeneral/AyudanteGeneral.php'
            ]
            ],
    ];
}

$departamentos = obtenerDepartamentos();
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio - Bolsa de Empleo Inclusiva</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">

    <!-- Estilos externos (ejemplo) -->

    <link rel="stylesheet" href="../../assets/css/inicio.css">  <!-- preexistente -->


    <!-- Tus dos archivos CSS separados -->
    <link rel="stylesheet" href="../assets/css/Inicio/Inicio.css">
    <link rel="stylesheet" href="../assets/css/Inicio/accesibilidad.css">

    <!-- jQuery library -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

    <!-- FontAwesome -->
    <script src="https://kit.fontawesome.com/32a65358fa.js" crossorigin="anonymous"></script>

    <!-- Atajos de teclado (podrías poner esto en accesibilidad.js si lo prefieres) -->
    <script>
        document.addEventListener('keydown', function(e) {
            if (e.altKey) {
                switch(e.key.toLowerCase()){
                    case 'i': // Alt + I para Ingreso
                        window.location.href = '../ingreso.php';
                        break;
                    case 'r': // Alt + R para Registro
                        window.location.href = '../registro.php';
                        break;
                    case 'h': // Alt + H para Inicio
                        window.location.href = '../inicio.html';
                        break;
                }
            }
        });
    </script>
</head>
<body>

<!-- Encabezado -->
<link rel="stylesheet" href="../assets/css/logo.css">
<div class="header-container1">
    <div class="logo">
      <img src="../../assets/imagenes/logo.png" alt="Logo de IncluLab" 
           onerror="this.onerror=null; this.src='/04.PDO-MYSQL-V1/assets/imagenes/logo.png';">
      <h1>IncluLab</h1>
    </div>
    <a href="salir.php" class="logout-btn" aria-label="Cerrar sesión">
      <i class="fas fa-sign-out-alt"></i> Cerrar sesión
    </a>
  </div>
<br>
<main class="container">
    <section class="welcome-section">
        <h1>Bienvenido/a <?php echo htmlspecialchars($nombreUsuario); ?>!</h1>
    </section>
<br>
    <section class="department-selection">
        <h3>Por favor! Selecciona el Departamento al cual deseas postular</h3>

        <fieldset>
            <nav aria-label="Departamentos disponibles">
                <ul class="department-list">
                    <?php foreach ($departamentos as $claveDepartamento => $datosDepartamento): ?>
                    <li class="department-item">
                        <div class="department-container">
                            <h2 class="department-name">
                                <?php echo htmlspecialchars($datosDepartamento['nombre_visible']); ?>
                            </h2>

                            <?php if (!empty($datosDepartamento['roles'])): ?>
                            <ul class="role-list">
                                <?php foreach ($datosDepartamento['roles'] as $nombreRol => $enlaceRol): ?>
                                <li class="role-item">
                                    <a href="<?php echo htmlspecialchars($enlaceRol); ?>">
                                        <?php echo htmlspecialchars($nombreRol); ?>
                                    </a>
                                </li>
                                <?php endforeach; ?>
                            </ul>
                            <?php endif; ?>

                            <!-- Controles de audio con barra de progreso -->
                            <div class="audio-container">
                                <audio id="audio-<?php echo $claveDepartamento; ?>"
                                       ontimeupdate="updateProgressBar('<?php echo $claveDepartamento; ?>')">
                                    <source src="../../assets/audio/departamentos/<?php echo $claveDepartamento; ?>inicio.mp3" type="audio/mpeg">
                                    Tu navegador no soporta el elemento de audio.
                                </audio>

                                <div class="speed-display" id="speed-<?php echo $claveDepartamento; ?>">
                                    Normal
                                </div>

                                <div class="progress-bar"
                                     onclick="setAudioProgress(event, '<?php echo $claveDepartamento; ?>')">
                                    <span id="progress-<?php echo $claveDepartamento; ?>"></span>
                                </div>

                                <div class="audio-controls">
                                    <button class="play-btn" onclick="playAudio('<?php echo $claveDepartamento; ?>')">
                                        ▶️ Play
                                    </button>
                                    <button class="pause-btn" onclick="pauseAudio('<?php echo $claveDepartamento; ?>')">
                                        ⏸️ Pause
                                    </button>
                                    <button class="speed-down-btn" onclick="changeSpeed('<?php echo $claveDepartamento; ?>', 0.5)">
                                        ⏪ Velocidad /2
                                    </button>
                                    <button class="speed-up-btn" onclick="changeSpeed('<?php echo $claveDepartamento; ?>', 2)">
                                        ⏩ Velocidad x2
                                    </button>
                                </div>
                            </div>
                            <h3>
                                Este audio proporciona una descripción de las opciones del
                                <?php echo htmlspecialchars($datosDepartamento['nombre_visible']); ?>.
                            </h3>
                        </div>
                    </li>
                    <?php endforeach; ?>
                </ul>
            </nav>
        </fieldset>
    </section>
</main>

<?php include 'footer.php'; ?>

  <!-- Botón para activar/desactivar el modo accesible -->
  <button id="toggleAccesibilidad" class="btn btn-accesible btn-primary" aria-label="Activar ayuda para personas con problemas visuales">
    Activar ayuda para personas con problemas visuales
  </button>

  <!-- Burbuja para ajustes de estilo (botón flotante) -->
  <div id="burbujaAjustes" class="ajustes-burbuja" aria-label="Abrir ajustes de estilo" tabindex="0">
    <i class="fas fa-cog"></i>
  </div>

<!-- Panel de ajustes de estilo -->
<div id="panelAjustes" class="panel-ajustes" aria-label="Panel de ajustes de estilo">
    <h5>Ajustes de Estilo</h5>
    <label for="fontFamilySelect">Tipo de letra:</label>
    <select id="fontFamilySelect">
      <option value="Arial, sans-serif">Arial</option>
      <option value="'Times New Roman', serif">Times New Roman</option>
      <option value="Verdana, sans-serif">Verdana</option>
      <option value="'Courier New', monospace">Courier New</option>
    </select>
    <label for="fontSizeRange">Tamaño de letra: <span id="fontSizeValue">18</span>px</label>
    <input type="range" id="fontSizeRange" min="12" max="50" value="20">
    <label for="themeSelect">Tema de color:</label>
    <select id="themeSelect">
      <option value="theme-claro">🌞Claro</option>
      <option value="theme-oscuro">🌙Oscuro</option>
      <option value="theme-daltonismo">🎨Daltonismo</option>
      <option value="theme-amarillo">🟡⚫Alto Contraste Amarillo</option>
      <option value="theme-contrasteInvertido">☯️Contraste Invertido</option>
    </select>
    <button id="aplicarAjustes" class="btn btn-primary btn-block" type="button">Aplicar ajustes</button>
  </div>

<!-- Tus dos archivos JS separados -->
<script src="../assets/js/Inicio/accesibilidad.js"></script>
<script src="../assets/js/Inicio/Inicio.js"></script>

</body>
</html>
