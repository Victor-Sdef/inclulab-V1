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
