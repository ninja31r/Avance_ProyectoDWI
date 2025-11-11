<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="components/layout/header.jsp" %>

<div class="container mt-4 mb-5">
    <h2 class="mb-3">Administrar Servicios</h2>


    <div class="card mb-4 shadow-sm">
        <div class="card-header d-flex align-items-center justify-content-between">
            <span class="fw-semibold">Registrar servicio</span>
            <small class="text-muted">Completa los campos y guarda</small>
        </div>

        <div class="card-body">
            <form action="svltServicio" method="post" class="row g-3 needs-validation" novalidate>
                <input type="hidden" name="accion" value="registrar">

                <div class="col-12 col-lg-8">
                    <div class="row g-3">
                        <div class="col-md-7">
                            <label class="form-label">Nombre</label>
                            <input type="text" name="nombre" class="form-control" required>
                            <div class="invalid-feedback">Ingresa un nombre.</div>
                        </div>

                        <div class="col-md-5">
                            <label class="form-label">Precio (S/)</label>
                            <input type="number" name="precio" class="form-control" step="0.01" min="0" required>
                            <div class="invalid-feedback">Ingresa un precio válido.</div>
                        </div>

                        <div class="col-md-8">
                            <label class="form-label">Imagen (URL externa)</label>
                            <input type="text" name="imagen" class="form-control" placeholder="https://... o ejemplo.png"
                                   oninput="document.getElementById('preview-new').src=this.value.startsWith('http')?this.value: (this.value? ('${pageContext.request.contextPath}/img/servicios/'+this.value):'') ">
                            <div class="form-text">
                                URL externa. <code>http(s)</code> 
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label">Duración</label>
                            <input type="time" name="duracion" class="form-control">
                            <div class="form-text">Formato HH:mm</div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-lg-4">
                    <label class="form-label d-block">Vista previa</label>
                    <div class="border rounded p-2 d-flex align-items-center justify-content-center" style="height: 125px; background:#fafafa;">
                        <img id="preview-new" src="${pageContext.request.contextPath}/img/placeholder.png" alt="Vista previa"
                             style="max-width:100%; max-height:110px; border-radius:8px;">
                    </div>
                </div>

                <div class="col-12 " >
                    <button class="btn btn-primary">Guardar</button>
                </div>
            </form>
        </div>
    </div>


    <div class="card shadow-sm">
        <div class="card-header">Listado</div>
        <div class="card-body">
            <c:if test="${empty listaServicios}">
                <div class="alert alert-info mb-0">No hay servicios registrados.</div>
            </c:if>

            <c:if test="${not empty listaServicios}">
                <div class="table-responsive">
                    <table class="table table-striped align-middle">
                        <thead>
                            <tr>
                                <th style="width:70px;">ID</th>
                                <th style="width:120px;">Imagen</th>
                                <th>Nombre</th>
                                <th style="width:140px;">Precio</th>
                                <th style="width:130px;">Duración</th>
                                <th style="width:210px;">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${listaServicios}">
                                <tr>
                                    <td class="text-muted">#${s.id}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty s.imagen and (s.imagen.startsWith('http') or s.imagen.startsWith('https'))}">
                                                <img src="${s.imagen}" alt="${s.nombre}" style="width:100px;height:70px;object-fit:cover;border-radius:6px;">
                                            </c:when>
                                            <c:when test="${not empty s.imagen}">
                                                <img src="${pageContext.request.contextPath}/img/servicios/${s.imagen}" alt="${s.nombre}" style="width:100px;height:70px;object-fit:cover;border-radius:6px;">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/img/placeholder.png" alt="sin imagen" style="width:100px;height:70px;object-fit:cover;border-radius:6px;">
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="fw-semibold">${s.nombre}</td>
                                    <td>S/ ${s.precio}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${s.duracion != null}">${s.duracion}</c:when>
                                            <c:otherwise>—</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>

                                        <button
                                            class="btn btn-sm btn-outline-secondary me-1"
                                            type="button"
                                            data-bs-toggle="modal"
                                            data-bs-target="#editModal-${s.id}">
                                            Editar
                                        </button>


                                        <button
                                            class="btn btn-sm btn-outline-danger"
                                            type="button"
                                            data-bs-toggle="modal"
                                            data-bs-target="#deleteModal-${s.id}">
                                            Eliminar
                                        </button>
                                    </td>
                                </tr>


                            <div class="modal fade" id="editModal-${s.id}" tabindex="-1" aria-labelledby="editModalLabel-${s.id}" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="editModalLabel-${s.id}">Editar servicio #${s.id}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                        </div>
                                        <form action="svltServicio" method="post" class="needs-validation" novalidate>
                                            <input type="hidden" name="accion" value="editar">
                                            <input type="hidden" name="id" value="${s.id}">
                                            <div class="modal-body">
                                                <div class="row g-3">
                                                    <div class="col-md-7">
                                                        <label class="form-label">Nombre</label>
                                                        <input type="text" name="nombre" class="form-control" value="${s.nombre}" required>
                                                        <div class="invalid-feedback">Ingresa un nombre.</div>
                                                    </div>
                                                    <div class="col-md-5">
                                                        <label class="form-label">Precio (S/)</label>
                                                        <input type="number" name="precio" class="form-control" step="0.01" min="0" value="${s.precio}" required>
                                                        <div class="invalid-feedback">Ingresa un precio válido.</div>
                                                    </div>

                                                    <div class="col-md-8">
                                                        <label class="form-label">Imagen (URL externa)</label>
                                                        <input
                                                            type="text"
                                                            name="imagen"
                                                            class="form-control"
                                                            id="img-edit-${s.id}"
                                                            value="${s.imagen}"
                                                            oninput="
                                                            document.getElementById('preview-edit-${s.id}').src=
                                                            this.value.startsWith('http')
                                                            ? this.value
                                                            : (this.value ? ('${pageContext.request.contextPath}/img/servicios/'+this.value) : '${pageContext.request.contextPath}/img/placeholder.png')">
                                                        <div class="form-text">
                                                            URL externa <code>http(s)</code>.
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <label class="form-label">Duración</label>
                                                        <input type="time" name="duracion" class="form-control"
                                                               value="<c:out value='${s.duracion != null ? s.duracion.toString().substring(0,5) : ""}'/>">
                                                    </div>

                                                    <div class="col-12">
                                                        <label class="form-label d-block">Vista previa</label>
                                                        <div class="border rounded p-2 d-flex align-items-center justify-content-center" style="height: 180px; background:#fafafa;">
                                                            <c:choose>
                                                                <c:when test="${not empty s.imagen and (s.imagen.startsWith('http') or s.imagen.startsWith('https'))}">
                                                                    <img id="preview-edit-${s.id}" src="${s.imagen}" alt="Vista previa" style="max-width:100%; max-height:160px; border-radius:8px;">
                                                                </c:when>
                                                                <c:when test="${not empty s.imagen}">
                                                                    <img id="preview-edit-${s.id}" src="${pageContext.request.contextPath}/img/servicios/${s.imagen}" alt="Vista previa" style="max-width:100%; max-height:160px; border-radius:8px;">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <img id="preview-edit-${s.id}" src="${pageContext.request.contextPath}/img/placeholder.png" alt="Vista previa" style="max-width:100%; max-height:160px; border-radius:8px;">
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
                                                <button class="btn btn-success">Guardar cambios</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>


                            <div class="modal fade" id="deleteModal-${s.id}" tabindex="-1" aria-labelledby="deleteModalLabel-${s.id}" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="deleteModalLabel-${s.id}">Eliminar servicio</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p class="mb-2">¿Seguro que deseas eliminar el servicio <strong>${s.nombre}</strong>?</p>
                                            <small class="text-muted">Esta acción no se puede deshacer.</small>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-light" data-bs-dismiss="modal">No</button>
                                            <form action="svltServicio" method="post" class="d-inline">
                                                <input type="hidden" name="accion" value="eliminar">
                                                <input type="hidden" name="id" value="${s.id}">
                                                <button class="btn btn-danger">Sí, eliminar</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</div>

<%@include file="components/layout/footer.jsp" %>

<script>

    (function () {
        'use strict';
        var forms = document.querySelectorAll('.needs-validation');
        Array.prototype.slice.call(forms).forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    })();
</script>
