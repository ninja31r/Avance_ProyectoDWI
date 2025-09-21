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
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos - Auditel Import S.A.C</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow">
        <div class="container">
            <a class="navbar-brand fw-bold" href="index.jsp">Auditel Import S.A.C</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu" aria-controls="menu" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="menu">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                    <li class="nav-item"><a class="nav-link active" href="productos.jsp">Productos</a></li>
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

        <h2 class="mb-4 text-center fw-bold">Nuestros Productos </h2>

       <!-- Tabs de Categorías -->
        <ul class="nav nav-tabs mb-4" id="categoriaTabs" role="tablist">

            <li class="nav-item" role="presentation">
                <button class="nav-link" id="antenas-tab" data-bs-toggle="tab" data-bs-target="#antenas" type="button"
                        role="tab" aria-controls="antenas" aria-selected="false">Antenas / Radioenlace</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="camaras-tab" data-bs-toggle="tab" data-bs-target="#camaras" type="button"
                        role="tab" aria-controls="camaras" aria-selected="false">Cámaras</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="servidores-tab" data-bs-toggle="tab" data-bs-target="#servidores" type="button"
                        role="tab" aria-controls="servidores" aria-selected="false">Servidores</button>
            </li>
        </ul>

        <div class="tab-content" id="categoriaTabsContent">

    

    <!-- Antenas / Radioenlace -->
    <div class="tab-pane fade" id="antenas" role="tabpanel" aria-labelledby="antenas-tab">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Ubiquiti Rocket M5">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Ubiquiti Rocket M5</h5>
                        <p class="card-text">Radioenlace de 5 GHz, ideal para enlaces punto a punto de larga distancia.</p>
                        <a href="login.jsp" class="btn btn-primary mt-auto">Agregar al Carrito</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="MikroTik SXT 5">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">MikroTik SXT 5</h5>
                        <p class="card-text">Antena sectorial de 16 dBi, perfecta para enlaces de radioenlace en exteriores.</p>
                        <a href="login.jsp" class="btn btn-primary mt-auto">Agregar al Carrito</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Cámaras -->
    <div class="tab-pane fade" id="camaras" role="tabpanel" aria-labelledby="camaras-tab">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Cámara Hikvision">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Cámara Hikvision</h5>
                        <p class="card-text">HD, visión nocturna, detección de movimiento y grabación en la nube.</p>
                        <a href="login.jsp" class="btn btn-primary mt-auto">Agregar al Carrito</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Cámara Dahua">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Cámara Dahua</h5>
                        <p class="card-text">Ideal para oficinas y comercios, con alta resolución y almacenamiento seguro.</p>
                        <a href="login.jsp" class="btn btn-primary mt-auto">Agregar al Carrito</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Servidores -->
    <div class="tab-pane fade" id="servidores" role="tabpanel" aria-labelledby="servidores-tab">
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Servidor HP ProLiant">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Servidor HP ProLiant</h5>
                        <p class="card-text">Servidor confiable para empresas, con alto rendimiento y almacenamiento seguro.</p>
                        <a href="login.jsp" class="btn btn-primary mt-auto">Agregar al Carrito</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card shadow-sm h-100">
                    <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Servidor Dell PowerEdge">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">Servidor Dell PowerEdge</h5>
                        <p class="card-text">Optimizado para pequeñas y medianas empresas con soporte confiable.</p>
                        <a href="login.jsp" class="btn btn-primary mt-auto">Agregar al Carrito</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>