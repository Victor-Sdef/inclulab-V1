// Lógica de Drag & Drop (solo si algún ejercicio lo requiere)
document.addEventListener("DOMContentLoaded", () => {
    const lista = document.getElementById("sortable");
    if (lista) {
      let elementoArrastrado = null;
      const items = lista.querySelectorAll("li");
  
      items.forEach((item) => {
        item.addEventListener("dragstart", (e) => {
          elementoArrastrado = item;
          setTimeout(() => { item.style.display = "none"; }, 0);
        });
        item.addEventListener("dragend", (e) => {
          setTimeout(() => {
            elementoArrastrado.style.display = "block";
            elementoArrastrado = null;
          }, 0);
        });
      });
  
      lista.addEventListener("dragover", (e) => e.preventDefault());
      lista.addEventListener("dragenter", (e) => e.preventDefault());
  
      lista.addEventListener("drop", (e) => {
        if (elementoArrastrado) {
          const dropTarget = e.target.closest("li");
          if (dropTarget && dropTarget !== elementoArrastrado) {
            lista.insertBefore(elementoArrastrado, dropTarget);
          } else {
            lista.appendChild(elementoArrastrado);
          }
        }
      });
    }
  });
  
  // Función para enviar el formulario mediante fetch (AJAX)
  function enviarFormulario(e) {
    e.preventDefault(); // Evitar el envío tradicional
  
    // Si existe el ejercicio de Drag & Drop, capturar el orden
    const sortableList = document.getElementById("sortable");
    if (sortableList) {
      const items = sortableList.querySelectorAll("li");
      let orden = [];
      items.forEach((item) => {
        orden.push(item.getAttribute("data-value"));
      });
      // Asegurarse de que exista un input hidden con name="ordenFinal"
      const ordenFinalInput = document.getElementById("ordenFinal");
      if (ordenFinalInput) {
        ordenFinalInput.value = orden.join(",");
      }
    }
  
    const form = document.getElementById("form-ejercicios");
    const formData = new FormData(form);
  
    // Ajustar la ruta al controlador
    fetch("../../../../Controlador/DepartamentoDeProduccion2/DepartamentoDeProduccion2Controller.php", {
      method: "POST",
      body: formData
    })
    .then(response => response.text())
    .then(data => {
      // Mostrar la respuesta del controlador en el div resultados
      document.getElementById("resultados").innerHTML = data;
    })
    .catch(error => console.error("Error:", error));
  }
  
  // Aquí puedes agregar funciones adicionales (por ejemplo, para controlar audio)
  // Ejemplo: Funciones para reproducir/pausar audio
  function playAudio(id) {
    const audio = document.getElementById("audio-" + id);
    if (audio) audio.play();
  }
  
  function pauseAudio(id) {
    const audio = document.getElementById("audio-" + id);
    if (audio) audio.pause();
  }
  
  function changeSpeed(id, factor) {
    const audio = document.getElementById("audio-" + id);
    const speedDisplay = document.getElementById("speed-" + id);
    if (audio) {
      audio.playbackRate *= factor;
      if (speedDisplay) {
        speedDisplay.textContent = audio.playbackRate.toFixed(1) + "x";
      }
    }
  }
  
  function updateProgressBar(id) {
    const audio = document.getElementById("audio-" + id);
    const progressBar = document.querySelector("#progress-" + id);
    if (audio && progressBar) {
      const percentage = (audio.currentTime / audio.duration) * 100;
      progressBar.style.width = percentage + "%";
    }
  }
  