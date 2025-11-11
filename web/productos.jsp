<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="java.util.List"%>
<%@page import="modelo_dto.DtoProducto"%>
<%@page import="modelo_entidad.Usuario"%>

<jsp:include page="components/layout/header.jsp" />

<%
    // Obtener la lista de productos
    List<DtoProducto> listaProductos = (List<DtoProducto>) request.getAttribute("productos");

    // Verificar si el usuario está logueado
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuario");
    boolean isLogged = (usuarioLogueado != null);
%>

<div class="container mt-5">
    <h2 class="text-center margin-bottom">Productos</h2>
    <div class="row g-4 mt-4">

        <% if (listaProductos != null && !listaProductos.isEmpty()) {
               for (DtoProducto p : listaProductos) { %>

            <div class="col-md-4">
                <div class="card h-100 shadow-sm">
                    <img src="<%= p.getImagen() %>" class="card-img-top">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title"><%= p.getNombre() %></h5>
                        <p class="fw-bold text-primary">S/. <%= p.getPrecio() %></p>
                        <p class="text-muted">Stock: <%= p.getStock() %></p>

                        <% if (isLogged) { %>
                            <!-- Si el usuario está logueado -->
                            <!-- Antes tenías: data-nombre="<%= p.getNombre() %>" -->
                                <button class="btn btn-success mt-auto agregarCarrito" 
                                        data-id="<%= p.getId() %>" 
                                        data-nombre="<%= p.getNombre() %>">
                                    <i class="fa fa-shopping-cart"></i> Agregar al Carrito
                                </button>

                        <% } else { %>
                            <!-- Si no está logueado -->
                            <a href="login.jsp" class="btn btn-primary mt-auto">
                                <i class="fa fa-sign-in"></i> Iniciar Sesión para comprar
                            </a>
                        <% } %>
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

<!-- Modal de confirmación -->
<div class="modal fade" id="modalCarrito" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-body text-center">
        <i class="fa fa-check-circle text-success" style="font-size:60px;"></i>
        <h4 class="mt-3">Producto agregado con éxito</h4>
        <p id="nombreProducto" class="text-muted"></p>
      </div>
    </div>
  </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
  const botones = document.querySelectorAll('.agregarCarrito');
  const contadorElemento = document.getElementById('contadorCarrito');

  // Cargar contador previo desde localStorage (por si el usuario recarga)
  let contador = parseInt(localStorage.getItem('contadorCarrito')) || 0;
  contadorElemento.textContent = contador;

  botones.forEach(btn => {
    btn.addEventListener('click', function() {
      const nombre = this.getAttribute('data-nombre');

      // Incrementar contador
      contador++;
      localStorage.setItem('contadorCarrito', contador);
      contadorElemento.textContent = contador;

      // Mostrar modal
      document.getElementById('nombreProducto').textContent = nombre;
      const modal = new bootstrap.Modal(document.getElementById('modalCarrito'));
      modal.show();

      // Esperar 2.5 segundos y redirigir a carrito.xhtml
      setTimeout(() => {
        modal.hide();
        const id = this.getAttribute('data-id');
        window.location.href = 'carrito.xhtml?productoId=' + encodeURIComponent(id);      }, 2500);
    });
  });
});
</script>
<jsp:include page="components/layout/footer.jsp" />
