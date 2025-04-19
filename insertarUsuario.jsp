<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<%-- Validar que el rol sea uno de los permitidos --%>
<c:set var="rolPermitido" value="${param.rol == 'Estudiante' || param.rol == 'Docente' || param.rol == 'Coordinacion'}" />

<c:choose>
    <%-- Si el rol no es válido, redirigir con error --%>
    <c:when test="${not rolPermitido}">
        <c:redirect url="gestionUsuarios.jsp?error=3" />
    </c:when>
    
    <%-- Si el rol es válido, insertar en la BD --%>
    <c:otherwise>
        <sql:update dataSource="${baseDeDatos}" var="resultado">
            INSERT INTO usuarios (nombre, apellido, correo, contraseña, rol) 
            VALUES (?, ?, ?, ?, ?)
            <sql:param value="${param.nombre}" />
            <sql:param value="${param.apellido}" />
            <sql:param value="${param.correo}" />
            <sql:param value="${param.contrasena}" />
            <sql:param value="${param.rol}" />
        </sql:update>
        
        <c:redirect url="gestionUsuarios.jsp?success=1" />
    </c:otherwise>
</c:choose>