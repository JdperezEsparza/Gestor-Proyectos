<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="Styles/style3.css">
</head>
<body>

    <div class="white-line"></div>

    <header class="text-center bg-warning text-white py-3">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="mb-0">Rol: ${sessionScope.rol}</h1>
                <div class="dropdown">
                    <button class="btn btn-light dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle"></i> ${sessionScope.nombre}
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="#"><i class="bi bi-person"></i> Perfil</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="index.jsp"><i class="bi bi-box-arrow-right"></i> Cerrar sesión</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>

    <div class="white-line"></div>

    <main class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <div class="card">
                    <div class="card-header bg-warning text-white">
                        Menú de Navegación
                    </div>
                    <div class="list-group list-group-flush">
                        
                       
                        
                        <a href="gestionProyectosDocente.jsp" class="list-group-item list-group-item-action">
                            <i class="bi bi-kanban"></i> Gestión de proyectos
                        </a>
                        
                        <a href="https://www.dropbox.com/scl/fo/pudgcaq639agy7t06ahjs/AN084HnuyHffgYL5i--v_Ks/DOCUMENTOS%20DE%20GRADO?rlkey=6s0b9ajweteyx2ang7ywvk6xm&e=2&subfolder_nav_tracking=1&dl=0" class="list-group-item list-group-item-action" target="_blank">
                            <i class="bi bi-file-earmark-text"></i> Formatos de proyectos
                        </a>
                        
                        <a href="https://www.uts.edu.co/sitio/wp-content/uploads/2025/01/ACUERDO-03-001-MODIFICACION-CALENDARIO-ACADE-PRESENCIAL.pdf" class="list-group-item list-group-item-action" target="_blank">
                            <i class="bi bi-calendar-event"></i> Calendario académico
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-md-9">
                <div class="card">
                    <div class="card-header bg-warning text-white">
                        <h4 class="mb-0">Bienvenido, ${sessionScope.nombre} ${sessionScope.apellido}</h4>
                    </div>
                    <div class="card-body">
                        <div class="alert alert-info">
                            <i class="bi bi-info-circle"></i> Rol actual: <strong>${sessionScope.rol}</strong>
                        </div>
                        
                        <!-- Contenido principal según el rol -->
                        <c:choose>
                            <c:when test="${sessionScope.rol == 'Docente'}">
                                <div class="alert alert-warning">
                                    <h5><i class="bi bi-shield-lock"></i> Panel de docencia</h5>
                                    <p>Acceso a las funciones de docencia</p>
                                    <div class="container mt-5">
                                        <div class="row row-cols-1 row-cols-md-2 g-4">
                                          
                                         
                                      
                                          <div class="col">
                                            <a href="gestionProyectosDocente.jsp" class="text-decoration-none">
                                              <div class="card  h-100 text-center special-card">
                                                <div class="card-body">
                                                  <i class="bi bi-kanban fs-1"></i>
                                                  <h5 class="card-title mt-2">Gestión de proyectos</h5>
                                                </div>
                                              </div>
                                            </a>
                                          </div>
                                      
                                          <div class="col">
                                            <a href="https://www.dropbox.com/scl/fo/pudgcaq639agy7t06ahjs/AN084HnuyHffgYL5i--v_Ks/DOCUMENTOS%20DE%20GRADO?rlkey=6s0b9ajweteyx2ang7ywvk6xm&e=2&subfolder_nav_tracking=1&dl=0" class="text-decoration-none" target="_blank">
                                              <div class="card  h-100 text-center special-card">
                                                <div class="card-body">
                                                  <i class="bi bi-file-earmark-text fs-1"></i>
                                                  <h5 class="card-title mt-2">Formatos de proyectos</h5>
                                                </div>
                                              </div>
                                            </a>
                                          </div>
                                      
                                          <div class="col">
                                            <a href="https://www.uts.edu.co/sitio/wp-content/uploads/2025/01/ACUERDO-03-001-MODIFICACION-CALENDARIO-ACADE-PRESENCIAL.pdf" class="text-decoration-none" target="_blank">
                                              <div class="card  h-100 text-center special-card" >
                                                <div class="card-body">
                                                  <i class="bi bi-calendar-event fs-1"></i>
                                                  <h5 class="card-title mt-2">Calendario académico</h5>
                                                </div>
                                              </div>
                                            </a>
                                          </div>
                                      
                                        </div>
                                      </div>


                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-success">
                                    <h5><i class="bi bi-person-check"></i> Panel de Usuario</h5>
                                    <p>Bienvenido al sistema de gestión de proyectos</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
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
</body>
</html>