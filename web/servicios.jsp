<%-- 
    Document   : servicios
    Created on : 18 set. 2025, 12:22:25
    Author     : Juan Andre Zea Apaza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.List"%>
<%@page import="modelo_entidad.Servicio"%>

<%
    modelo_dao.ServicioDAO dao = new modelo_dao.ServicioDAO();
    List<Servicio> servicios = dao.listar();
    request.setAttribute("servicios", servicios);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Servicios Registrados</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-center">Servicios Registrados</h2>

    <table class="table table-striped table-hover shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Cliente</th>
                <th>Descripción</th>
                <th>Estado</th>
                <th>Fecha</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="s" items="${servicios}">
                <tr>
                    <td><c:out value="${s.id}"/></td>
                    <td><c:out value="${s.cliente}"/></td>
                    <td><c:out value="${s.descripcion}"/></td>
                    <td><c:out value="${s.estado}"/></td>
                    <td><fmt:formatDate value="${s.fecha}" pattern="dd/MM/yyyy"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>

