<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<sql:query var="idea" dataSource="${baseDeDatos}">
    SELECT id_idea, titulo, descripcion, tecnologias, fecha_proposicion, estado, observaciones rol FROM ideas WHERE id_idea = ?
    <sql:param value="${param.id}" />
</sql:query>

<c:choose>
    <c:when test="${idea.rowCount > 0}">
        <c:set var="row" value="${idea.rows[0]}" />
        {
            "id_idea": "${row.id_idea}",
            "titulo": "${row.titulo}",
            "descripcion": "${row.descripcion}",
            "tecnologias": "${row.tecnologias}",
            "fecha_proposicion": "${row.fecha_proposicion}",
            "estado": "${row.estado}",
            "observaciones": "${row.observaciones}"
        }
    </c:when>
    <c:otherwise>
        {"error": "idea no encontrada"}
    </c:otherwise>
</c:choose>