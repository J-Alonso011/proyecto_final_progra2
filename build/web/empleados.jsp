<%-- 
    Document   : empleados
    Created on : 23/10/2025, 9:03:09 p. m.
    Author     : alons
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.Puesto"%>
<%@page import="java.util.HashMap"%>
<%@page import="modelo.Empleado"%>
<%@page import="javax.swing.table.DefaultTableModel"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    </head>
    <body class="bg-dark text-white">
   <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">UMG</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="index.html">Inicio</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Menu
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
        <h1>Formulario empleados</h1>
          <div class="container">
          <form action="sr_empleado" method="post" class= "row g-3 needs-validation" novalidate>
           <div class="col-md-6">
          <label for="lbl_id" class="form-label">ID</label>
          <input type="text" class="form-control" id="txt_id" name="txt_id" placeholder="Ej: ID:0" value="0" readonly>
           </div>
          <div class="col-md-4">  
          <label for="lbl_nombres" class="form-label">Nombres</label>
          <input type="text" class="form-control" id="txt_nombres" name="txt_nombres" placeholder="Ej: nombre1 nombre2" required>
          </div>
          <div class="col-md-4"> 
          <label for="lbl_apellidos" class="form-label">Apellidos</label>
          <input type="text" class="form-control" id="txt_apellidos" name="txt_apellidos" placeholder="Ej: apellido1 apellido2" required>
          </div>
          <div class="col-md-4">     
          <label for="lbl_direccion" class="form-label">Direccion</label>
          <input type="text" class="form-control" id="txt_direccion" name="txt_direccion" placeholder="Ej: 13 calle a" required>
          </div>
          <div class="col-md-4">  
          <label for="lbl_telefono" class="form-label">Telefono</label>
          <input type="number" class="form-control" id="txt_telefono" name="txt_telefono" placeholder="Ej: 58616902" required>
          </div>
           <div class="col-md-4">  
          <label for="lbl_dpi" class="form-label">DPI</label>
          <input type="text" class="form-control" id="txt_dpi" name="txt_dpi" placeholder="Ej: 3605105820101" required>
          </div>   
          
              
          <div class="col-md-4">
          <label for="drop_genero" class="form-label">Género</label>
          <select class="form-select" id="drop_genero" name="drop_genero" required>
          <option selected disabled value="">Seleccione género</option>
          <option value="1">Hombre</option>
          <option value="0">Mujer</option>
          </select>
          </div> 
              
              
          <div class="col-md-4"> 
          <label for="lbl_fn" class="form-label">Fecha Nacimiento</label>
          <input type="date" class="form-control" id="txt_fn" name="txt_fn" placeholder="Ej: yyyy-mm-dd" required>
          </div>
          <div class="col-md-4"> 
          <label for="lbl_puesto" class="form-label">Puesto</label>
          <select class="form-select" aria-label="Default select example" id="drop_puesto" name="drop_puesto" required>
          <option selected disabled value="">Elige puesto</option>
          <% Puesto puesto = new Puesto();
          HashMap<String,String> drop = puesto.leer();
          for(String i: drop.keySet()){
              out.println("<option value='"+i+"'>"+drop.get(i)+ "</option>");
              }
          %>
          </select>
          </div>
          <div class="col-md-4"> 
          <label for="lbl_fil" class="form-label">Fecha Inicio labores</label>
          <input type="date" class="form-control" id="txt_fil" name="txt_fil" placeholder="Ej: yyyy-mm-dd" required>
          </div>
          <div class="col-md-4"> 
          <label for="lbl_fi" class="form-label">Fecha Ingreso</label>
          <input type="date" class="form-control" id="txt_fi" name="txt_fi" placeholder="Ej: yyyy-mm-dd" required>
          </div>
          </br>
          <div class="col-md-4">
          <button class="btn btn-primary" id="btn_crear" name="btn_crear" value="crear"><i class="bi bi-floppy-fill"></i>    Crear</button>
          <button class="btn btn-success" id="btn_actualizar" name="btn_actualizar" value="actualizar"><i class="bi bi-pencil"></i>Actualizar</button>
          <button class="btn btn-danger" id="btn_borrar" name="btn_borrar" value="borrar"><i class="bi bi-trash3-fill"></i>Borrar</button>
         </div>
          </form>
              <div class="table-responsive">
                <table class="table table-hover table-dark">
                    <thead>
                        <tr>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Direccion</th>
                            <th>Telefono</th>
                            <th>Dpi</th>
                            <th>Genero</th>
                            <th>Fecha nacimiento</th>
                            <th>Puesto</th>
                            <th>Inicio labores</th>
                            <th>Ingreso</th>
                        </tr>    
                    </thead>
                    <tbody id="tbl_empleados">
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
        <script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
        
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
    
    // Detectar género según texto visible
    let generoTexto = fila.find("td:eq(5)").text().trim().toLowerCase();
    if (generoTexto === "hombre" || generoTexto === "1" || generoTexto === "true") {
      $("#drop_genero").val("1");
    } else {
      $("#drop_genero").val("0");
    }

    $("#txt_fn").val(fila.find("td:eq(6)").text());
    $("#txt_fil").val(fila.find("td:eq(8)").text());
    let fechaIngreso = fila.find("td:eq(9)").text().trim();
  if (fechaIngreso.includes(" ")) {
    fechaIngreso = fechaIngreso.split(" ")[0];
  }
  $("#txt_fi").val(fechaIngreso);
  });
</script>
    </body>
</html>
