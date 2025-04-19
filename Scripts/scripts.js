
var editarUsuarioModal = document.getElementById('editarUsuarioModal');
editarUsuarioModal.addEventListener('show.bs.modal', function (event) {
    var button = event.relatedTarget;

    var id = button.getAttribute('data-id');
    var nombre = button.getAttribute('data-nombre');
    var apellido = button.getAttribute('data-apellido');
    var correo = button.getAttribute('data-correo');
    var contrasena = button.getAttribute('data-contrasena');
    var rol = button.getAttribute('data-rol');

    document.getElementById('edit-id').value = id;
    document.getElementById('edit-nombre').value = nombre;
    document.getElementById('edit-apellido').value = apellido;
    document.getElementById('edit-correo').value = correo;
    document.getElementById('edit-contrasena').value = contrasena;
    document.getElementById('edit-rol').value = rol;
});




document.addEventListener('DOMContentLoaded', function() {
    var eliminarModal = document.getElementById('confirmarEliminarModal');
    if (eliminarModal) {
        eliminarModal.addEventListener('show.bs.modal', function(event) {
            var button = event.relatedTarget;
            var id = button.getAttribute('data-id');
            var confirmarBtn = eliminarModal.querySelector('#confirmarEliminarBtn');
            confirmarBtn.href = 'eliminarUsuario.jsp?id=' + id;
        });
    }
});


