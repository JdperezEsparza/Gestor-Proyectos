<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>

<c:if test="${not empty param.id_anteproyecto and not empty param.calificacion_director}">
  <sql:update dataSource="${baseDeDatos}">
    UPDATE anteproyectos 
    SET calificacion_director = ?
    WHERE id_anteproyecto = ? AND id_director = ${sessionScope.id}
    <sql:param value="${param.calificacion_director}"/>
    <sql:param value="${param.id_anteproyecto}"/>
  </sql:update>
  
  <c:set var="mensajeExito" value="Calificación como director actualizada correctamente" scope="session"/>
</c:if>

<c:redirect url="gestionProyectosDocente.jsp"/>