// Configuración del modal de edición de ideas
document.addEventListener('DOMContentLoaded', function() {
    var editarIdeaModal = document.getElementById('editarIdeaModal');
    if (editarIdeaModal) {
        editarIdeaModal.addEventListener('show.bs.modal', function (event) {
            var button = event.relatedTarget;
            
            // Obtener datos del botón
            var id = button.getAttribute('data-id');
            var titulo = button.getAttribute('data-titulo');
            var descripcion = button.getAttribute('data-descripcion');
            var tecnologias = button.getAttribute('data-tecnologias');
            var fecha_proposicion = button.getAttribute('data-fecha_proposicion');
            var estado = button.getAttribute('data-estado');
            var observaciones = button.getAttribute('data-observaciones');
            
            // Asignar valores (verificando que los elementos existan)
            document.getElementById('edit-id').value = id;
            document.getElementById('edit-titulo').value = titulo;
            document.getElementById('edit-descripcion').value = descripcion;
            document.getElementById('edit-tecnologias').value = tecnologias;
            document.getElementById('edit-fecha').value = fecha_proposicion;
            document.getElementById('edit-estado').value = estado;
            
            // Verificar si el textarea existe antes de asignar valor
            var obsInput = document.getElementById('edit-observaciones');
            if (obsInput) {
                obsInput.value = observaciones || '';
            } else {
                console.error("Error: No se encontró el textarea 'edit-observaciones'");
            }
        });
    }
});

// Configuración del modal de confirmación de eliminación
document.addEventListener('DOMContentLoaded', function() {
    var eliminarModal = document.getElementById('confirmarEliminarIdeaModal');
    if (eliminarModal) {
        eliminarModal.addEventListener('show.bs.modal', function(event) {
            var button = event.relatedTarget;
            var id = button.getAttribute('data-id');
            var confirmarBtn = eliminarModal.querySelector('#confirmarEliminarIdeaBtn');
            confirmarBtn.href = 'eliminarIdea.jsp?id=' + id;
        });
    }
});