<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .card {
            max-width: 550px;
            margin: 60px auto;
            border: none;
            border-radius: 15px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-3px);
        }

        .card h3 {
            font-weight: 700;
            color: #1565c0;
            letter-spacing: 0.5px;
        }

        .form-label {
            color: #0d47a1;
            font-weight: 600;
        }

        .form-control {
            border-radius: 30px;
            padding: 10px 15px;
            border: 1px solid #bbdefb;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #42a5f5;
            box-shadow: 0 0 8px rgba(33, 150, 243, 0.4);
        }

        .btn-primary {
            border-radius: 30px;
            background: linear-gradient(90deg, #42a5f5, #1e88e5);
            border: none;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(90deg, #64b5f6, #2196f3);
            transform: scale(1.03);
        }

        .alert {
            border-radius: 10px;
        }
    </style>
</head>

<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-semibold" href="index.jsp">Auditel Import S.A.C</a>
        <div class="collapse navbar-collapse" id="menu">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Iniciar Sesión</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="card p-4 shadow-sm">
        <h3 class="mb-4 text-center text-primary">Registro de Usuario</h3>
        <form method="post" action="RegistroClienteServlet">
            <div class="mb-3">
                <label class="form-label">Nombre</label>
                <input type="text" name="nombre" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Apellidos</label>
                <input type="text" name="apellidos" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Teléfono</label>
                <input type="text" name="telefono" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Correo electrónico</label>
                <input type="email" name="correo" class="form-control" placeholder="Ejemplo: CLMarcoFlores@root.com" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Contraseña</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Registrarme</button>
        </form>

        <% 
            String mensaje = (String) request.getAttribute("mensaje");
            if (mensaje != null) { 
        %>
            <div class="alert alert-info mt-3"><%= mensaje %></div>
        <% } %>
    </div>
</div>

</body>
</html>
