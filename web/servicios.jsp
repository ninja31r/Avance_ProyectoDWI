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
                
                <img src="<%= s.getImagen() %>" class="rounded me-3" style="max-width: 200px; height: auto;">

                <div class="align-items-center flex-grow-1 gap-4">
                    <div class="fw-bold fs-4"><%= s.getNombre() %></div>
                    <div class="fw-bold text-primary fs-4">S/. <%= s.getPrecio() %></div>
                </div>
                <div class="fw-bold fs-4">Horas estimadas: <%= s.getDuracion() %></div>
               
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