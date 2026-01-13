// Inicio.js

document.addEventListener("DOMContentLoaded", () => {
    // Lógica para Drag & Drop del Ejercicio 2
    let elementoArrastrado = null;
    const lista = document.getElementById("sortable");
    if (lista) {
      const elementos = lista.querySelectorAll("li");
      elementos.forEach((item) => {
        item.addEventListener("dragstart", (e) => {
          elementoArrastrado = item;
          setTimeout(() => { item.style.display = "none"; }, 0);
        });
        item.addEventListener("dragend", (e) => {
          setTimeout(() => {
            item.style.display = "block";
            elementoArrastrado = null;
          }, 0);
        });
      });
      lista.addEventListener("dragover", (e) => { e.preventDefault(); });
      lista.addEventListener("dragenter", (e) => { e.preventDefault(); });
      lista.addEventListener("drop", (e) => {
        if (elementoArrastrado) {
          const liDestino = e.target.closest("li");
          if (liDestino && liDestino !== elementoArrastrado) {
            lista.insertBefore(elementoArrastrado, liDestino);
          } else {
            lista.appendChild(elementoArrastrado);
          }
        }
      });
    }
  });
  
  // Funciones de control del audio
  function updateProgressBar(id) {
    const audio = document.getElementById("audio-" + id);
    const progressBar = document.getElementById("progress-" + id);
    if (audio && progressBar && audio.duration) {
      let percentage = (audio.currentTime / audio.duration) * 100;
      progressBar.style.width = percentage + "%";
    }
  }
  
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
      if (audio.playbackRate === 2 && factor === 0.5) {
        audio.playbackRate = 1;
      } else {
        audio.playbackRate *= factor;
      }
      if (speedDisplay) {
        speedDisplay.textContent = audio.playbackRate === 1 ? "Normal" : audio.playbackRate + "x";
      }
    }
  }
  
  function setAudioProgress(e, id) {
    const audio = document.getElementById("audio-" + id);
    const progressBar = e.currentTarget;
    if (audio && audio.duration) {
      const rect = progressBar.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const width = rect.width;
      const clickRatio = x / width;
      audio.currentTime = clickRatio * audio.duration;
    }
  }
  
  function enviarFormulario(e) {
    e.preventDefault();
  
    // Si existe el ejercicio de Drag & Drop, captura el orden
    const lista = document.getElementById("sortable");
    if (lista) {
      const items = lista.querySelectorAll("li");
      const orden = [];
      items.forEach((item) => {
        orden.push(item.getAttribute("data-value"));
      });
      const ordenFinalInput = document.getElementById("ordenFinal");
      if (ordenFinalInput) {
        ordenFinalInput.value = orden.join(",");
      }
    }
  
    const form = document.getElementById("form-ejercicios");
    const formData = new FormData(form);
  
    fetch("../../../../Controlador/DepartamentoHumano1/depatarmentoHumano1Controller.php", {
      method: "POST",
      body: formData
    })
    .then(response => response.text())
    .then(data => {
      document.getElementById("resultados").innerHTML = data;
    })
    .catch(error => console.error("Error:", error));
  }
  