package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import modelo.Conexion;
import modelo.Ventas;
import modelo.Ventas_detalle;
import modelo.Producto;

@WebServlet(name = "sr_ventas", urlPatterns = {"/sr_ventas"})
public class sr_ventas extends HttpServlet {

    Ventas venta;
    Ventas_detalle detalle;
    Producto producto;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        process(request, response);
    }

    private void process(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int id = (request.getParameter("txt_id") != null && !request.getParameter("txt_id").equals(""))
                    ? Integer.parseInt(request.getParameter("txt_id")) : 0;

            int no_factura     = Integer.parseInt(request.getParameter("txt_no_factura"));
            String serie       = request.getParameter("txt_serie");
            String fecha_fact  = request.getParameter("txt_fecha_factura");
            String fecha_ing   = request.getParameter("txt_fecha_ingreso");
            int id_cliente     = Integer.parseInt(request.getParameter("drop_cliente"));
            int id_empleado    = Integer.parseInt(request.getParameter("drop_empleado"));

            venta = new Ventas(fecha_fact, fecha_ing, id, no_factura, id_cliente, id_empleado, serie);

            
            if ("crear".equals(request.getParameter("btn_crear"))) {
                if (venta.crear() > 0) {
                   
                    Conexion cn = new Conexion();
                    cn.abrir_conexion();
                    int id_venta = 0;
                    ResultSet rs = cn.conexionBD.createStatement().executeQuery("SELECT MAX(id_venta) AS id FROM ventas;");
                    if (rs.next()) id_venta = rs.getInt("id");
                    cn.cerrar_conexion();

             
                    String[] productos = request.getParameterValues("idproducto[]");
                    String[] cantidades = request.getParameterValues("cantidad[]");
                   
                    if (productos != null) {
                        for (int i = 0; i < productos.length; i++) {
                            int idp = Integer.parseInt(productos[i]);
                            int qty = Integer.parseInt(cantidades[i]);

                          
                            double precio_unitario = obtenerPrecioVenta(idp);

                            detalle = new Ventas_detalle(0, id_venta, idp, qty, precio_unitario);
                            detalle.crear();

                       
                            producto = new Producto();
                            producto.disminuirStock(idp, qty);
                        }
                    }

                    response.sendRedirect("Ventas.jsp");
                } else {
                    out.println("<p>No se realizó la operación de crear.</p>");
                }
            }

            
            if ("actualizar".equals(request.getParameter("btn_actualizar"))) {
                if (venta.actualizar() > 0) {
                    response.sendRedirect("Ventas.jsp");
                } else {
                    out.println("<p>No se realizó la operación de actualizar.</p>");
                }
            }

            
            if ("borrar".equals(request.getParameter("btn_borrar"))) {
                if (venta.borrar() > 0) {
                    response.sendRedirect("Ventas.jsp");
                } else {
                    out.println("<p>No se realizó la operación de borrar.</p>");
                }
            }
        } catch (Exception e) {
            response.getWriter().println("Error en sr_ventas: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private double obtenerPrecioVenta(int id_producto) {
        double pv = 0.0;
        try {
            Conexion cn = new Conexion();
            cn.abrir_conexion();
            PreparedStatement ps = cn.conexionBD.prepareStatement(
                "SELECT precio_venta FROM productos WHERE id_producto = ?"
            );
            ps.setInt(1, id_producto);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) pv = rs.getDouble(1);
            cn.cerrar_conexion();
        } catch (Exception e) {
            System.out.println("Error al obtener precio_venta: " + e.getMessage());
        }
        return pv;
    }

    @Override
    public String getServletInfo() {
        return "Servlet maestro-detalle para Ventas";
    }
}
