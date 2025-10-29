package controlador;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import modelo.Producto;

@WebServlet(name = "sr_producto", urlPatterns = {"/sr_producto"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2 MB
        maxFileSize = 1024 * 1024 * 10,              // 10 MB
        maxRequestSize = 1024 * 1024 * 50)           // 50 MB
public class sr_producto extends HttpServlet {

    Producto producto1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int id = 0;
            String sid = request.getParameter("txt_id");
            if (sid != null && !sid.isEmpty()) {
                try {
                    id = Integer.parseInt(sid);
                } catch (NumberFormatException e) {
                    id = 0;
                }
            }

            String producto = request.getParameter("txt_producto");
            int id_marca = Integer.parseInt(request.getParameter("drop_marca"));
            String descripcion = request.getParameter("txt_descripcion");
            double precio_costo = Double.parseDouble(request.getParameter("txt_precio_costo"));
            double precio_venta = Double.parseDouble(request.getParameter("txt_precio_venta"));
            int existencia = Integer.parseInt(request.getParameter("txt_existencia"));
            String fecha_ingreso = request.getParameter("txt_fi");

            // ====== PROCESAR IMAGEN ======
            Part filePart = request.getPart("txt_imagen");
            String nombreArchivo = "";
            String rutaServidor = getServletContext().getRealPath("") + File.separator + "img";

            File carpeta = new File(rutaServidor);
            if (!carpeta.exists()) {
                carpeta.mkdir();
            }

            if (filePart != null && filePart.getSize() > 0) {
                nombreArchivo = new File(filePart.getSubmittedFileName()).getName();
                filePart.write(rutaServidor + File.separator + nombreArchivo);
            }

            // Ruta relativa para guardar en la BD
            String rutaBD = (nombreArchivo.isEmpty()) ? request.getParameter("ruta_imagen_actual") : "img/" + nombreArchivo;

            producto1 = new Producto(
                    producto,
                    descripcion,
                    rutaBD,
                    fecha_ingreso,
                    id,
                    id_marca,
                    existencia,
                    precio_costo,
                    precio_venta
            );

            if ("crear".equals(request.getParameter("btn_crear"))) {
                if (producto1.crear() > 0) {
                    response.sendRedirect("productos.jsp");
                } else {
                    out.println("<p>No se realizó la operación de creación</p>");
                }
            }

            if ("actualizar".equals(request.getParameter("btn_actualizar"))) {
                if (producto1.actualizar() > 0) {
                    response.sendRedirect("productos.jsp");
                } else {
                    out.println("<p>No se realizó la operación de actualización</p>");
                }
            }

            if ("borrar".equals(request.getParameter("btn_borrar"))) {
                if (producto1.borrar() > 0) {
                    response.sendRedirect("productos.jsp");
                } else {
                    out.println("<p>No se realizó la operación de eliminación</p>");
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}