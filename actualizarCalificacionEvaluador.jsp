<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ include file="WEB-INF/jspf/conexion.jspf" %>

<c:if test="${not empty param.id_anteproyecto and not empty param.calificacion_evaluador}">
  <!-- Verificar que exista radicado_director -->
  <sql:query var="verificarRadicado" dataSource="${baseDeDatos}">
    SELECT 1 FROM anteproyectos 
    WHERE id_anteproyecto = ? AND id_evaluador = ${sessionScope.id} 
    AND radicado_director IS NOT NULL
    <sql:param value="${param.id_anteproyecto}"/>
  </sql:query>
  
  <c:if test="${verificarRadicado.rowCount > 0}">
    <sql:update dataSource="${baseDeDatos}">
      UPDATE anteproyectos 
      SET calificacion_evaluador = ?
      WHERE id_anteproyecto = ? AND id_evaluador = ${sessionScope.id}
      <sql:param value="${param.calificacion_evaluador}"/>
      <sql:param value="${param.id_anteproyecto}"/>
    </sql:update>
    <c:set var="mensajeExito" value="Calificación como evaluador actualizada correctamente" scope="session"/>
  </c:if>
</c:if>

<c:redirect url="gestionProyectosDocente.jsp"/>