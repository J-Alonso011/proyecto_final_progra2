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
        body {
            background-color: #121212;
            color: #e0e0e0;
        }
        .navbar {
            background: linear-gradient(90deg, #3c3b3f, #605c3c);
        }
        .navbar-brand {
            font-weight: bold;
            letter-spacing: 1px;
        }
        .card {
            background-color: #1e1e1e;
            border: 1px solid #2e2e2e;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(255, 215, 0, 0.1);
        }
        .card-header {
            background: linear-gradient(90deg, #d4af37, #b8860b);
            color: black;
            font-weight: bold;
            border-radius: 15px 15px 0 0;
        }
        .btn-primary {
            background-color: #d4af37;
            border: none;
            color: black;
            font-weight: bold;
        }
        .btn-primary:hover {
            background-color: #e0c25b;
            color: black;
        }
        .btn-success {
            background-color: #28a745;
            border: none;
        }
        .btn-danger {
            background-color: #c0392b;
            border: none;
        }
        .btn-secondary {
            background-color: #444;
            border: none;
        }
        .table-dark {
            border-radius: 10px;
            overflow: hidden;
        }
        h1 {
            color: #d4af37;
            font-weight: bold;
            text-shadow: 0px 0px 8px rgba(212,175,55,0.6);
        }
        h4 {
            color: #f1c40f;
            margin-top: 20px;
        }
        img.preview {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 10px;
            border: 1px solid #555;
        }
        .selected {
            background-color: #d4af37 !important;
            color: black !important;
            font-weight: bold;
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark shadow">
  <div class="container-fluid">
    <a class="navbar-brand" href="#"><i class="bi bi-building"></i> UMG Compras</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link active" href="index.jsp"><i class="bi bi-house-door"></i> Inicio</a></li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"><i class="bi bi-grid"></i> Menú</a>
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
<div class="container mt-5 mb-5">
    <h1 class="text-center mb-4"><i class="bi bi-basket"></i> Mantenimiento de Compras</h1>

    <div class="card p-4 mb-5">
        <div class="card-header text-center">
            <i class="bi bi-pencil-square"></i> Formulario de Compra
        </div>
        <div class="card-body">
            <!-- FORMULARIO -->
            <form action="sr_compras" method="post" class="row g-3 bg-dark p-4 rounded shadow-sm border border-secondary">
    <div class="col-md-3">
        <label for="txt_id" class="form-label text-white fw-semibold">ID</label>
        <input type="text" class="form-control bg-secondary text-white border-0" id="txt_id" name="txt_id" value="0" readonly>
    </div>

    <div class="col-md-3">
        <label for="txt_no_orden" class="form-label text-white fw-semibold">No. Orden Compra</label>
        <input type="number" class="form-control bg-secondary text-white border-0" id="txt_no_orden" name="txt_no_orden" required>
    </div>

    <div class="col-md-3">
        <label for="drop_proveedor" class="form-label text-white fw-semibold">Proveedor</label>
        <select class="form-select bg-secondary text-white border-0" id="drop_proveedor" name="drop_proveedor" required>
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
        <label for="txt_fecha_orden" class="form-label text-white fw-semibold">Fecha Orden</label>
        <input type="date" class="form-control bg-secondary text-white border-0" id="txt_fecha_orden" name="txt_fecha_orden" required>
    </div>

    <div class="col-md-3">
        <label for="txt_fecha_ingreso" class="form-label text-white fw-semibold">Fecha Ingreso</label>
        <input type="datetime-local" class="form-control bg-secondary text-white border-0" id="txt_fecha_ingreso" name="txt_fecha_ingreso" required>
    </div>

                <!-- DETALLE -->
                <div class="col-12 mt-4">
                    <h4><i class="bi bi-box-seam"></i> Detalle de Productos</h4>
                    <div class="table-responsive">
                        <table class="table table-dark table-striped align-middle mt-3" id="detalle_table">
                            <thead class="table-warning text-dark">
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
                    </div>
                    <button type="button" class="btn btn-secondary mt-2" id="btn_agregar">
                        <i class="bi bi-plus-circle"></i> Agregar Producto
                    </button>
                </div>

                <div class="col-md-12 text-center mt-4">
                    <button class="btn btn-primary me-2" name="btn_crear" value="crear"><i class="bi bi-floppy-fill"></i> Crear</button>
                    <button class="btn btn-success me-2" name="btn_actualizar" value="actualizar"><i class="bi bi-pencil"></i> Actualizar</button>
                    <button class="btn btn-danger" name="btn_borrar" value="borrar"><i class="bi bi-trash3-fill"></i> Borrar</button>
                </div>
            </form>
        </div>
    </div>

    <!-- TABLA DE HISTORIAL -->
    <div class="card">
        <div class="card-header text-center">
            <i class="bi bi-clock-history"></i> Historial de Compras
        </div>
        <div class="card-body">
            <table class="table table-dark table-striped" id="tabla_compras">
                <thead class="table-warning text-dark">
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
    </div>
</div>

<!-- SCRIPTS -->
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
            <td><button type="button" class="btn btn-danger btn-sm btn_eliminar"><i class="bi bi-x-circle"></i></button></td>
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
        if (e.target.closest(".btn_eliminar")) {
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
