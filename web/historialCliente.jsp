<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo_dao.UsuarioDAO"%>
<%@page import="modelo_dao.PedidoDAO"%>
<%@page import="modelo_entidad.Usuario"%>
<%@page import="modelo_entidad.Pedido"%>
<%@page import="modelo_entidad.Producto"%>
<%@page import="modelo_entidad.Servicio"%>

<jsp:include page="components/layout/header.jsp" />

<style>
.card-resumen {
    height: 130px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 12px;
}
.card-resumen .titulo {
    font-weight: 600;
    color: #6c757d;
    font-size: 0.95rem;
}
.card-resumen .valor {
    font-size: 1.8rem;
    font-weight: 700;
}
</style>

<%
    String idParam = request.getParameter("id");

    Usuario usuario = null;
    List<Pedido> pedidos = null;

    Map<Integer, List<Producto>> productosPorPedido = new HashMap<>();
    Map<Integer, List<Servicio>> serviciosPorPedido = new HashMap<>();

    int totalPedidos = 0;
    int totalItemsProd = 0;
    int totalItemsServ = 0;
    double totalProductos = 0.0;
    double totalServicios = 0.0;

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

    if (idParam != null) {
        try {
            int usuarioId = Integer.parseInt(idParam);

            UsuarioDAO usuarioDao = new UsuarioDAO();
            PedidoDAO pedidoDao = new PedidoDAO();

            usuario = usuarioDao.obtenerPorId(usuarioId);
            pedidos = pedidoDao.listarPedidosPorUsuario(usuarioId);

            if (pedidos != null) {
                totalPedidos = pedidos.size();

                for (Pedido ped : pedidos) {

                    List<Producto> prods = pedidoDao.listarProductosPorPedido(ped.getId());
                    productosPorPedido.put(ped.getId(), prods);

                    if (prods != null) {
                        for (Producto prod : prods) {
                            int cantidad = prod.getStock(); 
                            totalItemsProd += cantidad;
                            totalProductos += prod.getPrecio() * cantidad;
                        }
                    }

                    List<Servicio> servs = pedidoDao.listarServiciosPorPedido(ped.getId());
                    serviciosPorPedido.put(ped.getId(), servs);

                    if (servs != null) {
                        for (Servicio s : servs) {
                            totalItemsServ++;
                            totalServicios += s.getPrecio();
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    double totalGeneral = totalProductos + totalServicios;
%>

<div class="container mt-5 mb-5">

    <!-- BOTÓN VOLVER -->
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/clientes.jsp" class="btn btn-secondary btn-sm">
            ← Volver a Gestión de Clientes
        </a>
    </div>

    <!-- TÍTULO -->
    <h2 class="text-center fw-bold mb-4 text-primary">Historial de Cliente</h2>

    <% if (usuario == null) { %>
        <div class="alert alert-danger">No se encontró el cliente.</div>
        </div>
        <jsp:include page="components/layout/footer.jsp" />
        <% return; } %>

    <!-- RESUMEN EN CARDS -->
    <div class="row g-3 mb-4">

        <div class="col-md-3">
            <div class="card shadow-sm border-0 card-resumen">
                <div class="titulo">Pedidos</div>
                <div class="valor"><%= totalPedidos %></div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card shadow-sm border-0 card-resumen">
                <div class="titulo">Productos adquiridos</div>
                <div class="valor"><%= totalItemsProd %></div>
                <small class="text-muted">S/. <%= String.format("%.2f", totalProductos) %></small>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card shadow-sm border-0 card-resumen">
                <div class="titulo">Servicios adquiridos</div>
                <div class="valor"><%= totalItemsServ %></div>
                <small class="text-muted">S/. <%= String.format("%.2f", totalServicios) %></small>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card shadow-sm border-0 bg-primary text-white card-resumen">
                <div class="titulo">Total gastado</div>
                <div class="valor">S/. <%= String.format("%.2f", totalGeneral) %></div>
            </div>
        </div>

    </div>

    <!-- DATOS DEL CLIENTE -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-primary text-white">
            Datos del cliente
        </div>
        <div class="card-body">
            <p><strong>ID:</strong> <%= usuario.getId() %></p>
            <p><strong>Nombre:</strong> <%= usuario.getNombre() %> <%= usuario.getApellidos() %></p>
            <p><strong>Correo:</strong> <%= usuario.getCorreo() %></p>
            <p><strong>Teléfono:</strong> <%= usuario.getTelefono() %></p>
        </div>
    </div>

    <!--   SECCIÓN: PRODUCTOS Y SERVICIOS      -->
    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-success text-white">
            Historial de productos y servicios adquiridos
        </div>

        <div class="card-body">

            <% if (pedidos == null || pedidos.isEmpty()) { %>

                <p class="text-muted">Este cliente aún no tiene compras registradas.</p>

            <% } else { %>

            <div class="row">

                <!-- PRODUCTOS -->
                <div class="col-md-6 mb-4">
                    <h5 class="fw-bold text-primary mb-3">Productos</h5>

                    <div class="table-responsive">
                        <table class="table table-striped table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Pedido</th>
                                    <th>Img</th>
                                    <th>Nombre</th>
                                    <th>Cant.</th>
                                    <th>Precio</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    for (Pedido ped : pedidos) {
                                        List<Producto> prods = productosPorPedido.get(ped.getId());
                                        if (prods != null) {
                                            for (Producto p : prods) {
                                                int cant = p.getStock();
                                                double subtotal = cant * p.getPrecio();
                                %>
                                <tr>
                                    <td><%= ped.getId() %></td>
                                    <td style="width: 60px;">
                                        <% if (p.getImagen() != null) { %>
                                            <img src="<%= p.getImagen() %>" class="img-fluid rounded">
                                        <% } %>
                                    </td>
                                    <td><%= p.getNombre() %></td>
                                    <td><%= cant %></td>
                                    <td>S/. <%= p.getPrecio() %></td>
                                    <td>S/. <%= subtotal %></td>
                                </tr>
                                <%          }
                                        }
                                    }
                                %>
                            </tbody>

                        </table>
                    </div>
                </div>

                <!-- SERVICIOS -->
                <div class="col-md-6 mb-4">
                    <h5 class="fw-bold text-warning mb-3">Servicios</h5>

                    <div class="table-responsive">
                        <table class="table table-striped table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Pedido</th>
                                    <th>Img</th>
                                    <th>Nombre</th>
                                    <th>Duración</th>
                                    <th>Precio</th>
                                </tr>
                            </thead>

                            <tbody>
                                <%
                                    for (Pedido ped : pedidos) {
                                        List<Servicio> servs = serviciosPorPedido.get(ped.getId());
                                        if (servs != null) {
                                            for (Servicio s : servs) {
                                %>
                                <tr>
                                    <td><%= ped.getId() %></td>
                                    <td style="width: 60px;">
                                        <% if (s.getImagen() != null) { %>
                                            <img src="<%= s.getImagen() %>" class="img-fluid rounded">
                                        <% } %>
                                    </td>
                                    <td><%= s.getNombre() %></td>
                                    <td>
                                        <% if (s.getDuracion() != null) { %>
                                            <%= s.getDuracion().toString() %>
                                        <% } else { %> - <% } %>
                                    </td>
                                    <td>S/. <%= s.getPrecio() %></td>
                                </tr>
                                <%          }
                                        }
                                    }
                                %>
                            </tbody>

                        </table>
                    </div>
                </div>

            </div>

            <% } %>

        </div>
    </div>

    <!--             HISTORIAL DE PEDIDOS (DETALLE)                -->

    <div class="card mb-4 shadow-sm">
        <div class="card-header bg-dark text-white">
            Historial de pedidos
        </div>

        <div class="card-body">

            <% if (pedidos == null || pedidos.isEmpty()) { %>

                <p class="text-muted">No hay pedidos registrados para este cliente.</p>

            <% } else { %>

            <div class="table-responsive">

                <table class="table table-striped table-hover align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>ID Pedido</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th>Total Pedido</th>
                            <th>Acción</th>
                        </tr>
                    </thead>

                    <tbody>
                        <%
                            for (Pedido ped : pedidos) {

                                double totalPedidoCalc = 0.0;

                                List<Producto> prods = productosPorPedido.get(ped.getId());
                                if (prods != null)
                                    for (Producto p : prods)
                                        totalPedidoCalc += p.getPrecio() * p.getStock();

                                List<Servicio> servs = serviciosPorPedido.get(ped.getId());
                                if (servs != null)
                                    for (Servicio s : servs)
                                        totalPedidoCalc += s.getPrecio();

                                String estado = ped.getEstado();
                                String badge = "bg-secondary";

                                if ("pendiente".equalsIgnoreCase(estado)) badge = "bg-warning text-dark";
                                if ("completado".equalsIgnoreCase(estado)) badge = "bg-success";
                                if ("cancelado".equalsIgnoreCase(estado)) badge = "bg-danger";
                        %>

                        <tr>
                            <td><%= ped.getId() %></td>
                            <td><%= sdf.format(ped.getFecha()) %></td>
                            <td><span class="badge <%= badge %>"><%= estado %></span></td>
                            <td>S/. <%= String.format("%.2f", totalPedidoCalc) %></td>
                            <td>
                                <button class="btn btn-outline-primary btn-sm"
                                        data-bs-toggle="collapse"
                                        data-bs-target="#detalle<%= ped.getId() %>">
                                    Ver detalle
                                </button>
                            </td>
                        </tr>

                        <!-- DETALLE -->
                        <tr class="collapse bg-light" id="detalle<%= ped.getId() %>">
                            <td colspan="5">

                                <div class="row">

                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Productos</h6>
                                        <% if (prods == null || prods.isEmpty()) { %>
                                            <p class="text-muted mb-1">Sin productos.</p>
                                        <% } else { %>
                                            <ul class="list-unstyled mb-1">
                                                <% for (Producto p : prods) { %>
                                                    <li>
                                                        <strong><%= p.getNombre() %></strong> (x<%= p.getStock() %>)
                                                        — S/ <%= p.getPrecio() * p.getStock() %>
                                                    </li>
                                                <% } %>
                                            </ul>
                                        <% } %>
                                    </div>

                                    <div class="col-md-6">
                                        <h6 class="fw-bold">Servicios</h6>
                                        <% if (servs == null || servs.isEmpty()) { %>
                                            <p class="text-muted mb-1">Sin servicios.</p>
                                        <% } else { %>
                                            <ul class="list-unstyled mb-1">
                                                <% for (Servicio s : servs) { %>
                                                    <li>
                                                        <strong><%= s.getNombre() %></strong>
                                                        <% if (s.getDuracion() != null) { %>
                                                            (duración: <%= s.getDuracion() %>)
                                                        <% } %>
                                                        — S/ <%= s.getPrecio() %>
                                                    </li>
                                                <% } %>
                                            </ul>
                                        <% } %>
                                    </div>

                                </div>

                            </td>
                        </tr>

                        <% } %>

                    </tbody>
                </table>

            </div>

            <% } %>

        </div>
    </div>

</div>

<jsp:include page="components/layout/footer.jsp" />
