<%-- 
    Document   : menuVentas
    Created on : 18 set. 2025, 11:38:28
    Author     : Juan Andre Zea Apaza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_entidad.Usuario"%>
<%
    Usuario u = (Usuario) session.getAttribute("usuario");
    if(u == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel de Ventas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <h2 class="mb-4 text-center">Panel de Ventas Registradas</h2>
        <div class="alert alert-info">Bienvenido, <%=u.getCorreo()%> (Encargado de Ventas)</div>

        <!-- Aquí más adelante pondrás la tabla de ventas desde la BD -->
        <table class="table table-striped table-hover shadow-sm">
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
                <tr><td colspan="5" class="text-center">No hay ventas registradas todavía.</td></tr>
            </tbody>
        </table>

        <a href="cerrar.jsp" class="btn btn-danger">Cerrar Sesión</a>
    </div>
</body>
</html>

