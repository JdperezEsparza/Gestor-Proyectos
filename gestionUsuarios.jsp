<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
            <%@include file="WEB-INF/jspf/conexion.jspf" %>

                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Gestion de usuarios</title>
                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- Bootstrap Icons -->
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
                    <link rel="stylesheet" href="Styles/style2.css">
                </head>

                <body>
                    <div class="white-line"></div>

                    <header class="text-center bg-secondary text-white py-3">
                        <div class="d-flex justify-content-between align-items-center px-3">
                            <div></div>
                            <div>
                                <h2 class="mb-0">Rol: ${sessionScope.rol}</h2>
                                <h3 class="mb-0">Gestión de usuarios</h3>
                            </div>
                            <div>
                                <a href="admin.jsp" class="btn btn-light me-2">
                                    <i class="bi bi-arrow-left"></i> Volver atrás
                                </a>
                            </div>
                        </div>
                    </header>
                    <div class="white-line"></div>

                    <main class="container my-4">

                        <div class="mb-3">

                            <button type="button" class="btn btn-dark" data-bs-toggle="modal"
                                data-bs-target="#insertarUsuarioModal">
                                <i class="bi bi-person-plus"></i> Insertar Usuario
                            </button>
                        </div>



                        <sql:query var="result" dataSource="${baseDeDatos}">
                            SELECT id_usuario, nombre, apellido, correo, contraseña, rol 
                            FROM usuarios
                            WHERE rol != 'Administrador'  
                        </sql:query>

                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Apellido</th>
                                        <th>Correo</th>
                                        <th>Contraseña</th>
                                        <th>Rol</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${result.rows}">
                                        <tr>
                                            <td>
                                                <c:out value="${row.id_usuario}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.nombre}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.apellido}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.correo}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.contraseña}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.rol}" />
                                            </td>
                                            <td>
                                                <!-- Botón para Editar -->
                                                <a href="#" class="btn btn-dark btn-sm" data-bs-toggle="modal"
                                                    data-bs-target="#editarUsuarioModal" data-id="${row.id_usuario}"
                                                    data-nombre="${row.nombre}" data-apellido ="${row.apellido}" data-correo="${row.correo}"
                                                    data-contrasena="${row.contraseña}" data-rol="${row.rol}">
                                                    <i class="bi bi-pencil-square"></i> Editar
                                                </a>
                                                <!-- Botón para Eliminar -->
                                                <button class="btn btn-danger btn-sm" data-bs-toggle="modal"
                                                    data-bs-target="#confirmarEliminarModal"
                                                    data-id="${row.id_usuario}">
                                                    <i class="bi bi-trash"></i> Eliminar
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </main>

                    <div class="white-line"></div>

                    <footer class="text-center bg-secondary text-white py-3">
                        <div class="container">
                            &copy; 2025 - Todos los derechos reservados
                        </div>
                    </footer>

                    <div class="white-line"></div>


                    <!-- Modal para insertar usuario -->
                    <div class="modal fade" id="insertarUsuarioModal" tabindex="-1"
                        aria-labelledby="insertarUsuarioModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="insertarUsuarioModalLabel">Insertar Nuevo Usuario
                                    </h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <form action="insertarUsuario.jsp" method="POST">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <label for="nombre" class="form-label">Nombre</label>
                                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="nombre" class="form-label">Apellido</label>
                                            <input type="text" class="form-control" id="apellido" name="apellido" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="correo" class="form-label">Correo</label>
                                            <input type="email" class="form-control" id="correo" name="correo" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="contrasena" class="form-label">Contraseña</label>
                                            <input type="password" class="form-control" id="contrasena"
                                                name="contrasena" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="rol" class="form-label">Rol</label>
                                            <select class="form-select" id="rol" name="rol" required>
                                                <option value="" disabled selected>Seleccione un rol</option>
                                                <option value="Estudiante">Estudiante</option>
                                                <option value="Docente">Docente</option>
                                                <option value="Coordinacion">Coordinacion</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-dark">Guardar Usuario</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>


                    <!-- Modal Editar (NUEVO) -->

                    <div class="modal fade" id="editarUsuarioModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="actualizarUsuario.jsp" method="POST">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Editar Usuario</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" name="id_usuario" id="edit-id">

                                        <div class="mb-3">
                                            <label class="form-label">Nombre</label>
                                            <input type="text" class="form-control" name="nombre" id="edit-nombre"
                                                required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Apellido</label>
                                            <input type="text" class="form-control" name="apellido" id="edit-apellido"
                                                required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Correo</label>
                                            <input type="email" class="form-control" name="correo" id="edit-correo"
                                                required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Contraseña</label>
                                            <input type="password" class="form-control" name="contrasena"
                                                id="edit-contrasena" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Rol</label>
                                            <select class="form-select" name="rol" id="edit-rol" required>
                                                <option value="Estudiante">Estudiante</option>
                                                <option value="Docente">Docente</option>
                                                <option value="Coordinacion">Coordinacion</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-primary">Guardar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>


                    <!-- Modal de Confirmación para Eliminar -->
                    <div class="modal fade" id="confirmarEliminarModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Confirmar Eliminación</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    ¿Estás seguro que deseas eliminar este usuario? Esta acción no se puede
                                    deshacer.
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Cancelar</button>
                                    <a id="confirmarEliminarBtn" href="#" class="btn btn-danger">Eliminar</a>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Bootstrap JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                    <script src="Scripts/scripts.js"></script>
                </body>

                </html>