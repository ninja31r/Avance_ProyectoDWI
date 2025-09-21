<%-- 
    Document   : registrocliente1
    Created on : 18 set. 2025, 12:33:14
    Author     : Juan Andre Zea Apaza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_dao.UsuarioDAO"%>
<%@page import="modelo_entidad.Usuario"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>
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
                <li class="nav-item"><a class="nav-link" href="login.jsp">Iniciar Sesión</a></li>
                <li class="nav-item"><a class="nav-link" href="registrocliente1.jsp">Registrarse</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="mb-4">Registro de Usuario</h2>

    <form method="post" action="registrocliente1.jsp" class="card p-3 mb-4">
        <div class="mb-3">
            <label class="form-label">Nombre</label>
            <input type="text" name="txtNombre" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Apellidos</label>
            <input type="text" name="txtApellidos" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Teléfono</label>
            <input type="text" name="txtTelefono" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Correo</label>
            <input type="email" 
                   name="txtCorreo" 
                   class="form-control" 
                   required
                   placeholder="ej: juan.perez.quijano@root.com">
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" name="txtPassword" class="form-control" required>
        </div>
        <button type="submit" name="accion" value="Registrar" class="btn btn-primary">Registrar</button>
    </form>

    <%
        UsuarioDAO dao = new UsuarioDAO();

        if("Registrar".equals(request.getParameter("accion"))){
            String nombre = request.getParameter("txtNombre");
            String apellidos = request.getParameter("txtApellidos");
            String telefono = request.getParameter("txtTelefono");
            String correo = request.getParameter("txtCorreo");
            String password = request.getParameter("txtPassword");

            Usuario u = new Usuario();
            u.setNombre(nombre);
            u.setApellidos(apellidos);
            u.setTelefono(telefono);
            u.setCorreo(correo);
            u.setPassword(password);
            u.setRol_id(1); 

            int r = dao.insertar(u);
            if(r > 0){
    %>
                <div class="alert alert-success mt-3"> Usuario registrado correctamente.</div>
    <%
            } else {
    %>
                <div class="alert alert-danger mt-3"> Error al registrar el usuario.</div>
    <%
            }
        }
    %>
</div>
</body>
</html>
