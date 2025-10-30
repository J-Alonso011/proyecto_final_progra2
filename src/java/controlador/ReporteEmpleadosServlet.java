/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

/**
 *
 * @author crisf
 */
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import modelo.Conexion;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperExportManager;

@WebServlet(name = "ReporteEmpleadosServlet", urlPatterns = {"/reporte_empleados"})
public class ReporteEmpleadosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");
        

        Conexion cn = new Conexion();
        Connection con = cn.abrir_conexion();

        try {
            // Obtiene la ruta real del archivo jasper
            String path = getServletContext().getRealPath("/WEB-INF/reportes/reporte_empleados.jasper");
            JasperPrint print = JasperFillManager.fillReport(path, new HashMap<>(), con);

            // Exportar a PDF directamente al navegador
            JasperExportManager.exportReportToPdfStream(print, response.getOutputStream());
            response.getOutputStream().flush();
        } catch (IOException | JRException e) {
            e.printStackTrace(response.getWriter());
        } finally {
            cn.cerrar_conexion();
        }
    }
}
