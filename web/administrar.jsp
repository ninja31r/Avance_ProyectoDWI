<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<jsp:include page="components/layout/header.jsp" />

  <div class="container text-center py-5">
    <h1 class="fw-bold mb-5 text-dark">Página de Administración</h1>

    <div class="row g-4 justify-content-center">
      <div class="col-10 col-sm-6 col-md-4">
        <a href="clientes.jsp" class="d-flex align-items-center justify-content-center bg-primary text-white text-decoration-none rounded-4 p-5 shadow h-100">
          <h2 class="fs-4 m-0">Usuarios</h2>
        </a>
      </div>

      <div class="col-10 col-sm-6 col-md-4">
        <a href="MenuProductoServlet" class="d-flex align-items-center justify-content-center bg-success text-white text-decoration-none rounded-4 p-5 shadow h-100">
          <h2 class="fs-4 m-0">Productos</h2>
        </a>
      </div>

      <div class="col-10 col-sm-6 col-md-4">
        <a href="MenuServiciosServlet" class="d-flex align-items-center justify-content-center bg-purple text-white text-decoration-none rounded-4 p-5 shadow h-100" style="background-color: #6f42c1;">
          <h2 class="fs-4 m-0">Servicios</h2>
        </a>
      </div>

    </div>
  </div>

 <jsp:include page="components/layout/footer.jsp" />