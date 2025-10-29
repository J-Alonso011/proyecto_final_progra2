<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Compras"%>
<%@page import="modelo.Proveedores"%>
<%@page import="modelo.Producto"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mantenimiento de Compras</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body { background-color: #1e1e1e; color: white; }
        .selected { background-color: #0d6efd !important; }
        h3 { color: #ffffff; margin-top: 30px; }
        img.preview { width: 70px; height: 70px; object-fit: cover; border-radius: 10px; margin-left: 10px; }
    </style>
</head>
<body class="bg-dark text-white">

<!-- NAVBAR -->
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
    <h1 class="text-center mb-4">Mantenimiento de Compras</h1>

    <!-- FORMULARIO MAESTRO -->
    <form action="sr_compras" method="post" class="row g-3">
        <div class="col-md-3">
            <label for="txt_id" class="form-label">ID</label>
            <input type="text" class="form-control" id="txt_id" name="txt_id" value="0" readonly>
        </div>

        <div class="col-md-3">
            <label for="txt_no_orden" class="form-label">No. Orden Compra</label>
            <input type="number" class="form-control" id="txt_no_orden" name="txt_no_orden" required>
        </div>

        <div class="col-md-3">
            <label for="drop_proveedor" class="form-label">Proveedor</label>
            <select class="form-select" id="drop_proveedor" name="drop_proveedor" required>
                <option selected disabled value="">Seleccione un proveedor</option>
                <%
                    Proveedores prov = new Proveedores();
                    HashMap<String, String> dropProv = prov.leer();
                    for(String id : dropProv.keySet()){
                        out.println("<option value='"+id+"'>"+dropProv.get(id)+"</option>");
                    }
                %>
            </select>
        </div>

        <div class="col-md-3">
            <label for="txt_fecha_orden" class="form-label">Fecha Orden</label>
            <input type="date" class="form-control" id="txt_fecha_orden" name="txt_fecha_orden" required>
        </div>

        <div class="col-md-3">
            <label for="txt_fecha_ingreso" class="form-label">Fecha Ingreso</label>
            <input type="datetime-local" class="form-control" id="txt_fecha_ingreso" name="txt_fecha_ingreso" required>
        </div>

        <!-- DETALLE -->
        <div class="col-12 mt-4">
            <h4><b>Detalle de Productos</b></h4>
            <table class="table table-dark table-striped align-middle" id="detalle_table">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Imagen</th>
                        <th>Cantidad</th>
                        <th>Precio Costo</th>
                        <th>Subtotal</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
            <button type="button" class="btn btn-secondary" id="btn_agregar">+ Agregar Producto</button>
        </div>

        <div class="col-md-12 text-center mt-3">
            <button class="btn btn-primary" name="btn_crear" value="crear"><i class="bi bi-floppy-fill"></i> Crear</button>
            <button class="btn btn-success" name="btn_actualizar" value="actualizar"><i class="bi bi-pencil"></i> Actualizar</button>
            <button class="btn btn-danger" name="btn_borrar" value="borrar"><i class="bi bi-trash3-fill"></i> Borrar</button>
        </div>
    </form>

   
    <h3>Historial de Compras</h3>
    <table class="table table-dark table-striped" id="tabla_compras">
        <thead>
            <tr>
                <th>ID</th>
                <th>No. Orden</th>
                <th>Proveedor</th>
                <th>Fecha Orden</th>
                <th>Fecha Ingreso</th>
            </tr>
        </thead>
        <tbody>
            <%
                Compras compra = new Compras();
                DefaultTableModel tabla = compra.leer();
                for (int i = 0; i < tabla.getRowCount(); i++) {
                    out.println("<tr data-id='"+tabla.getValueAt(i, 0)+"' data-proveedor='"+tabla.getValueAt(i, 2)+"'>");
                    out.println("<td>" + tabla.getValueAt(i, 0) + "</td>");
                    out.println("<td>" + tabla.getValueAt(i, 1) + "</td>");
                    out.println("<td>" + tabla.getValueAt(i, 2) + "</td>");
                    out.println("<td>" + tabla.getValueAt(i, 3) + "</td>");
                    out.println("<td>" + tabla.getValueAt(i, 4) + "</td>");
                    out.println("</tr>");
                }
            %>
        </tbody>
    </table>
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script>
    
    document.getElementById("btn_agregar").addEventListener("click", function() {
        const tbody = document.querySelector("#detalle_table tbody");
        const fila = document.createElement("tr");
        fila.innerHTML = `
            <td>
                <select class="form-select producto-select" name="idproducto[]" required>
                    <option disabled selected>Seleccione</option>
                    <% 
                        Producto p = new Producto();
                        DefaultTableModel prodTable = p.leerpr();
                        for (int i = 0; i < prodTable.getRowCount(); i++) {
                            out.println("<option value='"+prodTable.getValueAt(i,0)+"' data-img='"+prodTable.getValueAt(i,5)+"'>"+prodTable.getValueAt(i,1)+"</option>");
                        }
                    %>
                </select>
            </td>
            <td><img src="" class="preview" alt="Sin imagen"></td>
            <td><input type="number" name="cantidad[]" class="form-control cantidad" min="1" value="1" required></td>
            <td><input type="number" step="0.01" name="precio_costo_unitario[]" class="form-control precio" required></td>
            <td><input type="text" class="form-control subtotal" readonly></td>
            <td><button type="button" class="btn btn-danger btn-sm btn_eliminar">Eliminar</button></td>
        `;
        tbody.appendChild(fila);
    });

   
    document.addEventListener("change", function(e) {
        if (e.target.classList.contains("producto-select")) {
            const imgSrc = e.target.selectedOptions[0].dataset.img;
            const fila = e.target.closest("tr");
            fila.querySelector("img").src = imgSrc;
        }
    });

    
    document.addEventListener("input", function(e) {
        if (e.target.classList.contains("cantidad") || e.target.classList.contains("precio")) {
            const fila = e.target.closest("tr");
            const cantidad = parseFloat(fila.querySelector(".cantidad").value) || 0;
            const precio = parseFloat(fila.querySelector(".precio").value) || 0;
            fila.querySelector(".subtotal").value = (cantidad * precio).toFixed(2);
        }
    });

   
    document.addEventListener("click", function(e) {
        if (e.target.classList.contains("btn_eliminar")) {
            e.target.closest("tr").remove();
        }
    });

    
    document.addEventListener("DOMContentLoaded", function() {
        const tabla = document.querySelector("#tabla_compras");
        tabla.addEventListener("click", function(e) {
            const fila = e.target.closest("tr");
            if (!fila) return;

            tabla.querySelectorAll("tr").forEach(tr => tr.classList.remove("selected"));
            fila.classList.add("selected");

            document.getElementById("txt_id").value = fila.dataset.id;
            document.getElementById("txt_no_orden").value = fila.cells[1].textContent.trim();
            document.getElementById("drop_proveedor").value = fila.dataset.proveedor;
            document.getElementById("txt_fecha_orden").value = fila.cells[3].textContent.trim();
            document.getElementById("txt_fecha_ingreso").value = fila.cells[4].textContent.trim();
        });
    });
</script>

</body>
</html>