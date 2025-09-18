<%-- 
    Document   : productos
    Created on : 3 set. 2025, 11:58:10
    Author     : Juan Andre Zea Apaza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_entidad.Usuario"%>
<%
    Usuario usuarioLog = (Usuario) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Productos - Empresa Telecomunicaciones</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
     <!-- Barra de navegación -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Auditel Import S.A.C</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>

                <% if(usuarioLog == null){ %>
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Iniciar Sesión</a></li>
                    <li class="nav-item"><a class="nav-link" href="registroCliente.jsp">Registrarse</a></li>
                <% } else { %>
                    <li class="nav-item"><a class="nav-link text-warning" href="cerrar.jsp">Cerrar Sesión</a></li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

    <!-- Contenido principal -->
    <div class="container mt-5">
        <h2 class="mb-4">Nuestros Productos y Servicios</h2>
        <div class="row">
            <!-- Producto 1 -->
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Cámara de seguridad">
                    <div class="card-body">
                        <h5 class="card-title">Cámara de Seguridad</h5>
                        <p class="card-text">Monitoreo en tiempo real y grabación segura.</p>
                        <a href="login.jsp" class="btn btn-primary">Agregar al Carrito</a>
                    </div>
                </div>
            </div>

            <!-- Producto 2 -->
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Servicio de Internet">
                    <div class="card-body">
                        <h5 class="card-title">Servicio de Internet</h5>
                        <p class="card-text">Planes residenciales y empresariales de alta velocidad.</p>
                        <a href="login.jsp" class="btn btn-primary">Agregar al Carrito</a>
                    </div>
                </div>
            </div>

            <!-- Producto 3 -->
            <div class="col-md-4">
                <div class="card shadow-sm">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Servidor Empresarial">
                    <div class="card-body">
                        <h5 class="card-title">Servidor Empresarial</h5>
                        <p class="card-text">Configuración y mantenimiento de servidores seguros.</p>
                        <a href="login.jsp" class="btn btn-primary">Agregar al Carrito</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
