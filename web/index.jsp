<%-- 
    Document   : index
    Created on : 3 set. 2025, 11:57:59
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
    <title>Inicio - Auditel Import S.A.C</title>
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
                    <li class="nav-item"><a class="nav-link" href="productos.jsp">Productos</a></li>
                    <li class="nav-item"><a class="nav-link" href="contratarServicios.jsp">Servicios</a></li>

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

    <!-- Hero Section -->
    <div class="container mt-5">
        <div class="p-5 mb-5 bg-primary text-white rounded-4 text-center shadow-lg">
            <h1 class="display-4 fw-bold">Bienvenido a Auditel Import S.A.C</h1>
            <p class="lead mb-4">Soluciones tecnológicas confiables para hogares y pequeñas empresas.</p>
        </div>
    </div>

    <!-- Mensaje personalizado -->
    <% if(usuarioLog != null){ %>
        <div class="container mb-5 text-center">
            <div class="alert alert-success shadow-sm rounded-4">
                Hola, <strong><%= usuarioLog.getNombre() %></strong>, gracias por iniciar sesión.
            </div>
        </div>
    <% } %>

    <!-- Información de la Empresa -->
    <div class="container mb-5">
        <h2 class="text-center mb-4 fw-bold">Sobre Nuestra Empresa</h2>
        <div class="row g-4">

            <div class="col-md-4">
                <div class="card h-100 border-primary shadow-sm rounded-4">
                    <div class="card-header bg-primary text-white fw-bold text-center rounded-top-4">Descripción</div>
                    <div class="card-body">
                        <p>Somos una empresa de telecomunicaciones orientada a brindar soluciones tecnológicas a particulares y pequeñas empresas, ofreciendo:</p>
                        <ul class="mb-0">
                            <li>Venta de equipos de telecomunicaciones</li>
                            <li>Instalación de internet residencial y empresarial</li>
                            <li>Instalación de cámaras de seguridad</li>
                            <li>Configuración y mantenimiento de servidores</li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 border-success shadow-sm rounded-4">
                    <div class="card-header bg-success text-white fw-bold text-center rounded-top-4">Misión</div>
                    <div class="card-body">
                        <p>Brindar soluciones tecnológicas accesibles, confiables y de calidad que contribuyan a mejorar la conectividad y seguridad de nuestros clientes.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card h-100 border-info shadow-sm rounded-4">
                    <div class="card-header bg-info text-white fw-bold text-center rounded-top-4">Visión</div>
                    <div class="card-body">
                        <p>Ser una empresa líder en telecomunicaciones a nivel local, reconocida por su innovación tecnológica y atención al cliente.</p>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Carousel de Servicios -->
    <div class="container mb-5">
        <h2 class="text-center mb-4 fw-bold">Nuestros Servicios Destacados</h2>
        <div id="carouselServicios" class="carousel slide shadow rounded-4" data-bs-ride="carousel">
            <div class="carousel-inner rounded-4">

                <div class="carousel-item active">
                    <img src="img/internet.jpg" class="d-block w-100 rounded-4" alt="Internet">
                    <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded-4 p-3">
                        <h5>Internet de Alta Velocidad</h5>
                        <p>Conexión confiable para hogares y empresas.</p>
                    </div>
                </div>

                <div class="carousel-item">
                    <img src="img/camaras.jpg" class="d-block w-100 rounded-4" alt="Cámaras">
                    <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded-4 p-3">
                        <h5>Cámaras de Seguridad</h5>
                        <p>Protege tu hogar o negocio con tecnología avanzada.</p>
                    </div>
                </div>

                <div class="carousel-item">
                    <img src="img/equipos.jpg" class="d-block w-100 rounded-4" alt="Equipos">
                    <div class="carousel-caption d-none d-md-block bg-dark bg-opacity-50 rounded-4 p-3">
                        <h5>Equipos Tecnológicos</h5>
                        <p>Soluciones modernas para conectividad y productividad.</p>
                    </div>
                </div>

            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselServicios" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselServicios" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
            </button>
        </div>
    </div>

    <!-- Beneficios -->
    <div class="container mb-5">
        <h2 class="text-center mb-4 fw-bold">Por qué elegirnos</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4">

            <div class="col">
                <div class="card h-100 text-center shadow-sm rounded-4">
                    <div class="card-body">
                        <h5 class="card-title fw-bold">Soporte Profesional</h5>
                        <p class="card-text">Atención rápida y personalizada para cada cliente.</p>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card h-100 text-center shadow-sm rounded-4">
                    <div class="card-body">
                        <h5 class="card-title fw-bold">Tecnología Avanzada</h5>
                        <p class="card-text">Equipos y soluciones modernas para todos nuestros clientes.</p>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card h-100 text-center shadow-sm rounded-4">
                    <div class="card-body">
                        <h5 class="card-title fw-bold">Confianza y Seguridad</h5>
                        <p class="card-text">Garantizamos servicios confiables y seguros para tu tranquilidad.</p>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-primary text-white pt-5 pb-3 mt-5">
        <div class="container">
            <div class="row text-center text-md-start">
                <div class="col-md-4 mb-3">
                    <h5 class="fw-bold">Auditel Import S.A.C</h5>
                    <p>Soluciones tecnológicas confiables para hogares y empresas.</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h5 class="fw-bold">Contacto</h5>
                    <p>Email: contacto@auditel.com</p>
                    <p>Teléfono: +51 999 999 999</p>
                </div>
                <div class="col-md-4 mb-3">
                    <h5 class="fw-bold">Síguenos</h5>
                    <a href="#" class="text-white me-3">Facebook</a>
                    <a href="#" class="text-white me-3">Twitter</a>
                    <a href="#" class="text-white">Instagram</a>
                </div>
            </div>
            <hr class="border-light">
            <div class="text-center mt-3">&copy; 2025 Auditel Import S.A.C. Todos los derechos reservados.</div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
