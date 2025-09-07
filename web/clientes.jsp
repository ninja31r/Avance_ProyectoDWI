<%-- 
    Document   : clientes
    Created on : 3 set. 2025, 12:23:00
    Author     : Juan Andre Zea Apaza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_dao.ClienteDAO"%>
<%@page import="modelo_entidad.Cliente"%>
<%@page import="java.util.ArrayList"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Clientes Registrados</h2>
    <%
        ClienteDAO dao = new ClienteDAO();
        ArrayList<Cliente> lista = dao.listar();
    %>
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
