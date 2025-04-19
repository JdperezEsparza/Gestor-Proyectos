<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>

<!-- Consulta para obtener el nombre y apellido del usuario -->
<sql:query var="usuario" dataSource="${baseDeDatos}">
  SELECT nombre, apellido FROM usuarios WHERE id_usuario = ?
  <sql:param value="${sessionScope.id}" />
</sql:query>

<c:forEach var="u" items="${usuario.rows}">
  <c:set var="nombreCompleto" value="${u.nombre} ${u.apellido}" />
</c:forEach>

<!-- Consulta para obtener el título de la idea seleccionada -->
<sql:query var="idea" dataSource="${baseDeDatos}">
  SELECT titulo FROM ideas WHERE id_idea = ?
  <sql:param value="${param.id_idea}" />
</sql:query>

<c:forEach var="i" items="${idea.rows}">
  <c:set var="tituloIdea" value="${i.titulo}" />
</c:forEach>

<!-- Insertar un nuevo anteproyecto -->
<sql:update dataSource="${baseDeDatos}">
  INSERT INTO anteproyectos (titulo, id_idea, id_estudiante, estudiante)
  VALUES (?, ?, ?, ?)
  <sql:param value="${tituloIdea}" />
  <sql:param value="${param.id_idea}" />
  <sql:param value="${sessionScope.id}" />
  <sql:param value="${nombreCompleto}" />
</sql:update>

<!-- Redirigir a la página de confirmación -->
<c:redirect url="gestionProyectosEstudiante.jsp" />
