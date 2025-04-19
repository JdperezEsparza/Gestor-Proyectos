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
                    <link rel="stylesheet" href="Styles/style3.css">
                </head>

                <body>

                    <div class="white-line"></div>

                    <header class="text-center bg-warning text-white py-3">
                        <div class="d-flex justify-content-between align-items-center px-3">
                            <div></div>
                            <div>
                                <h2 class="mb-0">Rol: ${sessionScope.rol}</h2>
                                <h3 class="mb-0">Gestión de proyectos</h3>
                            </div>
                            <div>
                                <a href="docente.jsp" class="btn btn-light me-2">
                                    <i class="bi bi-arrow-left"></i> Volver atrás
                                </a>
                            </div>
                        </div>
                    </header>

                    <div class="white-line"></div>

                    <main class="container my-4">

                        <!-- Consulta para verificar si el usuario ya tiene un proyecto asignado -->
                        <sql:query var="proyectoAsignado" dataSource="${baseDeDatos}">
                            SELECT id_anteproyecto FROM anteproyectos
                            WHERE id_director = ? OR director = ? OR id_evaluador = ? OR evaluador = ?
                            <sql:param value="${sessionScope.id}" />
                            <sql:param value="${sessionScope.nombreCompleto}" />
                            <sql:param value="${sessionScope.id}" />
                            <sql:param value="${sessionScope.nombreCompleto}" />
                        </sql:query>



                        <!-- Consulta de datos de los anteproyectos -->
                        <sql:query var="result" dataSource="${baseDeDatos}">
                            SELECT id_anteproyecto, titulo, estudiante,estudiante2,recibo_pago,director,
                            calificacion_director,radicado_director, evaluador,
                            calificacion_evaluador,radicado_evaluador
                            ,id_idea FROM anteproyectos
                        </sql:query>

                        <div class="mb-3">

                            <button type="button" class="btn btn-warning" data-bs-toggle="modal"
                                data-bs-target="#insertarUsuarioModal">
                                <i class="bi bi-person-plus"></i> Gestionar proyectos
                            </button>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>Codigo anteproyecto</th>
                                        <th>Título</th>
                                        <th>Estudiante</th>
                                        <th>Estudiante 2</th>
                                        <th>Recibo proyecto</th>
                                        <th>Director</th>
                                        <th>Calificación Director</th>
                                        <th>Radicado</th>
                                        <th>Evaluador</th>
                                        <th>Calificación Evaluador</th>
                                        <th>Radicado</th>
                                        <th>Codigo idea</th>
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


                    <div class="white-line"></div>

                    <footer class="text-center bg-warning text-white py-3">
                        <div class="container">
                            &copy; 2025 - Todos los derechos reservados
                        </div>
                    </footer>

                    <div class="white-line"></div>


                    <!-- Bootstrap JS -->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

                    <!-- Modal para gestionar calificaciones -->
                  
                    <div class="modal fade" id="insertarUsuarioModal" tabindex="-1"
                        aria-labelledby="insertarUsuarioModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header bg-warning text-white">
                                    <h5 class="modal-title" id="insertarUsuarioModalLabel">Gestionar Calificaciones</h5>
                                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <sql:query var="proyectoUsuario" dataSource="${baseDeDatos}">
                                        SELECT a.id_anteproyecto, a.titulo,
                                        CASE WHEN a.id_director = ${sessionScope.id} THEN 'director'
                                        WHEN a.id_evaluador = ${sessionScope.id} THEN 'evaluador'
                                        ELSE 'ninguno' END AS rol_en_proyecto,
                                        a.radicado_director, a.calificacion_director, a.calificacion_evaluador
                                        FROM anteproyectos a
                                        WHERE a.id_director = ${sessionScope.id} OR a.id_evaluador = ${sessionScope.id}
                                    </sql:query>

                                    <c:choose>
                                        <c:when test="${proyectoUsuario.rowCount > 0}">
                                            <div class="mb-3">
                                                <label class="form-label">Proyectos asignados:</label>
                                                <c:forEach var="proyecto" items="${proyectoUsuario.rows}">
                                                    <div class="card mb-3">
                                                        <div class="card-body">
                                                            <h5 class="card-title">${proyecto.titulo}</h5>
                                                            <p class="card-text">
                                                                <strong>Rol:</strong> ${proyecto.rol_en_proyecto}
                                                            </p>

                                                            <c:choose>
                                                               
                                                                <c:when
                                                                    test="${proyecto.rol_en_proyecto == 'director'}">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${proyecto.calificacion_evaluador == 'Aprobado'}">
                                                                            <div class="alert alert-info">
                                                                                La calificación del evaluador está
                                                                                marcada como "Aprobado", no puedes
                                                                                modificar tu calificación.
                                                                            </div>
                                                                            <div class="mb-3">
                                                                                <label class="form-label">Tu
                                                                                    calificación actual:</label>
                                                                                <input type="text" class="form-control"
                                                                                    value="${proyecto.calificacion_director}"
                                                                                    readonly>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <form
                                                                                action="actualizarCalificacionDirector.jsp"
                                                                                method="post">
                                                                                <div class="mb-3">
                                                                                    <label
                                                                                        for="calificacionDir_${proyecto.id_anteproyecto}"
                                                                                        class="form-label">Calificación
                                                                                        como Director:</label>
                                                                                    <select class="form-select"
                                                                                        id="calificacionDir_${proyecto.id_anteproyecto}"
                                                                                        name="calificacion_director"
                                                                                        required>
                                                                                        <option value="Sin revisar"
                                                                                            ${proyecto.calificacion_director=='Sin revisar'
                                                                                            ? 'selected' : '' }>Sin
                                                                                            revisar</option>
                                                                                        <option value="Correcciones"
                                                                                            ${proyecto.calificacion_director=='Correcciones'
                                                                                            ? 'selected' : '' }>
                                                                                            Correcciones</option>
                                                                                        <option value="Aprobado"
                                                                                            ${proyecto.calificacion_director=='Aprobado'
                                                                                            ? 'selected' : '' }>Aprobado
                                                                                        </option>
                                                                                        <option value="No aprobado"
                                                                                            ${proyecto.calificacion_director=='No aprobado'
                                                                                            ? 'selected' : '' }>No
                                                                                            aprobado</option>
                                                                                    </select>
                                                                                    <input type="hidden"
                                                                                        name="id_anteproyecto"
                                                                                        value="${proyecto.id_anteproyecto}">
                                                                                </div>
                                                                                <div class="text-end">
                                                                                    <button type="submit"
                                                                                        class="btn btn-warning btn-sm">Actualizar
                                                                                        Calificación</button>
                                                                                </div>
                                                                            </form>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:when>

                                                                
                                                                <c:when
                                                                    test="${proyecto.rol_en_proyecto == 'evaluador' and not empty proyecto.radicado_director}">
                                                                    <c:choose>
                                                                        <c:when
                                                                            test="${proyecto.calificacion_evaluador == 'Aprobado'}">
                                                                            <div class="alert alert-info">
                                                                                La calificación como evaluador ya está
                                                                                marcada como "Aprobado" y no puede
                                                                                modificarse.
                                                                            </div>
                                                                            <input type="hidden"
                                                                                name="calificacion_evaluador"
                                                                                value="Aprobado">
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <form
                                                                                action="actualizarCalificacionEvaluador.jsp"
                                                                                method="post">
                                                                                <div class="mb-3">
                                                                                    <label
                                                                                        for="calificacionEval_${proyecto.id_anteproyecto}"
                                                                                        class="form-label">Calificación
                                                                                        como Evaluador:</label>
                                                                                    <select class="form-select"
                                                                                        id="calificacionEval_${proyecto.id_anteproyecto}"
                                                                                        name="calificacion_evaluador"
                                                                                        required>
                                                                                        <option value="Sin revisar"
                                                                                            ${proyecto.calificacion_evaluador=='Sin revisar'
                                                                                            ? 'selected' : '' }>Sin
                                                                                            revisar</option>
                                                                                        <option value="Correcciones"
                                                                                            ${proyecto.calificacion_evaluador=='Correcciones'
                                                                                            ? 'selected' : '' }>
                                                                                            Correcciones</option>
                                                                                        <option value="Aprobado"
                                                                                            ${proyecto.calificacion_evaluador=='Aprobado'
                                                                                            ? 'selected' : '' }>Aprobado
                                                                                        </option>
                                                                                        <option value="No aprobado"
                                                                                            ${proyecto.calificacion_evaluador=='No aprobado'
                                                                                            ? 'selected' : '' }>No
                                                                                            aprobado</option>
                                                                                    </select>
                                                                                    <input type="hidden"
                                                                                        name="id_anteproyecto"
                                                                                        value="${proyecto.id_anteproyecto}">
                                                                                </div>
                                                                                <div class="text-end">
                                                                                    <button type="submit"
                                                                                        class="btn btn-warning btn-sm">Actualizar
                                                                                        Calificación</button>
                                                                                </div>
                                                                            </form>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </c:when>

                                                             
                                                                <c:when
                                                                    test="${proyecto.rol_en_proyecto == 'evaluador' and empty proyecto.radicado_director}">
                                                                    <div class="alert alert-warning">
                                                                        No puede calificar este proyecto hasta que se
                                                                        haya subido el radicado del director.
                                                                    </div>
                                                                </c:when>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:when>

                                        <c:otherwise>
                                            <div class="alert alert-info">
                                                No tienes proyectos asignados como director o evaluador.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Cerrar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </body>

                </html>