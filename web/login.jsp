<%-- 
    Document   : login
    Created on : 3 set. 2025, 11:03:44
    Author     : Juan Andre Zea Apaza
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_entidad.Cliente"%>
<%@page import="modelo_dao.ClienteDAO"%>

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
                                <label class="form-label">Usuario</label>
                                <input type="text" class="form-control" name="txtUsuario" required>
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
                            if(request.getParameter("accion")!=null){
                                String usuario = request.getParameter("txtUsuario");
                                String password = request.getParameter("txtPassword");
                                ClienteDAO dao = new ClienteDAO();
                                Cliente cli = dao.validar(usuario, password);
                                if(cli.getUsuario()!=null){
                                    session.setAttribute("usuario", cli);
                                    response.sendRedirect("menu.jsp");
                                }else{
                        %>
                            <div class="alert alert-danger mt-3">Usuario o contraseña incorrectos</div>
                        <%
                                }
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

