<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Cliente"%>
<%@page import="modelo.Empleado"%>
<%@page import="modelo.Producto"%>
<%@page import="modelo.Ventas"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Mantenimiento de Ventas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body { background-color: #1e1e1e; color: white; }
        .selected { background-color: #0d6efd !important; }
        h3 { color: #ffffff; margin-top: 30px; }
    </style>
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
    <h1 class="text-center mb-4">Mantenimiento de Ventas</h1>

   
    <form action="sr_ventas" method="post" class="row g-3">
        <div class="col-md-2">
            <label for="txt_id" class="form-label">ID</label>
            <input type="text" class="form-control" id="txt_id" name="txt_id" value="0" readonly>
        </div>

        <div class="col-md-2">
            <label for="txt_no_factura" class="form-label">No. Factura</label>
            <input type="number" class="form-control" id="txt_no_factura" name="txt_no_factura" required>
        </div>

        <div class="col-md-2">
            <label for="txt_serie" class="form-label">Serie</label>
            <input type="text" class="form-control" id="txt_serie" name="txt_serie" maxlength="1" required>
        </div>

        <div class="col-md-3">
            <label for="txt_fecha_factura" class="form-label">Fecha Factura</label>
            <input type="date" class="form-control" id="txt_fecha_factura" name="txt_fecha_factura" required>
        </div>

        <div class="col-md-3">
            <label for="txt_fecha_ingreso" class="form-label">Fecha Ingreso</label>
            <input type="datetime-local" class="form-control" id="txt_fecha_ingreso" name="txt_fecha_ingreso" required>
        </div>

        <div class="col-md-6">
            <label for="drop_cliente" class="form-label">Cliente</label>
            <select class="form-select" id="drop_cliente" name="drop_cliente" required>
                <option selected disabled value="">Seleccione cliente</option>
                <%
                    Cliente cli = new Cliente();
                    HashMap<String, String> dropCli = cli.leerCombo();
                    for(String id : dropCli.keySet()){
                        out.println("<option value='"+id+"'>"+dropCli.get(id)+"</option>");
                    }
                %>
            </select>
            <a href="clientes.jsp" class="btn btn-link text-white">Ir a mantenimiento de Clientes</a>
        </div>

        <div class="col-md-6">
            <label for="drop_empleado" class="form-label">Empleado</label>
            <select class="form-select" id="drop_empleado" name="drop_empleado" required>
                <option selected disabled value="">Seleccione empleado</option>
                <%
                    Empleado emp = new Empleado();
                    HashMap<String, String> dropEmp = emp.leerCombo();
                    for(String id : dropEmp.keySet()){
                        out.println("<option value='"+id+"'>"+dropEmp.get(id)+"</option>");
                    }
                %>
            </select>
            <a href="empleados.jsp" class="btn btn-link text-white">Ir a mantenimiento de Empleados</a>
        </div>

       
        <div class="col-12 mt-4">
            <h4><b>Detalle de Productos</b></h4>
            <table class="table table-dark table-striped" id="detalle_table">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Precio Unitario</th>
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

   
    <h3>Historial de Ventas</h3>
    <table class="table table-dark table-striped" id="tabla_ventas">
        <thead>
            <tr>
                <th>ID</th>
                <th>No. Factura</th>
                <th>Serie</th>
                <th>Cliente</th>
                <th>Empleado</th>
                <th>Fecha Factura</th>
                <th>Fecha Ingreso</th>
            </tr>
        </thead>
        <tbody>
            <%
                Ventas venta = new Ventas();
                DefaultTableModel tabla = venta.leer();
                for (int i = 0; i < tabla.getRowCount(); i++) {
                    out.println("<tr>");
                    for (int j = 0; j < tabla.getColumnCount(); j++) {
                        out.println("<td>" + tabla.getValueAt(i, j) + "</td>");
                    }
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
                <select class="form-select" name="idproducto[]" required>
                    <option disabled selected>Seleccione</option>
                    <% 
                        Producto p = new Producto();
                        DefaultTableModel tablaProd = p.leerpr();
                        for (int i = 0; i < tablaProd.getRowCount(); i++) {
                            String id = tablaProd.getValueAt(i, 0).toString();
                            String nombre = tablaProd.getValueAt(i, 1).toString();
                            String imagen = tablaProd.getValueAt(i, 5).toString(); 
                            out.println("<option value='" + id + "' data-img='" + imagen + "'>" + nombre + "</option>");
                        }
                    %>
                </select>
                <img src="" class="img-thumbnail mt-2" style="width: 70px; height: 70px; display: none;">
            </td>
            <td><input type="number" name="cantidad[]" class="form-control cantidad" min="1" value="1" required></td>
            <td><input type="number" step="0.01" name="precio_unitario[]" class="form-control precio" required></td>
            <td><input type="text" class="form-control subtotal" readonly></td>
            <td><button type="button" class="btn btn-danger btn-sm btn_eliminar">Eliminar</button></td>
        `;
        tbody.appendChild(fila);
    });

    
    document.addEventListener("change", function(e) {
      if (e.target && e.target.matches("select[name='idproducto[]']")) {
        const select = e.target;
        const selected = select.options[select.selectedIndex];
        const imgSrc = selected.getAttribute("data-img");
        const imgPreview = select.parentElement.querySelector("img");

        if (imgSrc) {
          imgPreview.src = imgSrc;
          imgPreview.style.display = "block";
        } else {
          imgPreview.style.display = "none";
        }
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
        const tabla = document.querySelector("#tabla_ventas");
        tabla.addEventListener("click", function(e) {
            const fila = e.target.closest("tr");
            if (!fila) return;

            tabla.querySelectorAll("tr").forEach(tr => tr.classList.remove("selected"));
            fila.classList.add("selected");

            const celdas = fila.querySelectorAll("td");
            document.getElementById("txt_id").value = celdas[0].textContent.trim();
            document.getElementById("txt_no_factura").value = celdas[1].textContent.trim();
            document.getElementById("txt_serie").value = celdas[2].textContent.trim();
            document.getElementById("drop_cliente").value = celdas[3].textContent.trim();
            document.getElementById("drop_empleado").value = celdas[4].textContent.trim();
            document.getElementById("txt_fecha_factura").value = celdas[5].textContent.trim();
            document.getElementById("txt_fecha_ingreso").value = celdas[6].textContent.trim();
        });
    });
</script>

</body>
</html>