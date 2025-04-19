<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>

<c:if test="${param.radicado_evaluador != null && param.id_anteproyecto != null}">
    <sql:update dataSource="${baseDeDatos}">
        UPDATE anteproyectos 
        SET radicado_evaluador = ?
        WHERE id_anteproyecto = ?
        <sql:param value="${param.radicado_evaluador}" />
        <sql:param value="${param.id_anteproyecto}" />
    </sql:update>
    
    <c:redirect url="gestionProyectosEstudiante.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error al subir radicado</title>
</head>
<body>
    <h1>Error al procesar el radicado para evaluador</h1>
    <p>No se proporcionaron todos los datos necesarios.</p>
    <a href="gestionProyectosEstudiante.jsp">Volver a la gestión de proyectos</a>
</body>
</html>