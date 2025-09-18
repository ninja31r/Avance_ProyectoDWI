<%-- 
    Document   : ventas
    Created on : 18 set. 2025, 12:22:18
    Author     : Juan Andre Zea Apaza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.List"%>
<%@page import="modelo_entidad.Venta"%>

<%
    // Supongamos que tienes VentaDAO con método listar()
    modelo_dao.VentaDAO dao = new modelo_dao.VentaDAO();
    List<Venta> ventas = dao.listar();
    request.setAttribute("ventas", ventas);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ventas Registradas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-center">Ventas Registradas</h2>

    <table class="table table-striped table-hover shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Cliente</th>
                <th>Producto</th>
                <th>Monto</th>
                <th>Fecha</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="v" items="${ventas}">
                <tr>
                    <td><c:out value="${v.id}"/></td>
                    <td><c:out value="${v.cliente}"/></td>
                    <td><c:out value="${v.producto}"/></td>
                    <td><fmt:formatNumber value="${v.monto}" type="currency"/></td>
                    <td><fmt:formatDate value="${v.fecha}" pattern="dd/MM/yyyy"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>

