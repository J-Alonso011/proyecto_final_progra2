 <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Puesto"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Puestos - UMG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>

<body class="bg-light text-dark">

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold" href="#">UMG</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="index.jsp"><i class="bi bi-house"></i> Inicio</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            <i class="bi bi-menu-button-wide"></i> Menú
          </a>
          <ul class="dropdown-menu">
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
  <div class="card shadow-lg border-0 rounded-4">
    <div class="card-header bg-dark text-white text-center py-3">
      <h3 class="mb-0"><i class="bi bi-person-workspace"></i> Gestión de Puestos</h3>
    </div>
    <div class="card-body bg-white">
      <form action="sr_puesto" method="post" class="row g-3 needs-validation" novalidate>
        
        <!-- Campo ID -->
        <div class="col-md-3">
          <label for="txt_id" class="form-label">ID</label>
          <input type="text" class="form-control" id="txt_id" name="txt_id" value="0" readonly>
        </div>

        <!-- Campo Puesto -->
        <div class="col-md-6">
          <label for="txt_puesto" class="form-label">Puesto</label>
          <input type="text" class="form-control" id="txt_puesto" name="txt_puesto" placeholder="Ej: Ingeniero de sistemas" required>
        </div>

        <!-- Botones -->
        <div class="col-md-12 d-flex justify-content-center mt-4 flex-wrap gap-2">
          <button class="btn btn-primary" id="btn_crear" name="btn_crear" value="crear">
            <i class="bi bi-floppy-fill"></i> Crear
          </button>
          <button class="btn btn-success" id="btn_actualizar" name="btn_actualizar" value="actualizar">
            <i class="bi bi-pencil"></i> Actualizar
          </button>
          <button class="btn btn-danger" id="btn_borrar" name="btn_borrar" value="borrar">
            <i class="bi bi-trash3-fill"></i> Borrar
          </button>
        </div>
      </form>
    </div>
  </div>

  <!-- TABLA DE PUESTOS -->
  <div class="card mt-4 shadow-sm border-0 rounded-4">
    <div class="card-header bg-dark text-white text-center py-2">
      <h5 class="mb-0"><i class="bi bi-table"></i> Lista de Puestos</h5>
    </div>
    <div class="card-body p-3">
      <div class="table-responsive">
        <table class="table table-hover align-middle">
          <thead class="table-dark text-center">
            <tr>
              <th>ID</th>
              <th>Puesto</th>
            </tr>
          </thead>
          <tbody id="tbl_puesto" class="text-center">
            <%
              Puesto puesto = new Puesto();
              DefaultTableModel tabla = puesto.leerp();
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
</div>

<!-- SCRIPTS -->
<script>
(() => {
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

<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
  $('#tbl_puesto').on('click', 'tr', function() {
    let fila = $(this);
    $("#txt_id").val(fila.find("td:eq(0)").text());
    $("#txt_puesto").val(fila.find("td:eq(1)").text());
  });
</script>

</body>
</html>

