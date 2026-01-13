/***********************************************************************
 * Este archivo contiene la lógica para controlar la reproducción
 * de los audios de cada departamento (play, pause, velocidad, etc.)
 ***********************************************************************/

/**
 * Reproducir el audio de un departamento específico
 */
function playAudio(id) {
    let audio = document.getElementById("audio-" + id);
    audio.play();
  }
  
  /**
   * Pausar el audio de un departamento específico
   */
  function pauseAudio(id) {
    let audio = document.getElementById("audio-" + id);
    audio.pause();
  }
  
  /**
   * Cambiar la velocidad del audio (factor 0.5 o x2)
   */
  function changeSpeed(id, factor) {
    let audio = document.getElementById("audio-" + id);
    let speedDisplay = document.getElementById("speed-" + id);
  
    // Si se reduce la velocidad desde x2, regresa a 1.0
    if (audio.playbackRate === 2 && factor === 0.5) {
      audio.playbackRate = 1;
    } else {
      audio.playbackRate *= factor;
    }
  
    speedDisplay.textContent = (audio.playbackRate === 1)
      ? "Normal"
      : audio.playbackRate + "x";
  }
  
  /**
   * Actualizar la barra de progreso en tiempo real
   */
  function updateProgressBar(id) {
    let audio = document.getElementById("audio-" + id);
    let progressBar = document.getElementById("progress-" + id);
    let percentage = (audio.currentTime / audio.duration) * 100;
    progressBar.style.width = percentage + "%";
  }
  
  /**
   * Ajustar la posición en el audio haciendo clic en la barra de progreso
   */
  function setAudioProgress(e, id) {
    let audio = document.getElementById("audio-" + id);
    let progressBar = e.currentTarget; 
    let rect = progressBar.getBoundingClientRect();
    let x = e.clientX - rect.left;
    let width = rect.width;
    let clickRatio = x / width;
    audio.currentTime = clickRatio * audio.duration;
  }
  