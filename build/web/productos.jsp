<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Marca"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Producto"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Productos - UMG</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

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

        .card {
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .table thead {
            background-color: #0d6efd;
            color: #fff;
        }

        .table tbody tr:hover {
            background-color: rgba(13, 110, 253, 0.1);
            cursor: pointer;
        }

        .form-label {
            font-weight: 600;
        }

        .btn {
            border-radius: 10px;
            padding: 8px 16px;
            font-weight: 500;
        }

        .table img {
            border-radius: 10px;
            border: 2px solid #eaeaea;
        }

        h1, h3 {
            font-weight: 700;
            color: #0d6efd;
        }

        hr {
            border: 1px solid #dcdcdc;
        }

        .btn i {
            margin-right: 5px;
        }

        /* Responsive ajustes */
        @media (max-width: 768px) {
            .card {
                padding: 15px;
            }
            
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
    <div class="card p-4 mb-5">
        <h1 class="mb-4 text-center"><i class="bi bi-box-seam"></i> Formulario de Productos</h1>

        <form action="sr_producto" method="post" enctype="multipart/form-data" class="row g-4 needs-validation" novalidate>
            <div class="col-md-3">
                <label for="txt_id" class="form-label">ID</label>
                <input type="text" class="form-control" id="txt_id" name="txt_id" value="0" readonly>
            </div>

            <div class="col-md-4">
                <label for="txt_producto" class="form-label">Producto</label>
                <input type="text" class="form-control" id="txt_producto" name="txt_producto" placeholder="Ej: Laptop HP" required>
            </div>

            <div class="col-md-5">
                <label for="drop_marca" class="form-label">Marca</label>
                <select class="form-select" id="drop_marca" name="drop_marca" required>
                    <option selected disabled value="">Selecciona una marca</option>
                    <%
                        Marca marca = new Marca();
                        HashMap<String, String> drop = marca.leer();
                        for(String i: drop.keySet()){
                            out.println("<option value='"+i+"'>"+drop.get(i)+"</option>");
                        }
                    %>
                </select>
            </div>

            <div class="col-md-6">
                <label for="txt_descripcion" class="form-label">Descripción</label>
                <input type="text" class="form-control" id="txt_descripcion" name="txt_descripcion" placeholder="Ej: Laptop 15.6 pulgadas" required>
            </div>

            <div class="col-md-6">
                <label for="txt_imagen" class="form-label">Imagen</label>
                <input type="file" class="form-control" id="txt_imagen" name="txt_imagen" accept="image/*">
                <input type="hidden" id="ruta_imagen_actual" name="ruta_imagen_actual">
                <div class="mt-2 text-center">
                    <img id="preview_imagen" src="" alt="Vista previa" width="150" class="border rounded shadow-sm">
                </div>
            </div>

            <div class="col-md-3">
                <label for="txt_precio_costo" class="form-label">Precio Costo</label>
                <input type="number" step="0.01" class="form-control" id="txt_precio_costo" name="txt_precio_costo" required>
            </div>

            <div class="col-md-3">
                <label for="txt_precio_venta" class="form-label">Precio Venta</label>
                <input type="number" step="0.01" class="form-control" id="txt_precio_venta" name="txt_precio_venta" required>
            </div>

            <div class="col-md-3">
                <label for="txt_existencia" class="form-label">Existencia</label>
                <input type="number" class="form-control" id="txt_existencia" name="txt_existencia" required>
            </div>

            <div class="col-md-3">
                <label for="txt_fi" class="form-label">Fecha Ingreso</label>
                <input type="date" class="form-control" id="txt_fi" name="txt_fi" required>
            </div>

            <div class="col-12 text-center mt-3">
                <button class="btn btn-primary me-2" name="btn_crear" value="crear"><i class="bi bi-floppy-fill"></i> Crear</button>
                <button class="btn btn-success me-2" name="btn_actualizar" value="actualizar"><i class="bi bi-pencil"></i> Actualizar</button>
                <button class="btn btn-danger" name="btn_borrar" value="borrar"><i class="bi bi-trash3-fill"></i> Borrar</button>
                
                <a href="marca.jsp" class="btn btn-sm btn-info text-white">
                    <i class="bi bi-tags-fill"></i> Marcas
                </a>
            </div>
  
        </form>
    </div>

    <div class="card p-4">
        <h3 class="mb-4"><i class="bi bi-table"></i> Listado de Productos</h3>

        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Producto</th>
                        <th>Marca</th>
                        <th>Descripción</th>
                        <th>Imagen</th>
                        <th>Precio Costo</th>
                        <th>Precio Venta</th>
                        <th>Existencia</th>
                        <th>Ingreso</th>
                    </tr>
                </thead>
                <tbody id="tbl_productos">
                    <%
                        Producto producto = new Producto();
                        DefaultTableModel tabla = producto.leerpr();
                        for(int t=0; t<tabla.getRowCount(); t++){
                            out.println("<tr data-id='"+tabla.getValueAt(t,0)+"' data-id_m='"+tabla.getValueAt(t,3)+"'>");
                            out.println("<td>"+tabla.getValueAt(t,0)+"</td>");
                            out.println("<td>"+tabla.getValueAt(t,1)+"</td>");
                            out.println("<td>"+tabla.getValueAt(t,2)+"</td>");
                            out.println("<td>"+tabla.getValueAt(t,4)+"</td>");
                            out.println("<td><img src='"+tabla.getValueAt(t,5)+"' width='70' height='70'></td>");
                            out.println("<td>"+tabla.getValueAt(t,6)+"</td>");
                            out.println("<td>"+tabla.getValueAt(t,7)+"</td>");
                            out.println("<td>"+tabla.getValueAt(t,8)+"</td>");
                            out.println("<td>"+tabla.getValueAt(t,9)+"</td>");
                            out.println("</tr>");
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
$('#tbl_productos').on('click', 'tr', function() {
    let fila = $(this);
    $("#txt_id").val(fila.data('id'));
    $("#drop_marca").val(fila.data('id_m'));
    $("#txt_producto").val(fila.find("td:eq(1)").text());
    $("#txt_descripcion").val(fila.find("td:eq(3)").text());
    $("#txt_precio_costo").val(fila.find("td:eq(5)").text());
    $("#txt_precio_venta").val(fila.find("td:eq(6)").text());
    $("#txt_existencia").val(fila.find("td:eq(7)").text());

    let fecha = fila.find("td:eq(8)").text().trim();
    if (fecha.includes(" ")) {
        fecha = fecha.split(" ")[0];
    }
    $("#txt_fi").val(fecha);

    const imgSrc = fila.find("img").attr("src");
    $("#preview_imagen").attr("src", imgSrc);
    $("#ruta_imagen_actual").val(imgSrc);
});
</script>

</body>
</html>