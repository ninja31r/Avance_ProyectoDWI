<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<jsp:include page="components/layout/header.jsp" />

<div class="container mt-5">
    <!-- Formulario para registrar producto -->
    <div class="card p-4 shadow-sm mb-4">
        <h5>Registrar nuevo producto</h5>
        <form method="post" action="MenuProductoServlet">
            <input type="hidden" name="accion" value="agregar"/>

            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <input type="text" name="nombre" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Stock</label>
                <input type="number" name="stock" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Precio (entero)</label>
                <input type="number" name="precio" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Imagen (URL)</label>
                <input type="text" name="imagen" class="form-control">
            </div>

            <button type="submit" class="btn btn-primary">Registrar Producto</button>
        </form>
    </div>

    <!--  Tabla de productos -->
    <table class="table table-striped table-hover shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Stock</th>
                <th>Precio</th>
                <th>Imagen</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty productos}">
                    <c:forEach var="p" items="${productos}">
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.nombre}</td>
                            <td>${p.stock}</td>
                            <td>S/. <fmt:formatNumber value="${p.precio}" type="number" minFractionDigits="0"/></td>
                            <td>
                                <c:if test="${not empty p.imagen}">
                                    <img src="${p.imagen}" alt="Imagen" width="60" height="60" class="rounded">
                                </c:if>
                            </td>
                            <td>
                                <!-- Botón Eliminar -->
                                <form method="get" action="MenuProductoServlet" class="d-inline">
                                    <input type="hidden" name="accion" value="eliminar"/>
                                    <input type="hidden" name="id" value="${p.id}"/>
                                    <button type="submit" class="btn btn-sm btn-danger"
                                            onclick="return confirm('¿Desea eliminar este producto?')">
                                        Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="6" class="text-center text-muted">No hay productos registrados.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <!-- Total de productos -->
    <p class="text-end fw-bold">
        Total de productos: <c:out value="${productos != null ? productos.size() : 0}"/>
    </p>
</div>

 <jsp:include page="components/layout/footer.jsp" />