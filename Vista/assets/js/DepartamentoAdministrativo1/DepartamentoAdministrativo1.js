let elementoArrastrado = null;
document.addEventListener("DOMContentLoaded", () => {
  const elementos = document.querySelectorAll("#sortable li");
  const lista = document.getElementById("sortable");
  elementos.forEach((item) => {
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
});


function enviarFormulario(e) {
  e.preventDefault(); 


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

  const items = document.querySelectorAll("#sortable li");
  const orden = [];
  items.forEach((item) => {
    orden.push(item.getAttribute("data-value"));
  });
  document.getElementById("ordenFinal").value = orden.join(",");

  const form = document.getElementById("form-ejercicios");
  const formData = new FormData(form);

  fetch("../../../../Controlador/DepartamentoAdministrativo/DepartamentoAdministrativoController.php", {
    method: "POST",
    body: formData
  })
  .then(response => response.text())
  .then(data => {
    document.getElementById("resultados").innerHTML = data;
  })
  .catch(error => console.error("Error:", error));
}