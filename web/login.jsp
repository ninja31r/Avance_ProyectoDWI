<<<<<<< HEAD
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Auditel Import S.A.C - Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">

    <style>
        body {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
        }

        .card {
            border: none;
            border-radius: 18px;
            background: white;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            animation: fadeIn 1s ease-in-out;
        }

        .card-header {
            background: linear-gradient(90deg, #1976d2, #42a5f5);
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
        }

        .form-control {
            border-radius: 30px;
            padding: 10px 15px;
        }

        .form-control:focus {
            border-color: #42a5f5;
            box-shadow: 0 0 6px #90caf9;
        }

        .btn-primary {
            background: linear-gradient(90deg, #42a5f5, #1e88e5);
            border: none;
            border-radius: 30px;
            padding: 10px;
            font-weight: 600;
            letter-spacing: 0.3px;
        }

        .btn-primary:hover {
            background: linear-gradient(90deg, #64b5f6, #2196f3);
            transform: scale(1.03);
            transition: 0.3s;
        }

        .alert {
            border-radius: 15px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        footer {
            text-align: center;
            color: #666;
            padding: 15px 0;
            font-size: 0.9rem;
        }
    </style>
</head>

<body class="bg-light">

<!-- Encabezado -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-semibold" href="index.jsp">Auditel Import S.A.C</a>
        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="registroCliente.jsp">Registrarse</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Cuerpo del login -->
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card p-3 shadow-lg">
                <div class="card-header text-center rounded-top">
                    Iniciar Sesión
                </div>

                <div class="card-body">
                    
                    <!-- Mensajes dinámicos -->
                    <c:if test="${param.msg eq 'logout'}">
                        <div class="alert alert-success text-center">
                            Sesión cerrada correctamente.
                        </div>
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger text-center">
                            ${error}
                        </div>
                    </c:if>

                    <!--  Formulario -->
                    <form action="Login" method="post">
                        <div class="mb-3">
                            <label class="form-label">Correo</label>
                            <input type="email" name="correo" class="form-control" placeholder="Ingrese su correo" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Contraseña</label>
                            <input type="password" name="password" class="form-control" placeholder="Ingrese su contraseña" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 mt-2">Ingresar</button>
                    </form>

=======
<%-- 
    Document   : login
    Created on : 3 set. 2025, 11:03:44
    Author     : Juan Andre Zea Apaza
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario"%>
<%@page import="dao.UsuarioDAO"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
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
                    <li class="nav-item"><a class="nav-link" href="login.jsp">Iniciar Sesión</a></li>
                    <li class="nav-item"><a class="nav-link" href="registroCliente.jsp">Registrarse</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card shadow-lg">
                    <div class="card-header text-center bg-primary text-white">
                        <h4>Iniciar Sesión</h4>
                    </div>
                    <div class="card-body">
                        <form method="post" action="login.jsp">
                            <div class="mb-3">
                                <label class="form-label">Correo</label>
                                <input type="email" class="form-control" name="txtCorreo" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Contraseña</label>
                                <input type="password" class="form-control" name="txtPassword" required>
                            </div>
                            <div class="d-grid">
                                <button type="submit" name="accion" value="Ingresar" class="btn btn-primary">
                                    Ingresar
                                </button>
                            </div>
                        </form>
<%
    if(request.getParameter("accion") != null){
        String correo = request.getParameter("txtCorreo");
        String password = request.getParameter("txtPassword");
        UsuarioDAO dao = new UsuarioDAO();
        Usuario u = dao.validar(correo, password);

        if(u != null && u.getCorreo() != null){
            session.setAttribute("usuario", u);
            response.sendRedirect("menu.jsp");
        } else {
%>
            <div class="alert alert-danger mt-3">Correo o contraseña incorrectos</div>
<%
        }
    }
%>
                    </div>
>>>>>>> 8f23735d0db3603ae5cb1b9e21da22f3ee0b841b
                </div>
            </div>
        </div>
    </div>
<<<<<<< HEAD
</div>

<!-- Pie -->
<footer>
    © 2025 Auditel Import S.A.C — Todos los derechos reservados.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
=======
>>>>>>> 8f23735d0db3603ae5cb1b9e21da22f3ee0b841b
</body>
</html>
