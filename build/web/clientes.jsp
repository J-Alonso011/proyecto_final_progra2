<%-- 
    Document   : empleados
    Created on : 23/10/2025, 9:03:09 p. m.
    Author     : alons
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Cliente"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Clientes - UMG</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="#"><i class="bi bi-building-fill"></i> CEJ</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="bi bi-house-door"></i> Inicio</a></li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            <i class="bi bi-list"></i> Menú
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

<!-- Contenido -->
<div class="container py-5">
  <div class="row g-4">
    <!-- Formulario (izquierda) -->
    <div class="col-lg-4">
      <div class="card shadow-sm">
        <div class="card-body">
          <h4 class="card-title fw-bold"><i class="bi bi-people-fill text-primary"></i> Gestión de Clientes</h4>
          <p class="text-muted small">Agrega, actualiza o elimina clientes desde este formulario.</p>

          <form action="sr_cliente" method="post" class="needs-validation" novalidate>
            <div class="mb-3">
              <label for="txt_id" class="form-label">ID</label>
              <input type="text" class="form-control" id="txt_id" name="txt_id" value="0" readonly>
            </div>

            <div class="mb-3">
              <label for="txt_nombres" class="form-label">Nombres</label>
              <input type="text" class="form-control" id="txt_nombres" name="txt_nombres" placeholder="Ej: nombre1 nombre2" required>
            </div>

            <div class="mb-3">
              <label for="txt_apellidos" class="form-label">Apellidos</label>
              <input type="text" class="form-control" id="txt_apellidos" name="txt_apellidos" placeholder="Ej: apellido1 apellido2" required>
            </div>

            <div class="row">
              <div class="col-6 mb-3">
                <label for="txt_nit" class="form-label">NIT</label>
                <input type="text" class="form-control" id="txt_nit" name="txt_nit" placeholder="Ej: 108488292" required>
              </div>
              <div class="col-6 mb-3">
                <label for="drop_genero" class="form-label">Género</label>
                <select class="form-select" id="drop_genero" name="drop_genero" required>
                  <option selected disabled value="">Seleccione</option>
                  <option value="1">Hombre</option>
                  <option value="0">Mujer</option>
                </select>
              </div>
            </div>

            <div class="mb-3">
              <label for="txt_telefono" class="form-label">Teléfono</label>
              <input type="tel" class="form-control" id="txt_telefono" name="txt_telefono" placeholder="Ej: 58616902" required>
            </div>

            <div class="mb-3">
              <label for="txt_correo_electronico" class="form-label">Correo</label>
              <input type="email" class="form-control" id="txt_correo_electronico" name="txt_correo_electronico" placeholder="ejemplo@correo.com" required>
            </div>

            <div class="mb-3">
              <label for="txt_fi" class="form-label">Fecha Ingreso</label>
              <input type="date" class="form-control" id="txt_fi" name="txt_fi" required>
            </div>

            <!-- Botones: cada uno visualmente distinto -->
            <div class="d-flex flex-wrap gap-2">
              <button class="btn btn-primary btn-lg" id="btn_crear" name="btn_crear" value="crear">
                <i class="bi bi-person-plus-fill"></i> Crear
              </button>

              <button class="btn btn-outline-warning btn-sm" id="btn_actualizar" name="btn_actualizar" value="actualizar">
                <i class="bi bi-pencil"></i> Actualizar
              </button>

              <button class="btn btn-danger btn-sm" id="btn_borrar" name="btn_borrar" value="borrar">
                <i class="bi bi-trash3-fill"></i> Borrar
              </button>

              <!-- pequeño y estilizado: limpiar form -->
              <button type="button" class="btn btn-outline-secondary btn-sm ms-auto" id="btn_nuevo">
                <i class="bi bi-arrow-clockwise"></i> Nuevo
              </button>
              <a href="ReporteClientesServlet" target="_blank" class="btn btn-warning"><i class="bi bi-file-earmark-pdf-fill"></i> PDF</a>
            </div>
          </form>
        </div>
      </div>

      <!-- Nota o ayuda -->
      <div class="mt-3 text-muted small">
        <i class="bi bi-info-circle"></i> Haz clic en una fila de la tabla para cargar el cliente en el formulario.
      </div>
    </div>

    <!-- Tabla (derecha) -->
    <div class="col-lg-8">
      <div class="card shadow-sm">
        <div class="card-body">
          <h5 class="card-title fw-bold"><i class="bi bi-card-list text-success"></i> Listado de Clientes</h5>

          <div class="table-responsive">
            <table class="table table-hover align-middle" id="tbl_clientes">
              <thead class="table-light">
                <tr>
                  <th>Nombres</th>
                  <th>Apellidos</th>
                  <th>Nit</th>
                  <th>Género</th>
                  <th>Teléfono</th>
                  <th>Correo</th>
                  <th>Ingreso</th>
                </tr>
              </thead>
              <tbody>
                <%
                  Cliente cliente = new Cliente();
                  DefaultTableModel tabla = cliente.leer();
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

          <!-- Paginación simulada (Bootstrap) -->
          <nav aria-label="Paginación clientes" class="mt-3">
            <ul class="pagination pagination-sm justify-content-end mb-0">
              <li class="page-item disabled"><a class="page-link">Anterior</a></li>
              <li class="page-item active"><a class="page-link">1</a></li>
              <li class="page-item"><a class="page-link">2</a></li>
              <li class="page-item"><a class="page-link">3</a></li>
              <li class="page-item"><a class="page-link">Siguiente</a></li>
            </ul>
          </nav>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Scripts (sin tocar lógica) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
  // pequeño helper: limpiar formulario (no toca Java ni servidor)
  document.getElementById('btn_nuevo').addEventListener('click', function() {
    const form = this.closest('form') || document.querySelector('form.needs-validation');
    if (!form) return;
    form.reset();
    // restablecer select género
    const genero = document.getElementById('drop_genero');
    if (genero) genero.selectedIndex = 0;
    // poner id en 0
    const id = document.getElementById('txt_id');
    if (id) id.value = '0';
    form.classList.remove('was-validated');
  });

  // comportamiento de selección (usa jQuery, igual que antes)
  $('#tbl_clientes').on('click', 'tr', function() {
    let fila = $(this);

    $("#txt_id").val(fila.data('id'));
    $("#txt_nombres").val(fila.find("td:eq(0)").text());
    $("#txt_apellidos").val(fila.find("td:eq(1)").text());
    $("#txt_nit").val(fila.find("td:eq(2)").text());

    let generoTexto = fila.find("td:eq(3)").text().trim().toLowerCase();
    if (generoTexto === "hombre" || generoTexto === "1" || generoTexto === "true") {
      $("#drop_genero").val("1");
    } else {
      $("#drop_genero").val("0");
    }
    $("#txt_telefono").val(fila.find("td:eq(4)").text());
    $("#txt_correo_electronico").val(fila.find("td:eq(5)").text());
    let fechaIngreso = fila.find("td:eq(6)").text().trim();
    if (fechaIngreso.includes(" ")) {
      fechaIngreso = fechaIngreso.split(" ")[0];
    }
    $("#txt_fi").val(fechaIngreso);
  });

  // Bootstrap validation (mantener)
  (function () {
    'use strict'
    const forms = document.querySelectorAll('.needs-validation')
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
</body>
</html>
