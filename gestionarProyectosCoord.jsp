<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<c:choose>
  <c:when test="${empty param.id_anteproyecto || empty param.id_director || empty param.id_evaluador}">
    <c:set var="errorMessage" value="Todos los campos son requeridos" scope="session"/>
    <c:redirect url="gestionProyectosCordinador.jsp"/>
  </c:when>
  
  <c:when test="${param.id_director == param.id_evaluador}">
    <c:set var="errorMessage" value="El director y el evaluador no pueden ser la misma persona" scope="session"/>
    <c:redirect url="gestionProyectosCordinador.jsp">
      <c:param name="id_anteproyecto" value="${param.id_anteproyecto}"/>
      <c:param name="id_director" value="${param.id_director}"/>
      <c:param name="id_evaluador" value="${param.id_evaluador}"/>
    </c:redirect>
  </c:when>
  
  <c:otherwise>
    <sql:update dataSource="${baseDeDatos}" var="resultado">
      UPDATE anteproyectos 
      SET director = (SELECT CONCAT(nombre, ' ', apellido) FROM usuarios WHERE id_usuario = ?),
          evaluador = (SELECT CONCAT(nombre, ' ', apellido) FROM usuarios WHERE id_usuario = ?),
          id_director = ?,
          id_evaluador = ?
      WHERE id_anteproyecto = ?
      <sql:param value="${param.id_director}"/>
      <sql:param value="${param.id_evaluador}"/>
      <sql:param value="${param.id_director}"/>
      <sql:param value="${param.id_evaluador}"/>
      <sql:param value="${param.id_anteproyecto}"/>
    </sql:update>
    
    <c:choose>
      <c:when test="${resultado > 0}">
        <c:set var="mensaje" value="Proyecto actualizado correctamente" scope="session"/>
      </c:when>
      <c:otherwise>
        <c:set var="errorMessage" value="Error al actualizar el proyecto" scope="session"/>
      </c:otherwise>
    </c:choose>
    <c:redirect url="gestionProyectosCordinador.jsp"/>
  </c:otherwise>
</c:choose>