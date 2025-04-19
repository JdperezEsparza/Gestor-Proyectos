<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<%
// Obtener el ID del parámetro de la URL
String id = request.getParameter("id");

if(id == null || id.isEmpty()) {
    response.sendRedirect("gestionUsuarios.jsp?error=ID de usuario no proporcionado");
    return;
}
%>

<sql:update dataSource="${baseDeDatos}" var="resultado">
    DELETE FROM usuarios WHERE id_usuario = ?
    <sql:param value="<%=id%>" />
</sql:update>

<c:choose>
    <c:when test="${resultado > 0}">
        <script type="text/javascript">
            window.location.href = "gestionUsuarios.jsp?success=Usuario eliminado correctamente";
        </script>
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
            window.location.href = "gestionUsuarios.jsp?error=Error al eliminar el usuario";
        </script>
    </c:otherwise>
</c:choose>