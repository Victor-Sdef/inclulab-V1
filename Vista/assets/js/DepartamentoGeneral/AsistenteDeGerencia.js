document.addEventListener("DOMContentLoaded", () => {
  // ====================================================
  // 1) Lógica de Drag & Drop (si hay un ejercicio con #sortable)
  // ====================================================
  const lista = document.getElementById("sortable");
  if (lista) {
    const items = lista.querySelectorAll("li");
    let elementoArrastrado = null;
    items.forEach((item) => {
      item.addEventListener("dragstart", () => {
        elementoArrastrado = item;
        setTimeout(() => { item.style.display = "none"; }, 0);
      });
      item.addEventListener("dragend", () => {
        setTimeout(() => {
          if (elementoArrastrado) {
            elementoArrastrado.style.display = "block";
            elementoArrastrado = null;
          }
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

  // ====================================================
  // 2) Función para enviar formulario con AJAX
  // ====================================================
  function enviarFormulario(e) {
    e.preventDefault();

    // Si hay un ejercicio Drag & Drop, capturar su orden:
    const sortableList = document.getElementById("sortable");
    if (sortableList) {
      const items = sortableList.querySelectorAll("li");
      let orden = [];
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

    fetch("../../../../Controlador/DepartamentoGerenciaGeneral/DeparGerenciaGeneralController.php", {
      method: "POST",
      body: formData
    })
      .then(response => response.text())
      .then(data => {
        document.getElementById("resultados").innerHTML = data;
      })
      .catch(error => console.error("Error:", error));
  }

  // Opcional: asignar la función al submit del formulario
  const form = document.getElementById("form-ejercicios");
  if (form) {
    form.addEventListener("submit", enviarFormulario);
  }
});
