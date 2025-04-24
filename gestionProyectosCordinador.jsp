<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
      <%@include file="WEB-INF/jspf/conexion.jspf" %>

        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <title>Gestion de proyectos</title>
          <!-- Bootstrap CSS -->
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
          <!-- Bootstrap Icons -->
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
          <link rel="stylesheet" href="Styles/style5.css">
        </head>

        <body>
          <c:if test="${not empty sessionScope.errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
              ${sessionScope.errorMessage}
              <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="errorMessage" scope="session" />
          </c:if>
          <div class="white-line"></div>

          <header class="text-center bg-primary text-white py-3">
            <div class="d-flex justify-content-between align-items-center px-3">
              <div>

              </div>
              <div>
                <h2 class="mb-0">Rol: ${sessionScope.rol}</h2>
                <h3 class="mb-0">Gestión de proyectos</h3>
              </div>
              <div>
                <a href="coordinacion.jsp" class="btn btn-light me-2">
                  <i class="bi bi-arrow-left"></i> Volver atrás
                </a>
              </div>
            </div>
          </header>

          <div class="white-line"></div>

          <main class="container my-4">

            <div class="mb-3">

              <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#insertarIdeaModal">
                <i class="bi bi-person-plus"></i> gestionar proyectos
              </button>
            </div>



            <sql:query var="result" dataSource="${baseDeDatos}">
              SELECT id_anteproyecto, titulo, estudiante,estudiante2,recibo_pago,director,
              calificacion_director,radicado_director, evaluador,
              calificacion_evaluador,radicado_evaluador
              ,id_idea FROM anteproyectos
            </sql:query>

            <div class="table-responsive">
              <table class="table table-striped table-hover">
                <thead class="table-primary">
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
                          <a href="${row.radicado_director}" target="_blank">Ver recibo</a>
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
                          <a href="${row.radicado_evaluador}" target="_blank">Ver recibo</a>
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

          <footer class="text-center bg-primary text-white py-3">
            <div class="container">
              &copy; 2025 - Todos los derechos reservados
            </div>
          </footer>

          <div class="white-line"></div>

          <!-- modal gestionar proyectos -->
          <div class="modal fade" id="insertarIdeaModal" tabindex="-1" aria-labelledby="insertarIdeaModalLabel"
            aria-hidden="true">
            <div class="modal-dialog modal-lg">
              <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                  <h5 class="modal-title" id="insertarIdeaModalLabel">Gestionar Proyectos</h5>
                  <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                    aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  <form action="gestionarProyectosCoord.jsp" method="post">
                    <!-- Campos del formulario con valores preservados -->
                    <div class="mb-3">
                      <label for="anteproyecto" class="form-label">Seleccione un anteproyecto:</label>
                      <select class="form-select" id="anteproyecto" name="id_anteproyecto" required>
                        <option value="" selected disabled>Seleccione un anteproyecto</option>
                        <sql:query var="anteproyectos" dataSource="${baseDeDatos}">
                          SELECT id_anteproyecto, titulo
                          FROM anteproyectos
                          WHERE (id_director IS NULL OR id_director = '')
                          AND (id_evaluador IS NULL OR id_evaluador = '')
                        </sql:query>
                        <c:forEach var="anteproyecto" items="${anteproyectos.rows}">
                          <option value="${anteproyecto.id_anteproyecto}"
                            ${param.id_anteproyecto==anteproyecto.id_anteproyecto ? 'selected' : '' }>
                            ${anteproyecto.titulo}
                          </option>
                        </c:forEach>
                      </select>
                    </div>

                    <div class="mb-3">
                      <label for="director" class="form-label">Seleccione director:</label>
                      <select class="form-select" id="director" name="id_director" required>
                        <option value="" selected disabled>Seleccione un director</option>
                        <sql:query var="docentes" dataSource="${baseDeDatos}">
                          SELECT id_usuario, nombre, apellido FROM usuarios WHERE rol = 'docente'
                        </sql:query>
                        <c:forEach var="docente" items="${docentes.rows}">
                          <option value="${docente.id_usuario}" ${param.id_director==docente.id_usuario ? 'selected'
                            : '' }>
                            ${docente.nombre} ${docente.apellido}
                          </option>
                        </c:forEach>
                      </select>
                    </div>

                    <div class="mb-3">
                      <label for="evaluador" class="form-label">Seleccione evaluador:</label>
                      <select class="form-select" id="evaluador" name="id_evaluador" required>
                        <option value="" selected disabled>Seleccione un evaluador</option>
                        <c:forEach var="docente" items="${docentes.rows}">
                          <option value="${docente.id_usuario}" ${param.id_evaluador==docente.id_usuario ? 'selected'
                            : '' }>
                            ${docente.nombre} ${docente.apellido}
                          </option>
                        </c:forEach>
                      </select>
                    </div>

                    <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                      <button type="submit" class="btn btn-primary">Asignar</button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>

          <!-- Bootstrap JS -->
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        </body>

        </html>