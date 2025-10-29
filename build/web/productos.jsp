<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Marca"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Producto"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Productos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body class="bg-dark text-white">
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">UMG</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item"><a class="nav-link active" href="index.html">Inicio</a></li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Menú</a>
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

<div class="container mt-4">
    <h1>Formulario Productos</h1>

    <!-- Formulario con soporte de archivo -->
    <form action="sr_producto" method="post" enctype="multipart/form-data" class="row g-3 needs-validation" novalidate>
        <div class="col-md-3">
            <label for="txt_id" class="form-label">ID</label>
            <input type="text" class="form-control" id="txt_id" name="txt_id" value="0" readonly>
        </div>

        <div class="col-md-4">
            <label for="txt_producto" class="form-label">Producto</label>
            <input type="text" class="form-control" id="txt_producto" name="txt_producto" placeholder="Ej: Laptop HP" required>
        </div>

        <div class="col-md-4">
            <label for="drop_marca" class="form-label">Marca</label>
            <select class="form-select" id="drop_marca" name="drop_marca" required>
                <option selected disabled value="">Elige marca</option>
                <%
                    Marca marca = new Marca();
                    HashMap<String, String> drop = marca.leer();
                    for(String i: drop.keySet()){
                        out.println("<option value='"+i+"'>"+drop.get(i)+"</option>");
                    }
                %>
            </select>
            <a href="marca.jsp" class="link-info small">Ir a mantenimiento de Marcas</a>
        </div>

        <div class="col-md-6">
            <label for="txt_descripcion" class="form-label">Descripción</label>
            <input type="text" class="form-control" id="txt_descripcion" name="txt_descripcion" placeholder="Ej: Laptop 15.6 pulgadas" required>
        </div>

        <div class="col-md-6">
            <label for="txt_imagen" class="form-label">Imagen</label>
            <input type="file" class="form-control" id="txt_imagen" name="txt_imagen" accept="image/*">
            <input type="hidden" id="ruta_imagen_actual" name="ruta_imagen_actual">
            <div class="mt-2">
                <img id="preview_imagen" src="" alt="Vista previa" width="150" class="border border-light rounded">
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

        <div class="col-12">
            <button class="btn btn-primary" name="btn_crear" value="crear"><i class="bi bi-floppy-fill"></i> Crear</button>
            <button class="btn btn-success" name="btn_actualizar" value="actualizar"><i class="bi bi-pencil"></i> Actualizar</button>
            <button class="btn btn-danger" name="btn_borrar" value="borrar"><i class="bi bi-trash3-fill"></i> Borrar</button>
        </div>
    </form>

    <hr>
    <h3>Listado de Productos</h3>

    <div class="table-responsive">
        <table class="table table-dark table-hover">
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
                        out.println("<td><img src='"+tabla.getValueAt(t,5)+"' width='80' height='80'></td>");
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