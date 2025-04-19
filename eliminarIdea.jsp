<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<%
// Obtener el ID del parámetro de la URL
String id = request.getParameter("id");

if(id == null || id.isEmpty()) {
    response.sendRedirect("gestionUsuarios.jsp?error=ID de idea no proporcionada");
    return;
}
%>

<sql:update dataSource="${baseDeDatos}" var="resultado">
    DELETE FROM ideas WHERE id_idea= ?
    <sql:param value="<%=id%>" />
</sql:update>

<c:choose>
    <c:when test="${resultado > 0}">
        <script type="text/javascript">
            window.location.href = "gestionIdeas.jsp?success=Idea eliminada correctamente";
        </script>
    </c:when>
    <c:otherwise>
        <script type="text/javascript">
            window.location.href = "gestionIdeas.jsp?error=Error al eliminar la Idea";
        </script>
    </c:otherwise>
</c:choose>