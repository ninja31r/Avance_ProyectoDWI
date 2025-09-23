<%-- 
    Document   : clientes
    Created on : 3 set. 2025, 12:23:00
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
    <title>Lista de Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4 text-center">Clientes Registrados</h2>

    <%
        UsuarioDAO dao = new UsuarioDAO();
        ArrayList<Usuario> lista = dao.listar();
        if(lista.isEmpty()){
    %>
        <div class="alert alert-warning text-center">
            No hay clientes registrados aún.
        </div>
    <%
        } else {
    %>
    <table class="table table-striped table-hover shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Usuario</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <%
            for(Usuario c : lista){
        %>
            <tr>
                <td><%=c.getId()%></td>
                <td><%=c.getNombre()%></td>
                <td>
                    <a href="editarCliente.jsp?id=<%=c.getId()%>" class="btn btn-sm btn-warning">Editar</a>
                    <a href="eliminarCliente.jsp?id=<%=c.getId()%>" class="btn btn-sm btn-danger">Eliminar</a>
                </td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
    <%
        }
    %>
</div>
</body>
</html>
