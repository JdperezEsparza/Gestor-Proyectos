<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>

<c:if test="${param.recibo_pago != null && param.id_anteproyecto != null}">
    <sql:update dataSource="${baseDeDatos}">
        UPDATE anteproyectos 
        SET recibo_pago = ?
        WHERE id_anteproyecto = ?
        <sql:param value="${param.recibo_pago}" />
        <sql:param value="${param.id_anteproyecto}" />
    </sql:update>
    
    <c:redirect url="gestionProyectosEstudiante.jsp" />
</c:if>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error al subir recibo</title>
</head>
<body>
    <h1>Error al procesar el recibo de pago</h1>
    <p>No se proporcionaron todos los datos necesarios.</p>
    <a href="gestionProyectosEstudiante.jsp">Volver a la gestión de proyectos</a>
</body>
</html>