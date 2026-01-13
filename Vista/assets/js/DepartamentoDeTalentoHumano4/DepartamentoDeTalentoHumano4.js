 // Lógica de Drag & Drop (solo si alguno de los ejercicios lo requiere)
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

  // Enviar el formulario vía fetch (AJAX)
  function enviarFormulario(e) {
    e.preventDefault(); // Evitar envío tradicional

    // Si hay un ejercicio 2 con Drag & Drop, capturar su orden
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

    // Ajustar la ruta al controlador que procese los datos
    fetch("../../../../Controlador/DepartamentoHumano4/depatarmentoHumano4Controller.php", {
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