<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>UMG boca</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-image: url('img/umg_campus.png');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;
                height: 100vh;
            }   
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg bg-body-tertiary">
          <div class="container-fluid">
            <a class="navbar-brand" href="#">UMG</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNavDropdown">
              <ul class="navbar-nav">
                <li class="nav-item">
                  <a class="nav-link active" aria-current="page" href="index.jsp">Inicio</a>
                </li>
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                    Menú
                  </a>
                  <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="empleados.jsp">Empleados</a></li>
                    <li><a class="dropdown-item" href="clientes.jsp">Clientes</a></li>
                    <li><a class="dropdown-item" href="puesto.jsp">Puestos</a></li>
                    <li><a class="dropdown-item" href="marca.jsp">Marcas</a></li>
                    <li><a class="dropdown-item" href="productos.jsp">Productos</a></li>
                    <li><a class="dropdown-item" href="proveedores.jsp">Proveedores</a></li>
                    <li><a class="dropdown-item" href="Ventas.jsp">Ventas</a></li>
                    <li><a class="dropdown-item" href="Compras.jsp">Compras</a></li>
                  </ul>
                </li>
                <li class="nav-item">
                  <a class="nav-link text-danger" href="sr_logout">Cerrar sesión</a>
                </li>
              </ul>
            </div>
          </div>
        </nav>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>|
