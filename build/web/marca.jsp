<%-- 
    Document   : empleados
    Created on : 23/10/2025, 9:03:09 p. m.
    Author     : alons
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Marca"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mantenimiento de Marcas - UMG</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f6f9;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            background: linear-gradient(90deg, #0d6efd, #084298);
        }

        .navbar-brand {
            font-weight: bold;
            letter-spacing: 1px;
        }

        h1 {
            font-weight: 700;
            color: #0d6efd;
            margin-bottom: 25px;
        }

        .card {
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            background: white;
            padding: 30px;
        }

        .form-label {
            font-weight: 600;
            color: #333;
        }

        .btn {
            border-radius: 10px;
            padding: 8px 16px;
            font-weight: 500;
        }

        .btn i {
            margin-right: 6px;
        }

        .table {
            border-radius: 10px;
            overflow: hidden;
        }

        .table thead {
            background-color: #0d6efd;
            color: #fff;
        }

        .table tbody tr:hover {
            background-color: rgba(13,110,253,0.1);
            cursor: pointer;
        }

        footer {
            text-align: center;
            color: #888;
            margin-top: 50px;
        }
    </style>
</head>

<body>
<nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"><i class="bi bi-building"></i> CEJ</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="bi bi-house-door"></i> Inicio</a></li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            <i class="bi bi-menu-button-wide"></i> Menú
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
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

<div class="container py-5">
    <div class="card mb-5">
        <h1 class="text-center"><i class="bi bi-tags-fill"></i> Mantenimiento de Marcas</h1>

        <form action="sr_marca" method="post" class="row g-4 needs-validation" novalidate>
            <div class="col-md-4">
                <label for="lbl_id" class="form-label">ID</label>
                <input type="text" class="form-control" id="txt_id" name="txt_id" value="0" readonly>
            </div>

            <div class="col-md-5">
                <label for="lbl_marca" class="form-label">Marca</label>
                <input type="text" class="form-control" id="txt_marca" name="txt_marca" placeholder="Ej: Nissan" required>
            </div>

            <div class="col-md-12 d-flex flex-wrap gap-2 mt-3">
                <button class="btn btn-primary" id="btn_crear" name="btn_crear" value="crear">
                    <i class="bi bi-floppy-fill"></i> Crear
                </button>
                <button class="btn btn-success" id="btn_actualizar" name="btn_actualizar" value="actualizar">
                    <i class="bi bi-pencil"></i> Actualizar
                </button>
                <button class="btn btn-danger" id="btn_borrar" name="btn_borrar" value="borrar">
                    <i class="bi bi-trash3-fill"></i> Borrar
                </button>
                <a href="ReporteMarcasServlet" target="_blank" class="btn btn-warning"><i class="bi bi-file-earmark-pdf-fill"></i> PDF</a>
            </div>
        </form>
    </div>

    <div class="card">
        <h3 class="mb-4 text-center text-primary"><i class="bi bi-table"></i> Listado de Marcas</h3>

        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Marca</th>
                    </tr>
                </thead>
                <tbody id="tbl_marca">
                    <%
                        Marca marca = new Marca();
                        DefaultTableModel tabla = marca.leerm();
                        for(int t=0; t<tabla.getRowCount(); t++){
                            out.println("<tr data-id='"+tabla.getValueAt(t,0)+"'>");
                            for (int c = 0; c < tabla.getColumnCount(); c++) {
                                out.println("<td>" + tabla.getValueAt(t, c) + "</td>");
                            }
                            out.println("</tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<footer>
    <p>© 2025 Universidad Mariano Gálvez | Sistema de Gestión</p>
</footer>

<script>
  // Example starter JavaScript for disabling form submissions if there are invalid fields
    (() => {
      'use strict'

      // Fetch all the forms we want to apply custom Bootstrap validation styles to
      const forms = document.querySelectorAll('.needs-validation')

      // Loop over them and prevent submission
      Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
          if (!form.checkValidity()) {
            event.preventDefault()
            event.stopPropagation()
          }

          form.classList.add('was-validated')
        }, false)
      })
    })()
</script>
<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
      $('#tbl_marca').on('click', 'tr', function() {
        let fila = $(this);

       $("#txt_id").val(fila.find("td:eq(0)").text());
       $("#txt_marca").val(fila.find("td:eq(1)").text());
      });
    </script>
</body>
</html>
