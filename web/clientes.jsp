<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo_dao.UsuarioDAO"%>
<%@page import="modelo_entidad.Usuario"%>
<%@page import="java.util.ArrayList"%>

<jsp:include page="components/layout/header.jsp" />

<div class="container mt-5 mb-5">
    <h2 class="text-center fw-bold mb-4 text-primary">Gestión de Clientes</h2>

    <%
        UsuarioDAO dao = new UsuarioDAO();
        ArrayList<Usuario> lista = dao.listar();
    %>

    <!-- Botón nuevo cliente -->
    <div class="d-flex justify-content-end mb-3">
        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#agregarModal">
            <i class="bi bi-person-plus"></i> Nuevo Cliente
        </button>
    </div>

    <div class="card shadow-sm p-4">
        <table class="table table-striped table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Rol</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (lista.isEmpty()) {
                %>
                    <tr>
                        <td colspan="7" class="text-center text-muted">No hay clientes registrados.</td>
                    </tr>
                <%
                    } else {
                        for (Usuario u : lista) {
                %>
                    <tr>
                        <td><%=u.getId()%></td>
                        <td><%=u.getNombre()%></td>
                        <td><%=u.getApellidos()%></td>
                        <td><%=u.getCorreo()%></td>
                        <td><%=u.getTelefono()%></td>
                        <td>
                            <%
                                if (u.getRol_id() == 1) out.print("Cliente");
                                else if (u.getRol_id() == 2) out.print("Administrador");
                                else if (u.getRol_id() == 3) out.print("Trabajador");
                                else out.print("Otro");
                            %>
                        </td>
                        <td>
                            <!-- Botón Editar -->
                            <button class="btn btn-warning btn-sm"
                                    data-bs-toggle="modal"
                                    data-bs-target="#editarModal<%=u.getId()%>">
                                Editar
                            </button>

                            <!-- Botón Eliminar -->
                            <button class="btn btn-danger btn-sm"
                                    data-bs-toggle="modal"
                                    data-bs-target="#eliminarModal<%=u.getId()%>">
                                Eliminar
                            </button>
                                
                            <!-- Botón Historial -->
                                <a class="btn btn-info btn-sm"
                                       href="${pageContext.request.contextPath}/historialCliente.jsp?id=<%=u.getId()%>">
                                        Historial
                                </a>
                        </td>
                    </tr>

                    <!-- MODAL EDITAR -->
                    <div class="modal fade" id="editarModal<%=u.getId()%>" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <form action="${pageContext.request.contextPath}/ClienteServlet" method="post">
                                    <input type="hidden" name="accion" value="editar">
                                    <input type="hidden" name="id" value="<%=u.getId()%>">

                                    <div class="modal-header bg-primary text-white">
                                        <h5 class="modal-title">Editar Cliente</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>

                                    <div class="modal-body">
                                        <!-- Rol primero -->
                                        <div class="mb-3">
                                            <label class="form-label">Rol</label>
                                            <select name="rol" class="form-select rol-select" required>
                                                <option value="1" <%= (u.getRol_id()==1?"selected":"") %>>Cliente</option>
                                                <option value="2" <%= (u.getRol_id()==2?"selected":"") %>>Administrador</option>
                                                <option value="3" <%= (u.getRol_id()==3?"selected":"") %>>Trabajador</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Nombre</label>
                                            <input type="text" name="nombre" value="<%=u.getNombre()%>" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Apellidos</label>
                                            <input type="text" name="apellidos" value="<%=u.getApellidos()%>" class="form-control" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Correo</label>
                                            <input type="email" name="correo" value="<%=u.getCorreo()%>" class="form-control correo-input" required>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Teléfono</label>
                                            <input type="text" name="telefono" value="<%=u.getTelefono()%>" class="form-control">
                                        </div>
                                    </div>

                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-success">Guardar cambios</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- MODAL ELIMINAR -->
                    <div class="modal fade" id="eliminarModal<%=u.getId()%>" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <form action="${pageContext.request.contextPath}/ClienteServlet" method="post">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <input type="hidden" name="id" value="<%=u.getId()%>">
                                    <div class="modal-header bg-danger text-white">
                                        <h5 class="modal-title">Eliminar Cliente</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <p>¿Seguro que deseas eliminar al cliente <strong><%=u.getNombre()%> <%=u.getApellidos()%></strong>?</p>
                                        <small class="text-muted">Esta acción no se puede deshacer.</small>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-danger">Eliminar</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- MODAL AGREGAR NUEVO CLIENTE -->
<div class="modal fade" id="agregarModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/ClienteServlet" method="post">
                <input type="hidden" name="accion" value="agregar">
                <div class="modal-header bg-success text-white">
                    <h5 class="modal-title">Registrar Nuevo Cliente</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <!-- Rol primero -->
                    <div class="mb-3">
                        <label class="form-label">Rol</label>
                        <select name="rol" class="form-select rol-select" required>
                            <option value="">Seleccione...</option>
                            <option value="1">Cliente</option>
                            <option value="2">Administrador</option>
                            <option value="3">Trabajador</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Nombre</label>
                        <input type="text" name="nombre" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Apellidos</label>
                        <input type="text" name="apellidos" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Correo</label>
                        <input type="email" name="correo" class="form-control correo-input" placeholder="Ej: CLusuario@gmail.com" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Contraseña</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Teléfono</label>
                        <input type="text" name="telefono" class="form-control">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-success">Registrar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- SWEETALERT2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
document.querySelectorAll('form[action$="/ClienteServlet"][method="post"]').forEach(form => {
    const accion = form.querySelector('input[name="accion"]');
    if (accion && accion.value === 'eliminar') {
        form.addEventListener('submit', function (e) {
            e.preventDefault();
            Swal.fire({
                title: "¿Estás seguro?",
                text: "El cliente será eliminado permanentemente.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "Sí, eliminar",
                cancelButtonText: "Cancelar"
            }).then((result) => {
                if (result.isConfirmed) {
                    form.submit();
                }
            });
        });
    }
});

// Prefijo automático según rol
document.addEventListener("DOMContentLoaded", () => {

    function aplicarPrefijo(select) {
        const form = select.closest("form");
        const correoInput = form.querySelector(".correo-input");
        let prefijo = "";

        switch (select.value) {
            case "1": prefijo = "CL"; break;
            case "2": prefijo = "ADM"; break;
            case "3": prefijo = "TRAB"; break;
            default: prefijo = "";
        }

        if (correoInput) {
            const actual = correoInput.value;
            const sinPrefijo = actual.replace(/^(CL|ADM|TRAB)/, "");
            correoInput.value = prefijo ? prefijo + sinPrefijo : sinPrefijo;
        }
    }

    document.querySelectorAll(".rol-select").forEach(select => {
        select.addEventListener("change", () => aplicarPrefijo(select));
    });
});

// Mensajes según parámetro msg
document.addEventListener("DOMContentLoaded", function() {
    const urlParams = new URLSearchParams(window.location.search);
    const msg = urlParams.get("msg");

    if (msg === "agregado") {
        Swal.fire({ icon: "success", title: "Cliente agregado", text: "El cliente fue registrado correctamente.", timer: 1800, showConfirmButton: false });
    } else if (msg === "editado") {
        Swal.fire({ icon: "success", title: "Datos actualizados", text: "Los datos del cliente se actualizaron correctamente.", timer: 1800, showConfirmButton: false });
    } else if (msg === "eliminado") {
        Swal.fire({ icon: "success", title: "Cliente eliminado", text: "El cliente fue eliminado correctamente.", timer: 1800, showConfirmButton: false });
    } else if (msg === "error") {
        Swal.fire({ icon: "error", title: "Ocurrió un error", text: "Hubo un problema al procesar la solicitud." });
    }
});
</script>

<jsp:include page="components/layout/footer.jsp" />
