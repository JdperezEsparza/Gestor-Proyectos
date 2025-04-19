<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<c:catch var="dbError">
    <sql:query dataSource="${baseDeDatos}" var="resultado">
        SELECT id_usuario, nombre, apellido, correo, contraseña, rol 
        FROM usuarios
        WHERE correo = ? AND contraseña = ?
        <sql:param value="${param.usuario}" />
        <sql:param value="${param.clave}" />
    </sql:query>
</c:catch>

<c:choose>
    <%-- Manejo de errores de base de datos --%>
    <c:when test="${not empty dbError}">
        <c:redirect url="index.jsp?error=db_error" />
    </c:when>
    
    <%-- Procesar credenciales --%>
    <c:when test="${not empty param.usuario and not empty param.clave}">
        <c:choose>
            <c:when test="${resultado.rowCount == 1}">
                <c:set var="usuario" value="${resultado.rows[0]}" />
                
                <%-- Crear variables de sesión --%>
                <c:set var="id" value="${usuario.id_usuario}" scope="session" />
                <c:set var="nombre" value="${usuario.nombre}" scope="session" />
                <c:set var="apellido" value="${usuario.apellido}" scope="session" />
                <c:set var="correo" value="${usuario.correo}" scope="session" />
                <c:set var="rol" value="${usuario.rol}" scope="session" />
                <c:set var="autenticado" value="true" scope="session" />
                
                <%-- Redirección según rol --%>
                <c:choose>
                    <c:when test="${usuario.rol == 'Administrador'}">
                        <c:redirect url="admin.jsp" />
                    </c:when>
                    <c:when test="${usuario.rol == 'Docente'}">
                        <c:redirect url="docente.jsp" />
                    </c:when>
                    <c:when test="${usuario.rol == 'Estudiante'}">
                        <c:redirect url="estudiante.jsp" />
                    </c:when>
                    <c:when test="${usuario.rol == 'Coordinacion'}">
                        <c:redirect url="coordinacion.jsp" />
                    </c:when>
                    <c:otherwise>
                        <c:redirect url="index.jsp" />
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <%-- Redireccionar al index con parámetro de error --%>
                <c:redirect url="index.jsp?error=invalid_credentials" />
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:otherwise>
        <%-- Redireccionar al index con parámetro de error --%>
        <c:redirect url="index.jsp?error=missing_data" />
    </c:otherwise>
</c:choose>