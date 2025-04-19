<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Página de Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="Styles/style.css">
    <style>

    </style>
</head>
<body>

    <div class="white-line"></div>

   
    <header class="text-center py-3">
     
            <h1 class="mb-0">Gestor de proyectos de grado</h1>
           
        
    </header>

    <div class="white-line"></div>

    <%-- Consulta para obtener usuarios --%>
    <sql:query dataSource="${baseDeDatos}" var="usuarios">
        SELECT nombre, apellido, correo, contraseña, rol 
        FROM usuarios
        ORDER BY 
            CASE rol
                WHEN 'Administrador' THEN 1
                WHEN 'Coordinacion' THEN 2
                WHEN 'Director' THEN 3
                WHEN 'Evaluador' THEN 4
                WHEN 'Estudiante' THEN 5
                ELSE 6
            END
    </sql:query>

    <main class="d-flex justify-content-center align-items-center" style="min-height: 60vh;">
        <div class="login-box text-center">
            <h2>Iniciar Sesión</h2>
            <form action="procesarLogin.jsp" method="post" class="mt-4">
                <div class="mb-3">
                    <input type="text" class="form-control" name="usuario" placeholder="Correo" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" name="clave" placeholder="Contraseña" required>
                </div>
                <button type="submit" class="btn btn-dark w-100">Entrar</button>
            </form>
            <!-- Botón para abrir el modal -->
            <button type="button" class="btn btn-outline-secondary mt-3" data-bs-toggle="modal" data-bs-target="#infoModal">
                <i class="bi bi-info-circle"></i> Credenciales de acceso
            </button>
        </div>

        
    </main>

    <!-- Modal -->
    <div class="modal fade" id="infoModal" tabindex="-1" aria-labelledby="infoModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header bg-dark text-white">
                    <h5 class="modal-title" id="infoModalLabel">Credenciales de acceso al sistema</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-info">
                        <i class="bi bi-exclamation-circle-fill"></i> Estas son las credenciales de prueba para acceder al sistema con diferentes roles.
                    </div>
                    
                    <table class="table table-bordered user-table table-hover mt-3">
                        <thead>
                            <tr>
                                <th>Nombre</th>
                                <th>Apellido</th>
                                <th>Correo</th>
                                <th>Contraseña</th>
                                <th>Rol</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${usuarios.rows}" var="usuario">
                                <tr>
                                    <td>${usuario.nombre}</td>
                                    <td>${usuario.apellido}</td>
                                    <td>${usuario.correo}</td>
                                    <td>${usuario.contraseña}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${usuario.rol == 'Administrador'}">
                                                <span class="badge bg-secondary role-badge">${usuario.rol}</span>
                                            </c:when>
                                            <c:when test="${usuario.rol == 'Coordinacion'}">
                                                <span class="badge bg-primary role-badge">${usuario.rol}</span>
                                            </c:when>
                                            <c:when test="${usuario.rol == 'Docente'}">
                                                <span class="badge bg-warning  role-badge">${usuario.rol}</span>
                                            </c:when>
                                            <c:when test="${usuario.rol == 'Estudiante'}">
                                                <span class="badge bg-success  role-badge">${usuario.rol}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary role-badge">${usuario.rol}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>

    <div class="white-line"></div>
    <footer class="text-center py-3">
        &copy; UTS - 2025 - Todos los derechos reservados
    </footer>
    <div class="white-line"></div>

    <!-- Bootstrap JS y Bootstrap Icons -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <script src="Scripts/login.js"></script>
</body>
</html>