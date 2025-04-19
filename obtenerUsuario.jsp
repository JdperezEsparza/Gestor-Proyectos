<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<sql:query var="usuario" dataSource="${baseDeDatos}">
    SELECT id_usuario, nombre, apellido, correo, contraseña, rol FROM usuarios WHERE id_usuario = ?
    <sql:param value="${param.id}" />
</sql:query>

<c:choose>
    <c:when test="${usuario.rowCount > 0}">
        <c:set var="row" value="${usuario.rows[0]}" />
        {
            "id_usuario": "${row.id_usuario}",
            "nombre": "${row.nombre}",
            "apellido": "${row.apellido}",
            "correo": "${row.correo}",
            "contraseña": "${row.contraseña}",
            "rol": "${row.rol}"
        }
    </c:when>
    <c:otherwise>
        {"error": "Usuario no encontrado"}
    </c:otherwise>
</c:choose>