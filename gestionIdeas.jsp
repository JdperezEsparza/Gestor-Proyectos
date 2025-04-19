<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
      <%@include file="WEB-INF/jspf/conexion.jspf" %>

        <!DOCTYPE html>
        <html>

        <head>
          <meta charset="UTF-8">
          <title>Panel de Control</title>
          <!-- Bootstrap CSS -->
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
          <!-- Bootstrap Icons -->
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
          <link rel="stylesheet" href="Styles/style5.css">
        </head>

        <body>

          <div class="white-line"></div>

          <header class="text-center bg-primary text-white py-3">
            <div class="d-flex justify-content-between align-items-center px-3">
              <div>
                
              </div>
              <div>
                <h2 class="mb-0">Rol: ${sessionScope.rol}</h2>
                <h3 class="mb-0">Gestión de ideas</h3>
              </div>
              <div>
                <a href="javascript:history.back()" class="btn btn-light me-2">
                  <i class="bi bi-arrow-left"></i> Volver atrás
                </a>
              </div>
            </div>
          </header>

          <div class="white-line"></div>


          <main class="container my-4">

            <div class="mb-3">

              <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#insertarIdeaModal">
                <i class="bi bi-person-plus"></i> Insertar Ideas
              </button>
            </div>



            <sql:query var="result" dataSource="${baseDeDatos}">
              SELECT id_idea, titulo, descripcion, tecnologias, fecha_proposicion, observaciones,estado rol FROM ideas
            </sql:query>

            <div class="table-responsive">
              <table class="table table-striped table-hover">
                <thead class="table-primary">
                  <tr>
                    <th>ID</th>
                    <th>Titulo</th>
                    <th>Descripcion</th>
                    <th>Tecnologias</th>
                    <th>fecha de la propuesta</th>
                    <th>Estado</th>
                    <th>Observaciones</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="row" items="${result.rows}">
                    <tr>
                      <td>
                        <c:out value="${row.id_idea}" />
                      </td>
                      <td>
                        <c:out value="${row.titulo}" />
                      </td>
                      <td>
                        <c:out value="${row.descripcion}" />
                      </td>
                      <td>
                        <c:out value="${row.tecnologias}" />
                      </td>
                      <td>
                        <c:out value="${row.fecha_proposicion}" />
                      </td>
                      <td>
                        <c:out value="${row.estado}" />
                      </td>
                      <td>
                        <c:out value="${row.observaciones}" />
                      </td>
                      <td>
                        <!-- Botón para Editar -->
                        <a href="#" class="btn btn-info btn-sm " data-bs-toggle="modal"
                          data-bs-target="#editarIdeaModal" data-id="${row.id_idea}" data-titulo="${row.titulo}"
                          data-descripcion="${row.descripcion}" data-tecnologias="${row.tecnologias}"
                          data-fecha_proposicion="${row.fecha_proposicion}" data-observaciones="${row.observaciones}"
                          data-estado="${row.estado}">
                          <i class="bi bi-pencil-square"></i> Editar
                        </a>
                        <!-- Botón para Eliminar -->
                        <button class="btn btn-danger btn-sm" data-bs-toggle="modal"
                          data-bs-target="#confirmarEliminarIdeaModal" data-id="${row.id_idea}">
                          <i class="bi bi-trash"></i> Eliminar
                        </button>
                      </td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </main>

          <!-- Modal para insertar idea -->
          <div class="modal fade" id="insertarIdeaModal" tabindex="-1" aria-labelledby="insertarIdeaModalLabel"
            aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <form action="insertarIdea.jsp" method="POST">
                  <div class="modal-header">
                    <h5 class="modal-title" id="insertarIdeaModalLabel">Insertar Nueva Idea</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <div class="mb-3">
                      <label for="titulo" class="form-label">Título</label>
                      <input type="text" class="form-control" id="titulo" name="titulo" required>
                    </div>
                    <div class="mb-3">
                      <label for="descripcion" class="form-label">Descripción</label>
                      <input type="text" class="form-control" id="descripcion" name="descripcion" required>
                    </div>
                    <div class="mb-3">
                      <label for="tecnologias" class="form-label">Tecnologías</label>
                      <input type="text" class="form-control" id="tecnologias" name="tecnologias" required>
                    </div>
                    <div class="mb-3">
                      <label for="fecha_proposicion" class="form-label">Fecha de Proposición</label>
                      <input type="date" class="form-control" id="fecha_proposicion" name="fecha_proposicion" required>
                    </div>
                    <div class="mb-3">
                      <label for="estado" class="form-label">Estado</label>
                      <input type="text" class="form-control" id="estado" name="estado" value="Libre" readonly>
                    </div>
                    <div class="mb-3">
                      <label for="observaciones" class="form-label">Observaciones</label>
                      <textarea class="form-control" id="observaciones" name="observaciones" rows="3"></textarea>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Guardar Idea</button>
                  </div>
                </form>
              </div>
            </div>
          </div>

          <!-- Modal Editar Idea -->
          <div class="modal fade" id="editarIdeaModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <form action="actualizarIdea.jsp" method="POST">
                  <div class="modal-header">
                    <h5 class="modal-title">Editar Idea</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                    <input type="hidden" name="id_idea" id="edit-id">

                    <div class="mb-3">
                      <label class="form-label">Título</label>
                      <input type="text" class="form-control" name="titulo" id="edit-titulo" required>
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Descripción</label>
                      <input type="text" class="form-control" name="descripcion" id="edit-descripcion" required>
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Tecnologías</label>
                      <input type="text" class="form-control" name="tecnologias" id="edit-tecnologias" required>
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Fecha de Proposición</label>
                      <input type="date" class="form-control" name="fecha_proposicion" id="edit-fecha" required>
                    </div>
                    <div class="mb-3">
                      <label for="estado" class="form-label">Estado</label>
                      <input type="text" class="form-control" id="edit-estado" name="estado" readonly>
                    </div>
                    <div class="mb-3">
                      <label class="form-label">Observaciones</label>
                      <textarea class="form-control" name="observaciones" id="edit-observaciones" rows="3"></textarea>
                    </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
          <!-- Modal de Confirmación para Eliminar -->
          <div class="modal fade" id="confirmarEliminarIdeaModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title">Confirmar Eliminación</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                  ¿Estás seguro que deseas eliminar esta idea? Esta acción no se puede
                  deshacer.
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                  <a id="confirmarEliminarIdeaBtn" href="#" class="btn btn-danger">Eliminar</a>
                </div>
              </div>
            </div>
          </div>


          <div class="white-line"></div>

          <footer class="text-center bg-primary text-white py-3">
            <div class="container">
              &copy; 2025 - Todos los derechos reservados
            </div>
          </footer>

          <div class="white-line"></div>

          <!-- Bootstrap JS -->
          <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
          <script src="Scripts/scriptIdeas.js"></script>
        </body>

        </html>