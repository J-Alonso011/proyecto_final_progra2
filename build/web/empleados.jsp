<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Puesto"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Empleado"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Empleados - UMG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body class="bg-light text-dark">
    
    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
      <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="#">CEJ</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNavDropdown">
          <ul class="navbar-nav">
            <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="bi bi-house"></i> Inicio</a></li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Menú</a>
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
            <div class="card-header bg-dark text-white text-center">
                <h3 class="mb-0"><i class="bi bi-people-fill"></i> Gestión de Empleados</h3>
            </div>
            <div class="card-body bg-white">
                <form action="sr_empleado" method="post" class="row g-3 needs-validation" novalidate>
                    <!-- CAMPOS DEL FORMULARIO -->
                    <div class="col-md-2">
                        <label for="txt_id" class="form-label">ID</label>
                        <input type="text" class="form-control" id="txt_id" name="txt_id" value="0" readonly>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label">Nombres</label>
                        <input type="text" class="form-control" id="txt_nombres" name="txt_nombres" placeholder="Ej: Juan Carlos" required>
                    </div>
                    <div class="col-md-5">
                        <label class="form-label">Apellidos</label>
                        <input type="text" class="form-control" id="txt_apellidos" name="txt_apellidos" placeholder="Ej: Pérez López" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Dirección</label>
                        <input type="text" class="form-control" id="txt_direccion" name="txt_direccion" placeholder="Ej: 10 avenida zona 3" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Teléfono</label>
                        <input type="number" class="form-control" id="txt_telefono" name="txt_telefono" placeholder="Ej: 55551234" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">DPI</label>
                        <input type="text" class="form-control" id="txt_dpi" name="txt_dpi" placeholder="Ej: 3605105820101" required>
                    </div>

                    <div class="col-md-3">
                        <label class="form-label">Género</label>
                        <select class="form-select" id="drop_genero" name="drop_genero" required>
                            <option selected disabled value="">Seleccione</option>
                            <option value="1">Hombre</option>
                            <option value="0">Mujer</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Fecha Nacimiento</label>
                        <input type="date" class="form-control" id="txt_fn" name="txt_fn" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Puesto</label>
                        <select class="form-select" id="drop_puesto" name="drop_puesto" required>
                            <option selected disabled value="">Seleccione</option>
                            <% 
                                Puesto puesto = new Puesto();
                                HashMap<String,String> drop = puesto.leer();
                                for(String i: drop.keySet()){
                                    out.println("<option value='"+i+"'>"+drop.get(i)+ "</option>");
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Inicio Labores</label>
                        <input type="date" class="form-control" id="txt_fil" name="txt_fil" required>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">Fecha Ingreso</label>
                        <input type="date" class="form-control" id="txt_fi" name="txt_fi" required>
                    </div>

                    <!-- BOTONES -->
                    <div class="col-12 d-flex justify-content-between align-items-center mt-4">
                        <div>
                            <button class="btn btn-primary me-2" id="btn_crear" name="btn_crear" value="crear">
                                <i class="bi bi-floppy-fill"></i> Crear
                            </button>
                            <button class="btn btn-success me-2" id="btn_actualizar" name="btn_actualizar" value="actualizar">
                                <i class="bi bi-pencil"></i> Actualizar
                            </button>
                            <button class="btn btn-danger" id="btn_borrar" name="btn_borrar" value="borrar">
                                <i class="bi bi-trash3-fill"></i> Borrar
                            </button>
                        </div>
                        <a href="reporteEmpleados" target="_blank" class="btn btn-warning">
                            <i class="bi bi-file-earmark-pdf-fill"></i> PDF
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- TABLA DE EMPLEADOS -->
        <div class="card mt-4 shadow-sm border-0 rounded-4">
            <div class="card-header bg-dark text-white text-center">
                <h5 class="mb-0"><i class="bi bi-table"></i> Lista de Empleados</h5>
            </div>
            <div class="card-body table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-dark text-center">
                        <tr>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                            <th>DPI</th>
                            <th>Género</th>
                            <th>Fecha Nacimiento</th>
                            <th>Puesto</th>
                            <th>Inicio Labores</th>
                            <th>Ingreso</th>
                        </tr>    
                    </thead>
                    <tbody id="tbl_empleados" class="text-center">
                        <%
                            Empleado empleado = new Empleado();
                            DefaultTableModel tabla = empleado.leer();
                            for(int t=0; t<tabla.getRowCount(); t++){
                                out.println("<tr data-id='"+tabla.getValueAt(t,0)+"' data-id_p='"+tabla.getValueAt(t,9)+"'>");
                                for (int c = 1; c < tabla.getColumnCount(); c++) {
                                    if (c != 9) { 
                                        out.println("<td>" + tabla.getValueAt(t, c) + "</td>");
                                    }
                                }
                                out.println("</tr>");
                            }
                        %> 
                    </tbody>
                </table>  
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

    <script>
      $('#tbl_empleados').on('click', 'tr', function() {
        let fila = $(this);
        $("#txt_id").val(fila.data('id'));
        $("#drop_puesto").val(fila.data('id_p'));
        $("#txt_nombres").val(fila.find("td:eq(0)").text());
        $("#txt_apellidos").val(fila.find("td:eq(1)").text());
        $("#txt_direccion").val(fila.find("td:eq(2)").text());
        $("#txt_telefono").val(fila.find("td:eq(3)").text());
        $("#txt_dpi").val(fila.find("td:eq(4)").text());
        let generoTexto = fila.find("td:eq(5)").text().trim().toLowerCase();
        if (generoTexto === "hombre" || generoTexto === "1" || generoTexto === "true") {
          $("#drop_genero").val("1");
        } else {
          $("#drop_genero").val("0");
        }
        $("#txt_fn").val(fila.find("td:eq(6)").text());
        $("#txt_fil").val(fila.find("td:eq(8)").text());
        let fechaIngreso = fila.find("td:eq(9)").text().trim();
        if (fechaIngreso.includes(" ")) fechaIngreso = fechaIngreso.split(" ")[0];
        $("#txt_fi").val(fechaIngreso);
      });
    </script>

</body>
</html>

