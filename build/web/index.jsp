<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Principal - UMG</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f5f7fa;
            font-family: "Segoe UI", sans-serif;
            min-height: 100vh;
        }

        /* Barra lateral */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #003366, #004080);
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            padding-top: 20px;
            color: white;
            box-shadow: 2px 0px 10px rgba(0,0,0,0.2);
        }

        .sidebar h4 {
            font-weight: 700;
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar .btn-toggle {
            width: 100%;
            color: #fff;
            text-align: left;
            border: none;
            background: transparent;
            padding: 10px 20px;
            font-size: 16px;
            transition: background 0.3s;
        }

        .sidebar .btn-toggle:hover {
            background-color: rgba(255,255,255,0.1);
        }

        .submenu a {
            display: block;
            padding: 8px 40px;
            font-size: 15px;
            color: #dcdcdc;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .submenu a:hover {
            color: #fff;
            background-color: rgba(255,255,255,0.15);
            border-radius: 5px;
        }

        .submenu .bi {
            margin-right: 8px;
        }

        /* Contenido principal */
        .content {
            margin-left: 290px;
            padding: 40px;
        }

        .card {
            background: white;
            border: none;
            border-radius: 15px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.1);
            padding: 30px;
        }

        .logout-btn {
            position: absolute;
            bottom: 20px;
            width: 100%;
            text-align: center;
        }

        .logout-btn a {
            color: #ffb3b3;
            text-decoration: none;
        }

        .logout-btn a:hover {
            color: white;
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <div class="sidebar">
    <h4><i class="bi bi-building"></i> Empresa CEJ</h4>

    <!-- Productos -->
    <div class="menu-section">
        <div class="d-flex justify-content-between align-items-center">
            <a href="productos.jsp" class="btn-toggle text-decoration-none text-white">
                <i class="bi bi-box-seam"></i> Productos
            </a>
            <button class="btn btn-sm text-white border-0" 
                    type="button" data-bs-toggle="collapse" data-bs-target="#menuProductos">
                <i class="bi bi-chevron-down"></i>
            </button>
        </div>
        <div class="collapse submenu" id="menuProductos">
            <a href="marca.jsp"><i class="bi bi-tags"></i> Marcas</a>
        </div>
    </div>

    <!-- Ventas -->
    <div class="menu-section mt-2">
        <div class="d-flex justify-content-between align-items-center">
            <a href="Ventas.jsp" class="btn-toggle text-decoration-none text-white">
                <i class="bi bi-cart3"></i> Ventas
            </a>
            <button class="btn btn-sm text-white border-0" 
                    type="button" data-bs-toggle="collapse" data-bs-target="#menuVentas">
                <i class="bi bi-chevron-down"></i>
            </button>
        </div>
        <div class="collapse submenu" id="menuVentas">
            <a href="clientes.jsp"><i class="bi bi-people"></i> Clientes</a>

            <!-- Submenú empleados -->
            <div class="ps-3">
                <div class="d-flex justify-content-between align-items-center">
                    <a href="empleados.jsp" class="btn-toggle text-decoration-none text-white">
                        <i class="bi bi-person-badge"></i> Empleados
                    </a>
                    <button class="btn btn-sm text-white border-0" 
                            type="button" data-bs-toggle="collapse" data-bs-target="#subEmpleados">
                        <i class="bi bi-chevron-right"></i>
                    </button>
                </div>
                <div class="collapse submenu" id="subEmpleados">
                    <a href="puesto.jsp"><i class="bi bi-briefcase"></i> Puestos</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Compras -->
    <div class="menu-section mt-2">
        <div class="d-flex justify-content-between align-items-center">
            <a href="Compras.jsp" class="btn-toggle text-decoration-none text-white">
                <i class="bi bi-bag-check"></i> Compras
            </a>
            <button class="btn btn-sm text-white border-0" 
                    type="button" data-bs-toggle="collapse" data-bs-target="#menuCompras">
                <i class="bi bi-chevron-down"></i>
            </button>
        </div>
        <div class="collapse submenu" id="menuCompras">
            <a href="proveedores.jsp"><i class="bi bi-truck"></i> Proveedores</a>
        </div>
    </div>

    <!-- Cerrar sesión -->
    <div class="logout-btn">
        <hr class="text-light">
        <a href="sr_logout"><i class="bi bi-box-arrow-right"></i> Cerrar sesión</a>
    </div>
</div>

    <!-- Contenido principal -->
    <div class="content d-flex align-items-center justify-content-center" style="min-height: 100vh;">
    <div class="card text-center shadow-lg p-5 w-100" 
         style="max-width: 1200px; min-height: 85vh; display: flex; flex-direction: column; justify-content: center;">

        <h1 class="fw-bold text-primary mb-4" style="font-size: 2.5rem;">Bienvenido al Panel Principal</h1>

        <p class="text-secondary mb-5 fs-5" style="max-width: 900px; margin: 0 auto;">
            Selecciona una de las secciones del menú lateral para gestionar la información de la empresa.
        </p>

        <div class="d-flex justify-content-center">
            <img src="img/carros.jpg"
                 class="img-fluid rounded shadow-lg border border-light"
                 style="max-width: 950px; width: 95%; height: auto; border-radius: 25px;"
                 alt="Logo UMG">
        </div>

        <div class="mt-5">
            <p class="text-muted fst-italic">© 2025 Empresa CEJ — Sistema de Gestión UMG</p>
        </div>
    </div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

