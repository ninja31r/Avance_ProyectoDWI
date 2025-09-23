<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<jsp:include page="components/layout/header.jsp" />

<%@page import="modelo_entidad.Producto"%>
<%
    List<Producto> listaProductos = (List<Producto>) request.getAttribute("listaProductos");
%>

    <div class="container mt-5">
        <h2 class="text-center margin-bottom">Productos</h2>
        <div class="row g-4  mt-4">
            <% if (listaProductos != null && !listaProductos.isEmpty()) {
                   for (Producto p : listaProductos) { %>
                <div class="col-md-4">
                    <div class="card h-100 shadow-sm">

                        <img src="https://via.placeholder.com/300x200?text=Producto" class="card-img-top" alt="<%= p.getNombre() %>">
                        <div class="card-body d-flex flex-column">
                            <h5 class="card-title"><%= p.getNombre() %></h5>
                            <p class="card-text text-muted"><%= p.getDescripcion() %></p>
                            <p class="fw-bold text-primary">S/. <%= p.getPrecio() %></p>
                            <p class="text-muted">Stock: <%= p.getStock() %></p>
                            <a href="login.jsp" class="btn btn-primary mt-auto">Agregar al Carrito</a>
                        </div>
                    </div>
                </div>
            <% } 
               } else { %>
                <div class="col-12 text-center">
                    <p class="text-muted">No hay productos disponibles</p>
                </div>
            <% } %>
        </div>
    </div>

   <jsp:include page="components/layout/footer.jsp" />