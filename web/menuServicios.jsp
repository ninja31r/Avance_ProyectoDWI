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
    <title>Panel de Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h2 class="mb-4 text-center">Panel de Servicios Registrados</h2>

        <div class="alert alert-info text-center">
            Bienvenido, <strong>${sessionScope.usuario.nombre}</strong> (Encargado de Servicios)
        </div>

        <!-- Tabla de servicios -->
        <table class="table table-striped table-hover shadow-sm">
            <thead class="table-dark">
                <tr>
                    <th>ID Servicio</th>
                    <th>Cliente</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th>Fecha</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty listaServicios}">
                        <c:forEach var="servicio" items="${listaServicios}">
                            <tr class="${servicio.estado eq 'Pendiente' ? 'table-warning' :
                                       servicio.estado eq 'Completado' ? 'table-success' :
                                       'table-light'}">
                                <td>${servicio.id}</td>
                                <td>${servicio.cliente}</td>
                                <td>${servicio.descripcion}</td>
                                <td>${servicio.estado}</td>
                                <td><fmt:formatDate value="${servicio.fecha}" pattern="dd/MM/yyyy"/></td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5" class="text-center text-muted">No hay servicios registrados todavía.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>

        <p class="text-end fw-bold">
            Total de servicios: <c:out value="${listaServicios != null ? listaServicios.size() : 0}"/>
        </p>

        <div class="text-center mt-3">
            <a href="cerrar.jsp" class="btn btn-danger">Cerrar Sesión</a>
        </div>
    </div>
</body>
</html>
