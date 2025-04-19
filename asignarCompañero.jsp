<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>

<%
// Depuración: Mostrar parámetros recibidos
System.out.println("Parámetros recibidos:");
System.out.println("id_anteproyecto: " + request.getParameter("id_anteproyecto"));
System.out.println("id_estudiante2: " + request.getParameter("id_estudiante2"));
%>

<c:catch var="exception">
    <!-- Obtener datos del estudiante seleccionado -->
    <sql:query var="estudiante2Data" dataSource="${baseDeDatos}">
        SELECT nombre, apellido FROM usuarios WHERE id_usuario = ?
        <sql:param value="${param.id_estudiante2}" />
    </sql:query>

    <c:set var="nombreCompletoEstudiante2" value="" />
    <c:forEach var="e" items="${estudiante2Data.rows}">
        <c:set var="nombreCompletoEstudiante2" value="${e.nombre} ${e.apellido}" />
    </c:forEach>

    <!-- Actualizar el anteproyecto con el compañero -->
    <sql:update dataSource="${baseDeDatos}" var="updateResult">
        UPDATE anteproyectos 
        SET estudiante2 = ?, 
            id_estudiante2 = ?
        WHERE id_anteproyecto = ?
        <sql:param value="${nombreCompletoEstudiante2}" />
        <sql:param value="${param.id_estudiante2}" />
        <sql:param value="${param.id_anteproyecto}" />
    </sql:update>

    <%
    // Depuración: Mostrar resultado de la actualización
    System.out.println("Filas afectadas: " + pageContext.findAttribute("updateResult"));
    %>
</c:catch>

<c:choose>
    <c:when test="${not empty exception}">
        <%
        // Depuración: Mostrar error
        System.out.println("Error al asignar compañero: " + pageContext.findAttribute("exception"));
        %>
        <c:redirect url="gestionProyectosEstudiante.jsp?error=Error al asignar compañero: ${exception.message}" />
    </c:when>
    <c:when test="${updateResult > 0}">
        <c:redirect url="gestionProyectosEstudiante.jsp?success=Compañero asignado correctamente" />
    </c:when>
    <c:otherwise>
        <c:redirect url="gestionProyectosEstudiante.jsp?error=No se pudo asignar el compañero (ningún registro afectado)" />
    </c:otherwise>
</c:choose>