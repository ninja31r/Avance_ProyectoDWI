<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_entidad.Usuario"%>
<%
    Usuario usuarioLog = (Usuario) session.getAttribute("usuario");
%>
<%
    // Recupera la lista del carrito desde la sesión
    java.util.List carrito = (java.util.List) session.getAttribute("carrito");
    int contador = (carrito != null) ? carrito.size() : 0;
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos - Auditel Import S.A.C</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
</head>
<body class="d-flex flex-column min-vh-100">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow">
    <div class="container">
        <a class="navbar-brand fw-bold" href="index.jsp">Auditel Import S.A.C</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0">

                <li class="nav-item"><a class="nav-link active" href="ProductoServlet">Productos</a></li>
                <li class="nav-item"><a class="nav-link active" href="ServicioServlet">Servicios</a></li>

                <% if (usuarioLog == null) { %>
                    <!-- Sin sesión -->
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Iniciar Sesión</a></li>
                    <li class="nav-item"><a class="nav-link" href="registroCliente.jsp">Registrarse</a></li>

                <% } else { %>

                    <%
                        String correo = usuarioLog.getCorreo() != null ? usuarioLog.getCorreo() : "";
                        boolean esAdmin = correo.startsWith("ADM");
                        boolean esCliente = correo.startsWith("CL");
                        boolean esTrabajador = correo.startsWith("TRAB");
                    %>

                    <% if (esAdmin) { %>
                        <!-- ADMIN -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="adminMenu" data-bs-toggle="dropdown">
                                <i class="bi bi-shield-lock-fill fs-5 me-1"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="adminMenu">
                                <li><h6 class="dropdown-header text-center text-primary"><%= usuarioLog.getNombre() %> (Admin)</h6></li>
                                <li><a class="dropdown-item" href="perfilAdmin.xhtml"><i class="bi bi-person-badge-fill me-2"></i> Perfil</a></li>
                                <li><a class="dropdown-item" href="administrar.jsp"><i class="bi bi-gear-fill me-2"></i> Administrar</a></li>
                                
                                <li><a class="dropdown-item text-danger" href="CerrarSesion"><i class="bi bi-box-arrow-right me-2"></i> Cerrar Sesión</a></li>
                            </ul>
                        </li>

                    <% } else if (esTrabajador) { %>
                         <!-- TRABAJADOR -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="trabMenu" data-bs-toggle="dropdown">
                                <i class="bi bi-briefcase-fill fs-5 me-1"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="trabMenu">
                                <li><h6 class="dropdown-header text-center text-primary"><%= usuarioLog.getNombre() %> (Trabajador)</h6></li>
                                <li><a class="dropdown-item" href="perfilTrabajador.xhtml"><i class="bi bi-person-lines-fill me-2"></i> Perfil</a></li>

                                <!--  acceso al menú de pedidos -->
                                <li><a class="dropdown-item" href="menuPedidos.xhtml"><i class="bi bi-cart-check-fill me-2"></i> Gestión de Pedidos y Servicios</a></li>

                                <li><hr class="dropdown-divider"></li>

                                <!--  botón de cerrar sesión -->
                                <li><a class="dropdown-item text-danger" href="CerrarSesion"><i class="bi bi-box-arrow-right me-2"></i> Cerrar Sesión</a></li>
                            </ul>
                        </li>

                    <% } else if (esCliente) { %>
                        <% if (esCliente) { %>
                          <!-- CLIENTE -->

                            <!-- Ícono del carrito con número dinámico desde sesión -->
                            <li class="nav-item">
                                <a class="nav-link position-relative" href="carrito.xhtml">
                                    <i class="bi bi-cart4 fs-5"></i>
                                    <span id="contadorCarrito" 
                                          class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                        0
                                    </span>
                                </a>
                            </li>

                            <!-- Menú desplegable del cliente -->
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="usuarioMenu" data-bs-toggle="dropdown">
                                    <i class="bi bi-person-circle fs-5 me-1"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="usuarioMenu">
                                    <li>
                                        <h6 class="dropdown-header text-center text-primary">
                                            <%= usuarioLog.getNombre() %> <%= usuarioLog.getApellidos() %>
                                        </h6>
                                    </li>
                                    <li><a class="dropdown-item disabled text-muted">Estado: Activo</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="perfilCliente.xhtml">
                                        <i class="bi bi-person-lines-fill me-2"></i> Mi Perfil</a></li>
                                    <li><a class="dropdown-item text-danger" href="CerrarSesion">
                                        <i class="bi bi-box-arrow-right me-2"></i> Cerrar Sesión</a></li>
                                </ul>
                            </li>

                        <% } %>
                                            <% } %>

                                        <% } %>
                                    </ul>
                                </div>
                            </div>
                        </nav>
<script>
document.addEventListener("DOMContentLoaded", function() {
  const contadorElemento = document.getElementById('contadorCarrito');
  if (contadorElemento) {
    const contador = localStorage.getItem('contadorCarrito') || 0;
    contadorElemento.textContent = contador;
  }
});
</script>

<main class="flex-grow-1">
