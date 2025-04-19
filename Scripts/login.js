document.addEventListener('DOMContentLoaded', function() {
    // Mostrar modal de error si existe parámetro en la URL
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');
    
    if (error) {
        // Crear dinámicamente el modal de error
        const errorModalHTML = `
        <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-white">
                        <h5 class="modal-title" id="errorModalLabel">Error de autenticación</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        ${getErrorMessage(error)}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        `;
        
        // Añadir el modal al body
        document.body.insertAdjacentHTML('beforeend', errorModalHTML);
        
        // Mostrar el modal
        const errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
        errorModal.show();
        
        // Limpiar el parámetro de la URL sin recargar
        window.history.replaceState({}, document.title, window.location.pathname);
    }
});

function getErrorMessage(errorType) {
    switch(errorType) {
        case 'invalid_credentials':
            return '<p><i class="bi bi-exclamation-triangle-fill"></i> Correo electrónico o contraseña incorrectos.</p>';
        case 'missing_data':
            return '<p><i class="bi bi-exclamation-triangle-fill"></i> Por favor ingrese su correo y contraseña.</p>';
        case 'db_error':
            return '<p><i class="bi bi-exclamation-triangle-fill"></i> Error al conectar con la base de datos.</p>';
        default:
            return '<p><i class="bi bi-exclamation-triangle-fill"></i> Error desconocido.</p>';
    }
}