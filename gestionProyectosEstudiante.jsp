<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
            <%@ include file="WEB-INF/jspf/conexion.jspf" %>

                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Gestion proyectos</title>
                    <!-- Bootstrap CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <!-- Bootstrap Icons -->
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
                    <link rel="stylesheet" href="Styles/style4.css">
                </head>

                <body>

                    <div class="white-line"></div>

                    <header class="text-center bg-success text-white py-3">
                        <div class="d-flex justify-content-between align-items-center px-3">
                            <div></div>
                            <div>
                                <h2 class="mb-0">Rol: ${sessionScope.rol}</h2>
                                <h3 class="mb-0">Gestión de proyectos</h3>
                            </div>
                            <div>
                                <a href="estudiante.jsp" class="btn btn-light me-2">
                                    <i class="bi bi-arrow-left"></i> Volver atrás
                                </a>
                            </div>
                        </div>
                    </header>

                    <div class="white-line"></div>

                    <main class="container my-4">

                        <!-- Consulta para verificar el estado del proyecto del usuario -->
                        <sql:query var="proyectoAsignado" dataSource="${baseDeDatos}">
                            SELECT id_anteproyecto, estudiante2, calificacion_director, calificacion_evaluador
                            FROM anteproyectos
                            WHERE id_estudiante = ? OR estudiante = ? OR estudiante2 = ?
                            <sql:param value="${sessionScope.id}" />
                            <sql:param value="${sessionScope.nombreCompleto}" />
                            <sql:param value="${sessionScope.nombreCompleto}" />
                        </sql:query>

                        <div class="mb-3">
                            <c:choose>
                                <c:when test="${proyectoAsignado.rowCount > 0}">
                                    <c:forEach var="proyecto" items="${proyectoAsignado.rows}">
                                        <c:choose>
                                            <c:when test="${proyecto.calificacion_evaluador == 'Aprobado'}">
                                                <!-- Si el evaluador aprobó, mostrar botón para subir radicado evaluador -->
                                                <button type="button" class="btn btn-success" data-bs-toggle="modal"
                                                    data-bs-target="#subirRadicadoEvaluadorModal">
                                                    <i class="bi bi-upload"></i> Subir radicado evaluador
                                                </button>
                                            </c:when>
                                            <c:when test="${proyecto.calificacion_director == 'Aprobado'}">
                                                <!-- Si el director aprobó, mostrar botón para subir radicado director -->
                                                <button type="button" class="btn btn-light" data-bs-toggle="modal"
                                                    data-bs-target="#subirRadicadoDirectorModal">
                                                    <i class="bi bi-upload"></i> Subir radicado director
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Si no está aprobado, mostrar botón para subir recibo -->
                                                <button type="button" class="btn btn-light" data-bs-toggle="modal"
                                                    data-bs-target="#subirReciboModal">
                                                    <i class="bi bi-upload"></i> Subir recibo de pago
                                                </button>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- Botón para asignar compañero (siempre visible si tiene proyecto) -->
                                        <!-- Botón para asignar compañero (solo visible si tiene proyecto Y estudiante2 está vacío) -->
                                        <c:if test="${proyectoAsignado.rowCount > 0}">
                                            <c:forEach var="proyecto" items="${proyectoAsignado.rows}">
                                                <c:if test="${empty proyecto.estudiante2}">
                                                    <button type="button" class="btn btn-success" data-bs-toggle="modal"
                                                        data-bs-target="#asignarCompaneroModal">
                                                        <i class="bi bi-person-plus"></i> Asignar compañero de proyecto
                                                    </button>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <!-- Si no tiene proyecto, mostrar botón para gestionar -->
                                    <button type="button" class="btn btn-light" data-bs-toggle="modal"
                                        data-bs-target="#insertarIdeaModal">
                                        <i class="bi bi-person-plus"></i> Gestionar proyecto
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Tabla de proyectos -->
                        <sql:query var="result" dataSource="${baseDeDatos}">
                            SELECT id_anteproyecto, titulo, estudiante, estudiante2, recibo_pago,
                            director, calificacion_director, radicado_director,
                            evaluador, calificacion_evaluador, radicado_evaluador, id_idea
                            FROM anteproyectos
                        </sql:query>

                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Código</th>
                                        <th>Título</th>
                                        <th>Estudiante</th>
                                        <th>Estudiante 2</th>
                                        <th>Recibo</th>
                                        <th>Director</th>
                                        <th>Cal. Director</th>
                                        <th>Rad. Director</th>
                                        <th>Evaluador</th>
                                        <th>Cal. Evaluador</th>
                                        <th>Rad. Evaluador</th>
                                        <th>Código idea</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="row" items="${result.rows}">
                                        <tr>
                                            <td>
                                                <c:out value="${row.id_anteproyecto}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.titulo}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.estudiante}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.estudiante2}" />
                                            </td>
                                            <td>
                                                <c:if test="${not empty row.recibo_pago}">
                                                    <a href="${row.recibo_pago}" target="_blank">Ver recibo</a>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:out value="${row.director}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.calificacion_director}" />
                                            </td>
                                            <td>
                                                <c:if test="${not empty row.radicado_director}">
                                                    <a href="${row.radicado_director}" target="_blank">Ver radicado</a>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:out value="${row.evaluador}" />
                                            </td>
                                            <td>
                                                <c:out value="${row.calificacion_evaluador}" />
                                            </td>
                                            <td>
                                                <c:if test="${not empty row.radicado_evaluador}">
                                                    <a href="${row.radicado_evaluador}" target="_blank">Ver radicado</a>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:out value="${row.id_idea}" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                    </main>

                    <!-- Modal para subir radicado del director (para estudiantes) -->
                    <div class="modal fade" id="subirRadicadoDirectorModal" tabindex="-1"
                        aria-labelledby="subirRadicadoDirectorModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form method="post" action="subirRadicadoDirector.jsp">
                                    <div class="modal-header bg-primary text-white">
                                        <h5 class="modal-title" id="subirRadicadoDirectorModalLabel">Subir radicado del
                                            director</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Obtener el ID del anteproyecto del estudiante actual -->
                                        <sql:query var="proyectoEstudiante" dataSource="${baseDeDatos}">
                                            SELECT id_anteproyecto FROM anteproyectos
                                            WHERE (id_estudiante = ? OR id_estudiante2 = ?)
                                            <sql:param value="${sessionScope.id}" />
                                            <sql:param value="${sessionScope.id}" />
                                        </sql:query>

                                        <c:choose>
                                            <c:when test="${proyectoEstudiante.rowCount > 0}">
                                                <c:forEach var="proyecto" items="${proyectoEstudiante.rows}">
                                                    <input type="hidden" name="id_anteproyecto"
                                                        value="${proyecto.id_anteproyecto}">
                                                </c:forEach>

                                                <div class="mb-3">
                                                    <label for="radicado_director" class="form-label">Enlace del
                                                        documento radicado:</label>
                                                    <input type="url" class="form-control" id="radicado_director"
                                                        name="radicado_director"
                                                        placeholder="https://drive.google.com/radicado.pdf" required>
                                                    <div class="form-text">Sube el documento de radicado proporcionado
                                                        por tu director.</div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="alert alert-warning">
                                                    No tienes proyectos asignados como estudiante.
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-primary" ${proyectoEstudiante.rowCount==0
                                            ? 'disabled' : '' }>
                                            Guardar radicado
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Modal para subir radicado del evaluador (para estudiantes) -->
                    <div class="modal fade" id="subirRadicadoEvaluadorModal" tabindex="-1"
                        aria-labelledby="subirRadicadoEvaluadorModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form method="post" action="subirRadicadoEvaluador.jsp">
                                    <div class="modal-header bg-success text-white">
                                        <h5 class="modal-title" id="subirRadicadoEvaluadorModalLabel">Subir radicado del
                                            evaluador</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Obtener el ID del anteproyecto del estudiante actual -->
                                        <sql:query var="proyectoEstudiante" dataSource="${baseDeDatos}">
                                            SELECT id_anteproyecto FROM anteproyectos
                                            WHERE (id_estudiante = ? OR id_estudiante2 = ?)
                                            <sql:param value="${sessionScope.id}" />
                                            <sql:param value="${sessionScope.id}" />
                                        </sql:query>

                                        <c:choose>
                                            <c:when test="${proyectoEstudiante.rowCount > 0}">
                                                <c:forEach var="proyecto" items="${proyectoEstudiante.rows}">
                                                    <input type="hidden" name="id_anteproyecto"
                                                        value="${proyecto.id_anteproyecto}">
                                                </c:forEach>

                                                <div class="mb-3">
                                                    <label for="radicado_evaluador" class="form-label">Enlace del
                                                        documento radicado:</label>
                                                    <input type="url" class="form-control" id="radicado_evaluador"
                                                        name="radicado_evaluador"
                                                        placeholder="https://drive.google.com/radicado-evaluador.pdf"
                                                        required>
                                                    <div class="form-text">Sube el documento de radicado proporcionado
                                                        por tu evaluador.</div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="alert alert-warning">
                                                    No tienes proyectos asignados como estudiante.
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary"
                                            data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-success" ${proyectoEstudiante.rowCount==0
                                            ? 'disabled' : '' }>
                                            Guardar radicado
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Modal para seleccionar idea (solo visible si no tiene proyecto) -->
                    <c:if test="${proyectoAsignado.rowCount == 0}">
                        <div class="modal fade" id="insertarIdeaModal" tabindex="-1"
                            aria-labelledby="insertarIdeaModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <form method="post" action="registrarAnteproyecto.jsp">
                                        <div class="modal-header bg-success text-white">
                                            <h5 class="modal-title" id="insertarIdeaModalLabel">Seleccionar Idea</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                            <!-- Consulta para obtener SOLO ideas NO asignadas a proyectos -->
                                            <sql:query var="ideas" dataSource="${baseDeDatos}">
                                                SELECT i.id_idea, i.titulo
                                                FROM ideas i
                                                WHERE NOT EXISTS (
                                                SELECT 1
                                                FROM anteproyectos a
                                                WHERE a.id_idea = i.id_idea -- Relación entre anteproyecto e idea
                                                )
                                            </sql:query>

                                            <div class="mb-3">
                                                <label for="id_idea" class="form-label">Idea disponible</label>
                                                <select class="form-select" name="id_idea" required>
                                                    <option value="">-- Seleccione una idea --</option>
                                                    <c:forEach var="idea" items="${ideas.rows}">
                                                        <option value="${idea.id_idea}">${idea.titulo}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-success">Registrar
                                                anteproyecto</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Modal para asignar compañero de proyecto -->
                    <div class="modal fade" id="asignarCompaneroModal" tabindex="-1"
                        aria-labelledby="asignarCompaneroModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <form method="post" action="asignarCompañero.jsp">
                                    <div class="modal-header bg-info text-white">
                                        <h5 class="modal-title" id="asignarCompaneroModalLabel">Asignar compañero de
                                            proyecto</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Consulta MEJORADA para obtener el ID del anteproyecto del usuario actual -->
                                        <sql:query var="proyectoUsuario" dataSource="${baseDeDatos}">
                                            SELECT id_anteproyecto FROM anteproyectos
                                            WHERE id_estudiante = ? -- Busca exactamente por ID
                                            <sql:param value="${sessionScope.id}" />
                                        </sql:query>

                                        <c:forEach var="proyecto" items="${proyectoUsuario.rows}">
                                            <input type="hidden" name="id_anteproyecto"
                                                value="${proyecto.id_anteproyecto}">
                                        </c:forEach>

                                        <!-- Consulta para obtener estudiantes disponibles -->
                                        <sql:query var="estudiantes" dataSource="${baseDeDatos}">
                                            SELECT u.id_usuario, u.nombre, u.apellido
                                            FROM usuarios u
                                            WHERE u.rol = 'Estudiante'
                                            AND u.id_usuario != ?
                                            AND NOT EXISTS (
                                            SELECT 1
                                            FROM anteproyectos a
                                            WHERE a.id_estudiante = u.id_usuario
                                            OR a.id_estudiante2 = u.id_usuario
                                            )
                                            <sql:param value="${sessionScope.id}" />
                                        </sql:query>

                                        <div class="mb-3">
                                            <label for="id_estudiante2" class="form-label">Seleccione el compañero de
                                                proyecto:</label>
                                            <select class="form-select" name="id_estudiante2" required>
                                                <option value="">-- Seleccione un estudiante --</option>
                                                <c:forEach var="estudiante" items="${estudiantes.rows}">
                                                    <option value="${estudiante.id_usuario}">
                                                        ${estudiante.nombre} ${estudiante.apellido}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-info">Asignar compañero</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Modal para subir recibo de pago -->
                    <div class="modal fade" id="subirReciboModal" tabindex="-1" aria-labelledby="subirReciboModalLabel"
                        aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form method="post" action="subirRecibo.jsp">
                                    <div class="modal-header bg-success text-white">
                                        <h5 class="modal-title" id="subirReciboModalLabel">Subir recibo de pago</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Consulta corregida: Solo busca por ID del estudiante (evita coincidencias con nombres) -->
                                        <sql:query var="proyectoUsuario" dataSource="${baseDeDatos}">
                                            SELECT id_anteproyecto FROM anteproyectos
                                            WHERE id_estudiante = ?
                                            <sql:param value="${sessionScope.id}" />
                                        </sql:query>

                                        <c:forEach var="proyecto" items="${proyectoUsuario.rows}">
                                            <input type="hidden" name="id_anteproyecto"
                                                value="${proyecto.id_anteproyecto}">
                                        </c:forEach>

                                        <div class="mb-3">
                                            <label for="recibo_pago" class="form-label">Enlace del recibo de
                                                pago:</label>
                                            <input type="url" class="form-control" id="recibo_pago" name="recibo_pago"
                                                placeholder="https://ejemplo.com/recibo.pdf" required>
                                            <div class="form-text">Por favor, ingrese un enlace válido al recibo de
                                                pago.</div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="submit" class="btn btn-success">Guardar recibo</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="white-line"></div>

                    <footer class="text-center bg-success text-white py-3">
                        <div class="container">
                            &copy; 2025 - Todos los derechos reservados
                        </div>
                    </footer>

                    <div class="white-line"></div>

                    <!-- Bootstrap JS -->


                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                </body>

                </html>