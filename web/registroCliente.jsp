<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_dao.ClienteDAO"%>
<%@page import="modelo_entidad.Cliente"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro de Cliente</title>
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
    <h2 class="mb-4">Registro de Cliente</h2>

    <form method="post" action="registroCliente.jsp" class="card p-3 mb-4">
        <div class="mb-3">
            <label class="form-label">Usuario</label>
            <input type="text" name="txtUsuario" class="form-control" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Contraseña</label>
            <input type="password" name="txtPassword" class="form-control" required>
        </div>
        <button type="submit" name="accion" value="Registrar" class="btn btn-primary">Registrar</button>
    </form>

    <%
        ClienteDAO dao = new ClienteDAO();

        // Acción registrar
        if("Registrar".equals(request.getParameter("accion"))){
            String usuario = request.getParameter("txtUsuario");
            String password = request.getParameter("txtPassword");
            Cliente cli = new Cliente();
            cli.setUsuario(usuario);
            cli.setPassword(password);
            dao.insertar(cli);
        }

        // Listar clientes
        ArrayList<Cliente> lista = dao.listar();
    %>

    <h3>Clientes Registrados</h3>
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Contraseña</th>
            </tr>
        </thead>
        <tbody>
        <%
            for(Cliente c : lista){
        %>
            <tr>
                <td><%=c.getId()%></td>
                <td><%=c.getUsuario()%></td>
                <td><%=c.getPassword()%></td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
