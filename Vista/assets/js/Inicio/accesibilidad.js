
document.addEventListener("DOMContentLoaded", () => {
  // Recuperar configuración guardada desde localStorage
  const savedFontFamily = localStorage.getItem("fontFamily");
  const savedFontSize = localStorage.getItem("fontSize");
  const savedTheme = localStorage.getItem("theme");
  const savedModoAccesible = localStorage.getItem("modoAccesible") === "true";

  // Aplicar configuración guardada (fuente, tamaño y tema)
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
    document.body.classList.remove("theme-claro", "theme-oscuro", "theme-daltonismo", "theme-amarillo", "theme-contrasteInvertido");
    document.body.classList.add(savedTheme);
    const themeSelect = document.getElementById("themeSelect");
    if (themeSelect) {
      themeSelect.value = savedTheme;
    }
  }
  
  // Guardar el estado del modo accesible en una variable global
  window.modoAccesible = savedModoAccesible;

  // Función para leer en voz alta un texto usando la Web Speech API
  function speakText(text) {
    if ('speechSynthesis' in window) {
      window.speechSynthesis.cancel();
      const utterance = new SpeechSynthesisUtterance(text);
      utterance.lang = 'es-ES';
      window.speechSynthesis.speak(utterance);
    } else {
      console.log("La síntesis de voz no es compatible con este navegador.");
    }
  }

  // Configurar el botón para activar/desactivar el modo accesible
  const toggleButton = document.getElementById("toggleAccesibilidad");
  if (toggleButton) {
    toggleButton.innerText = savedModoAccesible 
      ? "Desactivar ayuda para personas con problemas visuales" 
      : "Activar ayuda para personas con problemas visuales";
    
    toggleButton.addEventListener("click", () => {
      window.modoAccesible = !window.modoAccesible;
      localStorage.setItem("modoAccesible", window.modoAccesible);
      if (window.modoAccesible) {
        toggleButton.innerHTML = "&#x1F441;&#x1F3A4;"; // Icono activado
        speakText("Modo accesible activado");
      } else {
        toggleButton.innerHTML = "&#x1F441;&#x20E0;"; // Icono desactivado
        speakText("Modo accesible desactivado");
      }
    });
  }

  // Configurar el comportamiento de accesibilidad para simular el doble clic
  let lastClickTime = 0;
  let lastClickedElement = null;
  const dblClickThreshold = 600; // tiempo en ms para considerar doble clic

  document.addEventListener("click", function(e) {
    if (!window.modoAccesible) return;
    const target = e.target.closest("a, button, input, select, textarea");
    if (!target) return;
    const now = Date.now();
    if (lastClickedElement === target && (now - lastClickTime) < dblClickThreshold) {
      // Se considera doble clic: cancelar cualquier lectura previa y permitir la acción normal
      window.speechSynthesis.cancel();
      lastClickedElement = null;
      lastClickTime = 0;
    } else {
      // Primer clic: prevenir acción normal y leer el contenido del elemento
      e.stopImmediatePropagation();
      e.preventDefault();
      const texto = target.innerText.trim() || target.getAttribute("aria-label") || "Elemento interactivo";
      speakText(texto);
      lastClickedElement = target;
      lastClickTime = now;
    }
  }, true);

  // Configurar el panel de ajustes
  const burbuja = document.getElementById("burbujaAjustes");
  const panel = document.getElementById("panelAjustes");
  if (burbuja && panel) {
    burbuja.addEventListener("click", () => {
      panel.style.display = (panel.style.display === "block") ? "none" : "block";
    });
  }

  // Ajustes de estilo: fuente, tamaño y tema
  const fontFamilySelect = document.getElementById("fontFamilySelect");
  const fontSizeRange = document.getElementById("fontSizeRange");
  const fontSizeValue = document.getElementById("fontSizeValue");
  const themeSelect = document.getElementById("themeSelect");
  const aplicarBtn = document.getElementById("aplicarAjustes");

  if (fontSizeRange && fontSizeValue) {
    fontSizeRange.addEventListener("input", () => {
      fontSizeValue.innerText = fontSizeRange.value;
    });
  }

  function aplicarAjustes() {
    // Cambiar fuente y tamaño
    const nuevaFuente = fontFamilySelect.value;
    const nuevoTamano = fontSizeRange.value;
    document.body.style.fontFamily = nuevaFuente;
    document.body.style.fontSize = nuevoTamano + "px";
    
    // Cambiar tema de color: quitar clases anteriores y agregar la seleccionada
    document.body.classList.remove("theme-claro", "theme-oscuro", "theme-daltonismo", "theme-amarillo", "theme-contrasteInvertido");
    const nuevoTema = themeSelect.value;
    document.body.classList.add(nuevoTema);
    
    // Guardar ajustes en localStorage
    localStorage.setItem("fontFamily", nuevaFuente);
    localStorage.setItem("fontSize", nuevoTamano);
    localStorage.setItem("theme", nuevoTema);
    
    // Confirmación en voz alta
    if ('speechSynthesis' in window) {
      const utterance = new SpeechSynthesisUtterance(
        "Ajustes aplicados: tipo de letra " + fontFamilySelect.options[fontFamilySelect.selectedIndex].text +
        ", tamaño " + nuevoTamano + " píxeles, tema " + themeSelect.options[themeSelect.selectedIndex].text
      );
      utterance.lang = 'es-ES';
      window.speechSynthesis.speak(utterance);
    }
  }
  
  if (aplicarBtn) {
    aplicarBtn.addEventListener("click", aplicarAjustes);
  }
});

