/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import modelo.Compras;
import modelo.Compras_detalle;
import modelo.Conexion;
import modelo.Producto;

/**
 *
 * @author alons
 */
@WebServlet(name = "sr_compras", urlPatterns = {"/sr_compras"})
public class sr_compras extends HttpServlet {

    Compras compra;
    Compras_detalle detalle;
    Producto producto;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            // Datos principales de la compra
            int id = (request.getParameter("txt_id") != null && !request.getParameter("txt_id").equals(""))
                    ? Integer.parseInt(request.getParameter("txt_id")) : 0;

            int no_orden = Integer.parseInt(request.getParameter("txt_no_orden"));
            int id_proveedor = Integer.parseInt(request.getParameter("drop_proveedor"));
            String fecha_orden = request.getParameter("txt_fecha_orden");
            String fecha_ingreso = request.getParameter("txt_fecha_ingreso");

          
            compra = new Compras(fecha_orden, fecha_ingreso, id, no_orden, id_proveedor);

          
            if ("crear".equals(request.getParameter("btn_crear"))) {
                if (compra.crear() > 0) {
                  
                    Conexion cn = new Conexion();
                    cn.abrir_conexion();
                    int id_compra = 0;
                    String query = "SELECT MAX(id_compra) AS id FROM compras;";
                    ResultSet rs = cn.conexionBD.createStatement().executeQuery(query);
                    if (rs.next()) {
                        id_compra = rs.getInt("id");
                    }
                    cn.cerrar_conexion();

                 
                    String[] productos = request.getParameterValues("idproducto[]");
                    String[] cantidades = request.getParameterValues("cantidad[]");
                    String[] precios = request.getParameterValues("precio_costo_unitario[]");

                    if (productos != null) {
                        for (int i = 0; i < productos.length; i++) {
                            detalle = new Compras_detalle(
                                    0,
                                    id_compra,
                                    Integer.parseInt(productos[i]),
                                    Integer.parseInt(cantidades[i]),
                                    Double.parseDouble(precios[i])
                            );
                            detalle.crear();

                           
                            producto = new Producto();
                            producto.actualizarStockYPrecio(
                                    detalle.getId_producto(),
                                    detalle.getCantidad(),
                                    detalle.getPrecio_costo_unitario()
                            );
                        }
                    }

                   
                    response.sendRedirect("Compras.jsp");

                } else {
                    out.println("<p>No se realizó la operación de crear.</p>");
                }
            }

          
            if ("actualizar".equals(request.getParameter("btn_actualizar"))) {
                if (compra.actualizar() > 0) {
                    response.sendRedirect("Compras.jsp");
                } else {
                    out.println("<p>No se realizó la operación de actualizar.</p>");
                }
            }

     
            if ("borrar".equals(request.getParameter("btn_borrar"))) {
                if (compra.borrar() > 0) {
                    response.sendRedirect("Compras.jsp");
                } else {
                    out.println("<p>No se realizó la operación de borrar.</p>");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<p>Error en el servlet: " + e.getMessage() + "</p>");
        }
    }

  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para manejo maestro-detalle de compras";
    }
}