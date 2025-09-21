<%-- 
    Document   : menuServicios
    Created on : 18 set. 2025, 11:38:56
    Author     : Juan Andre Zea Apaza
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${empty sessionScope.usuario}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Servicios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4 text-center">Panel de Servicios Registrados</h2>

    <div class="alert alert-info text-center">
        Bienvenido, <strong>${sessionScope.usuario.nombre}</strong> (Encargado de Servicios)
    </div>

    <!-- 🔹 Formulario de registro de servicio -->
    <div class="card p-4 shadow-sm mb-4">
        <h5>Registrar nuevo servicio</h5>
        <!-- ✅ corregido el action -->
        <form method="post" action="svltServicio">
            <input type="hidden" name="accion" value="registrar"/>

            <div class="mb-3">
                <label class="form-label">Nombre del Servicio</label>
                <input type="text" name="nombre" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Precio</label>
                <input type="number" step="0.01" name="precio" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Cliente</label>
                <input type="text" name="cliente" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Descripción</label>
                <textarea name="descripcion" class="form-control" required></textarea>
            </div>
            <div class="mb-3">
                <label class="form-label">Estado</label>
                <select name="estado" class="form-control" required>
                    <option value="Pendiente">Pendiente</option>
                    <option value="En Proceso">En Proceso</option>
                    <option value="Completado">Completado</option>
                    <option value="Cancelado">Cancelado</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Fecha</label>
                <input type="date" name="fecha" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-primary">Registrar Servicio</button>
        </form>
    </div>

    <!-- 🔹 Tabla de servicios -->
    <table class="table table-striped table-hover shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>ID Servicio</th>
                <th>Nombre</th>
                <th>Precio</th>
                <th>Cliente</th>
                <th>Descripción</th>
                <th>Estado</th>
                <th>Fecha</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty listaServicios}">
                    <c:forEach var="servicio" items="${listaServicios}">
                        <tr class="${servicio.estado eq 'Pendiente' ? 'table-warning' :
                                   servicio.estado eq 'En Proceso' ? 'table-info' :
                                   servicio.estado eq 'Cancelado' ? 'table-danger' :
                                   'table-success'}">
                            <td>${servicio.id}</td>
                            <td>${servicio.nombre}</td>
                            <td>S/. <fmt:formatNumber value="${servicio.precio}" type="number" minFractionDigits="2"/></td>
                            <td>${servicio.cliente}</td>
                            <td>${servicio.descripcion}</td>
                            <td>${servicio.estado}</td>
                            <td><fmt:formatDate value="${servicio.fecha}" pattern="dd/MM/yyyy"/></td>
                            <td>
                                <!-- Botón Editar -->
                                <button type="button" class="btn btn-sm btn-warning"
                                        data-bs-toggle="modal" data-bs-target="#modalEditar${servicio.id}">
                                    Editar
                                </button>

                                <!-- Modal Editar -->
                                <div class="modal fade" id="modalEditar${servicio.id}" tabindex="-1" aria-hidden="true">
                                  <div class="modal-dialog">
                                    <div class="modal-content">
                                      <!-- ✅ corregido el action -->
                                      <form method="post" action="svltServicio">
                                        <div class="modal-header">
                                          <h5 class="modal-title">Editar Servicio</h5>
                                          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                        </div>
                                        <div class="modal-body">
                                          <input type="hidden" name="accion" value="editar"/>
                                          <input type="hidden" name="id" value="${servicio.id}"/>

                                          <div class="mb-3">
                                            <label class="form-label">Nombre del Servicio</label>
                                            <input type="text" name="nombre" class="form-control"
                                                   value="${servicio.nombre}" required/>
                                          </div>
                                          <div class="mb-3">
                                            <label class="form-label">Precio</label>
                                            <input type="number" step="0.01" name="precio" class="form-control"
                                                   value="${servicio.precio}" required/>
                                          </div>
                                          <div class="mb-3">
                                            <label class="form-label">Cliente</label>
                                            <input type="text" name="cliente" class="form-control"
                                                   value="${servicio.cliente}" required/>
                                          </div>
                                          <div class="mb-3">
                                            <label class="form-label">Descripción</label>
                                            <textarea name="descripcion" class="form-control" required>${servicio.descripcion}</textarea>
                                          </div>
                                          <div class="mb-3">
                                            <label class="form-label">Estado</label>
                                            <select name="estado" class="form-control" required>
                                                <option ${servicio.estado eq 'Pendiente' ? 'selected' : ''}>Pendiente</option>
                                                <option ${servicio.estado eq 'En Proceso' ? 'selected' : ''}>En Proceso</option>
                                                <option ${servicio.estado eq 'Completado' ? 'selected' : ''}>Completado</option>
                                                <option ${servicio.estado eq 'Cancelado' ? 'selected' : ''}>Cancelado</option>
                                            </select>
                                          </div>
                                          <div class="mb-3">
                                            <label class="form-label">Fecha</label>
                                            <input type="date" name="fecha" class="form-control"
                                                   value="<fmt:formatDate value='${servicio.fecha}' pattern='yyyy-MM-dd'/>" required/>
                                          </div>
                                        </div>
                                        <div class="modal-footer">
                                          <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                        </div>
                                      </form>
                                    </div>
                                  </div>
                                </div>

                                <!-- Botón Eliminar -->
                                <!-- ✅ corregido el action -->
                                <form method="post" action="svltServicio" class="d-inline">
                                    <input type="hidden" name="accion" value="eliminar"/>
                                    <input type="hidden" name="id" value="${servicio.id}"/>
                                    <button type="submit" class="btn btn-sm btn-danger"
                                            onclick="return confirm('¿Desea eliminar este servicio?')">
                                        Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="8" class="text-center text-muted">No hay servicios registrados todavía.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- 🔹 Total de servicios -->
    <p class="text-end fw-bold">
        Total de servicios: <c:out value="${listaServicios != null ? listaServicios.size() : 0}"/>
    </p>

    <div class="text-center mt-3">
        <a href="cerrar.jsp" class="btn btn-danger">Cerrar Sesión</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
