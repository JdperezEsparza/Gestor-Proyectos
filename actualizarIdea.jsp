<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<%
// Validar parámetros
String id_idea = request.getParameter("id_idea");
String titulo = request.getParameter("titulo");
String descripcion = request.getParameter("descripcion");
String tecnologias = request.getParameter("tecnologias");
String fecha_proposicion = request.getParameter("fecha_proposicion");
String estado = request.getParameter("estado");
String observaciones = request.getParameter("observaciones");

if(id_idea == null || titulo == null || descripcion == null || tecnologias == null || 
   fecha_proposicion == null || observaciones == null) {
    response.sendRedirect("gestionIdeas.jsp?error=Parámetros incompletos");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Procesando actualización</title>
</head>
<body>
    <sql:update dataSource="${baseDeDatos}" var="resultado">
        UPDATE ideas SET 
        titulo = ?, 
        descripcion = ?, 
        tecnologias = ?, 
        fecha_proposicion = ?,
        estado = ?,
        observaciones = ?
        WHERE id_idea = ?
        <sql:param value="<%=titulo%>" />
        <sql:param value="<%=descripcion%>" />
        <sql:param value="<%=tecnologias%>" />
        <sql:param value="<%=fecha_proposicion%>" />
        <sql:param value="<%=estado%>" />
        <sql:param value="<%=observaciones%>" />
        <sql:param value="<%=id_idea%>" />
    </sql:update>

    <c:choose>
        <c:when test="${resultado > 0}">
            <script type="text/javascript">
                window.location.href = "gestionIdeas.jsp?success=Idea actualizada correctamente";
            </script>
        </c:when>
        <c:otherwise>
            <script type="text/javascript">
                window.location.href = "gestionIdeas.jsp?error=Error al actualizar la idea";
            </script>
        </c:otherwise>
    </c:choose>
</body>
</html>