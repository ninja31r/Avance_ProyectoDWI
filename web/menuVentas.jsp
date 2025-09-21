<%-- 
    Document   : menuVentas
    Created on : 18 set. 2025, 11:38:28
    Author     : Juan Andre Zea Apaza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${empty sessionScope.usuario}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Ventas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table-container {
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
        .table th, .table td {
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <div class="container mt-5 table-container">
        <h2 class="mb-4 text-center">Panel de Ventas Registradas</h2>

        <div class="alert alert-info text-center">
            Bienvenido, <strong>${sessionScope.usuario.nombre}</strong> (Encargado de Ventas)
        </div>

        <!-- Tabla de ventas -->
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID Venta</th>
                    <th>Cliente</th>
                    <th>Producto</th>
                    <th>Monto</th>
                    <th>Fecha</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty listaVentas}">
                        <c:forEach var="venta" items="${listaVentas}">
                            <tr>
                                <td>${venta.id}</td>
                                <td>${venta.cliente}</td>
                                <td>${venta.producto}</td>
                                <td><fmt:formatNumber value="${venta.monto}" type="currency" currencySymbol="S/."/></td>
                                <td><fmt:formatDate value="${venta.fecha}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="text-center text-muted">No hay ventas registradas todavía.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <p class="text-end fw-bold">
            Total de ventas: <c:out value="${listaVentas != null ? listaVentas.size() : 0}"/>
        </p>

        <div class="text-center">
            <a href="cerrar.jsp" class="btn btn-danger">Cerrar Sesión</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

