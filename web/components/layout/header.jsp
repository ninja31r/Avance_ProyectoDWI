<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_entidad.Usuario"%>
<%
    Usuario usuarioLog = (Usuario) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos - Auditel Import S.A.C</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex flex-column min-vh-100">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">Auditel Import S.A.C</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active" href="index.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link active" href="ProductoServlet">Productos</a></li>
                <li class="nav-item"><a class="nav-link active" href="svltServicio">Servicios</a></li>
                <% if(usuarioLog == null){ %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Iniciar Sesión</a></li>
                    <li class="nav-item"><a class="nav-link" href="registrocliente1.jsp">Registrarse</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link text-warning" href="cerrar.jsp">Cerrar Sesión</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<main class="flex-grow-1">
