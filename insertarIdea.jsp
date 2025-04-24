<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="WEB-INF/jspf/conexion.jspf" %>

<%-- Insertar la idea en la BD (todos los campos como String) --%>
<sql:update dataSource="${baseDeDatos}" var="resultado">
    INSERT INTO ideas (titulo, descripcion, tecnologias, fecha_proposicion, observaciones) 
    VALUES (?, ?, ?, ?, ?)
    <sql:param value="${param.titulo}" />           
    <sql:param value="${param.descripcion}" />      
    <sql:param value="${param.tecnologias}" />      
    <sql:param value="${param.fecha_proposicion}" /> 
                   
    <sql:param value="${param.observaciones}" />      
</sql:update>

<c:redirect url="gestionIdeas.jsp?success=1" />