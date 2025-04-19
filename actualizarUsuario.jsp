<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<%
// Validar parámetros
String id = request.getParameter("id_usuario");
String nombre = request.getParameter("nombre");
String apellido = request.getParameter("apellido");
String correo = request.getParameter("correo");
String contrasena = request.getParameter("contrasena");
String rol = request.getParameter("rol");

if(id == null || nombre == null || correo == null || contrasena == null || rol == null) {
    response.sendRedirect("gestionUsuarios.jsp?error=Parámetros incompletos");
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
        UPDATE usuarios SET 
        nombre = ?, 
        apellido = ?,
        correo = ?, 
        contraseña = ?, 
        rol = ?
        WHERE id_usuario = ?
        <sql:param value="<%=nombre%>" />
        <sql:param value ="<%=apellido%>" />
        <sql:param value="<%=correo%>" />
        <sql:param value="<%=contrasena%>" />
        <sql:param value="<%=rol%>" />
        <sql:param value="<%=id%>" />
    </sql:update>

    <c:choose>
        <c:when test="${resultado > 0}">
            <script type="text/javascript">
                window.location.href = "gestionUsuarios.jsp?success=Usuario actualizado correctamente";
            </script>
        </c:when>
        <c:otherwise>
            <script type="text/javascript">
                window.location.href = "gestionUsuarios.jsp?error=Error al actualizar el usuario";
            </script>
        </c:otherwise>
    </c:choose>
</body>
</html>