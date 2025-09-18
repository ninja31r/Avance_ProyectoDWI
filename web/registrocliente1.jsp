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

        // Acción registrar
        if("Registrar".equals(request.getParameter("accion"))){
            String correo = request.getParameter("txtCorreo");
            String password = request.getParameter("txtPassword");

            Usuario u = new Usuario();
            u.setCorreo(correo);
            u.setPassword(password);
            u.setRol_id(1); // por defecto rol cliente

            dao.insertar(u);
        }

        // Listar usuarios
        ArrayList<Usuario> lista = dao.listar();
    %>

    <h3>Usuarios Registrados</h3>
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Correo</th>
                <th>Contraseña</th>
                <th>Rol</th>
            </tr>
        </thead>
        <tbody>
        <%
            for(Usuario u : lista){
        %>
            <tr>
                <td><%=u.getId()%></td>
                <td><%=u.getCorreo()%></td>
                <td><%=u.getPassword()%></td>
                <td><%=u.getRol_id()%></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>

