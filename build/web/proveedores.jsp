<%-- 
    Document   : proveedores
    Created on : 23/10/2025, 9:03:09 p. m.
    Author     : alons
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Proveedores"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Proveedores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>

<body class="bg-dark text-white">
    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-black shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-warning" href="#">UMG</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp"><i class="bi bi-house-door"></i> Inicio</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Menú</a>
                        <ul class="dropdown-menu dropdown-menu-dark">
                            <li><a class="dropdown-item" href="empleados.jsp">Empleados</a></li>
                            <li><a class="dropdown-item" href="clientes.jsp">Clientes</a></li>
                            <li><a class="dropdown-item" href="puesto.jsp">Puestos</a></li>
                            <li><a class="dropdown-item" href="marca.jsp">Marcas</a></li>
                            <li><a class="dropdown-item" href="productos.jsp">Productos</a></li>
                            <li><a class="dropdown-item" href="proveedores.jsp">Proveedores</a></li>
                            <li><a class="dropdown-item" href="Compras.jsp">Compras</a></li>
                            <li><a class="dropdown-item" href="Ventas.jsp">Ventas</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- CONTENIDO PRINCIPAL -->
    <div class="container mt-5">
        <h1 class="text-center text-warning mb-4 fw-bold">Gestión de Proveedores</h1>

        <!-- FORMULARIO -->
        <form action="sr_proveedor" method="post" class="row g-3 p-4 bg-secondary bg-gradient rounded shadow-lg">
            <div class="col-md-3">
                <label for="txt_id" class="form-label text-white fw-semibold">ID</label>
                <input type="text" class="form-control bg-dark text-white border-0" id="txt_id" name="txt_id" value="0" readonly>
            </div>

            <div class="col-md-3">
                <label for="txt_proveedor" class="form-label text-white fw-semibold">Proveedor</label>
                <input type="text" class="form-control bg-dark text-white border-0" id="txt_proveedor" name="txt_proveedor" placeholder="Ej: China" required>
            </div>

            <div class="col-md-3">
                <label for="txt_nit" class="form-label text-white fw-semibold">NIT</label>
                <input type="text" class="form-control bg-dark text-white border-0" id="txt_nit" name="txt_nit" placeholder="Ej: 108488292" required>
            </div>

            <div class="col-md-3">
                <label for="txt_direccion" class="form-label text-white fw-semibold">Dirección</label>
                <input type="text" class="form-control bg-dark text-white border-0" id="txt_direccion" name="txt_direccion" placeholder="Ej: Guatemala" required>
            </div>

            <div class="col-md-3">
                <label for="txt_telefono" class="form-label text-white fw-semibold">Teléfono</label>
                <input type="number" class="form-control bg-dark text-white border-0" id="txt_telefono" name="txt_telefono" placeholder="Ej: 58616902" required>
            </div>

            <!-- BOTONES -->
            <div class="col-12 text-center mt-4">
                <button class="btn btn-warning fw-semibold me-2" id="btn_crear" name="btn_crear" value="crear">
                    <i class="bi bi-floppy-fill"></i> Crear
                </button>
                <button class="btn btn-success fw-semibold me-2" id="btn_actualizar" name="btn_actualizar" value="actualizar">
                    <i class="bi bi-pencil"></i> Actualizar
                </button>
                <button class="btn btn-danger fw-semibold" id="btn_borrar" name="btn_borrar" value="borrar">
                    <i class="bi bi-trash3-fill"></i> Borrar
                </button>
            </div>
        </form>

        <!-- TABLA -->
        <div class="table-responsive mt-5">
            <table class="table table-dark table-hover align-middle text-center">
                <thead class="table-warning text-dark">
                    <tr>
                        <th>Proveedor</th>
                        <th>NIT</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                    </tr>
                </thead>
                <tbody id="tbl_proveedores">
                    <%
                        Proveedores proveedores = new Proveedores();
                        DefaultTableModel tabla = proveedores.leerProv();
                        for(int t=0; t<tabla.getRowCount(); t++){
                            out.println("<tr data-id='"+tabla.getValueAt(t,0)+"'>");
                            for (int c = 1; c < tabla.getColumnCount(); c++) {
                                out.println("<td>" + tabla.getValueAt(t, c) + "</td>");
                            }
                            out.println("</tr>");
                        }
                    %> 
                </tbody>
            </table>
        </div>    
    </div>

    <!-- SCRIPTS -->
    <script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

    <script>
      // Validación Bootstrap
      (() => {
        'use strict';
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
          form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
              event.preventDefault();
              event.stopPropagation();
            }
            form.classList.add('was-validated');
          }, false);
        });
      })();

      // Cargar datos al hacer clic en una fila
      $('#tbl_proveedores').on('click', 'tr', function() {
        let fila = $(this);
        $("#txt_id").val(fila.data('id'));
        $("#txt_proveedor").val(fila.find("td:eq(0)").text());
        $("#txt_nit").val(fila.find("td:eq(1)").text());
        $("#txt_direccion").val(fila.find("td:eq(2)").text());
        $("#txt_telefono").val(fila.find("td:eq(3)").text());
      });
    </script>
</body>
</html>