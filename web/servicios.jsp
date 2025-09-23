<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<jsp:include page="components/layout/header.jsp" />

<%@page import="modelo_entidad.Servicio"%>
<%
    List<Servicio> listaServicios = (List<Servicio>) request.getAttribute("listaServicios");
%>

<div class="container mt-5">
    <h2 class="text-center mb-4">Servicios</h2>
    <div class="list-group">
        <% if (listaServicios != null && !listaServicios.isEmpty()) {
               for (Servicio s : listaServicios) { %>
            <div class="list-group-item list-group-item-action d-flex align-items-center shadow-sm mb-2">
                
                <!-- Imagen del servicio -->
                <img src="https://via.placeholder.com/80x80?text=Serv" 
                     class="rounded me-3" alt="<%= s.getNombre() %>">

                <!-- Información en horizontal con espacio entre cada campo -->
                <div class="d-flex align-items-center flex-grow-1 gap-4">
                    <div class="fw-bold"><%= s.getNombre() %></div>
                    <div class="fw-bold text-primary">S/. <%= s.getPrecio() %></div>
                    <div class="fw-bold">Maestro: Jose Valverde</div>
                </div>
               
                <!-- Botón a la derecha -->
                <a href="login.jsp" class="btn btn-md btn-primary ms-3">Agregar al Carrito</a>
            </div>
        <% } } else { %>
            <div class="text-center text-muted">
                <p>No hay servicios disponibles</p>
            </div>
        <% } %>
    </div>
</div>

   <jsp:include page="components/layout/footer.jsp" />