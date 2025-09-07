<%-- 
    Document   : menu
    Created on : 3 set. 2025, 11:05:53
    Author     : Juan Andre Zea Apaza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_entidad.Cliente"%>

<%
    Cliente cli = (Cliente)session.getAttribute("usuario");
    if(cli == null){
        response.sendRedirect("login.jsp");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Menú</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5 text-center">
        <h2 class="mb-4">Bienvenido, <%=cli.getUsuario()%></h2>
        <a href="cerrar.jsp" class="btn btn-danger">Cerrar Sesión</a>
    </div>
</body>
</html>
