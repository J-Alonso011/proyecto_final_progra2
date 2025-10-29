/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Cliente;

/**
 *
 * @author alons
 */
public class sr_cliente extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    Cliente cliente;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int id = Integer.parseInt(request.getParameter("txt_id"));
            String nombres = request.getParameter("txt_nombres");
            String apellidos = request.getParameter("txt_apellidos");
            String nit = request.getParameter("txt_nit");
            String telefono = request.getParameter("txt_telefono");
            String correo_electronico = request.getParameter("txt_correo_electronico");
            String fecha_ingreso = request.getParameter("txt_fi");

            
            boolean genero = request.getParameter("drop_genero").equals("1");
            
             cliente = new Cliente(
                    nit,
                    correo_electronico,
                    id,
                    nombres,
                    apellidos,
                    telefono,
                    fecha_ingreso,
                    genero
            );
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_cliente</title>");
            out.println("</head>");
            out.println("<body>");
           
            if("crear".equals(request.getParameter("btn_crear"))){
            if(cliente.crear()>0){
            response.sendRedirect("clientes.jsp");
            }else{
            out.println("<p>No se realizo la operacion</p>");
            }
            }
            
            if("actualizar".equals(request.getParameter("btn_actualizar"))){
             if(cliente.actualizar()>0){
            response.sendRedirect("clientes.jsp");
            }else{
            out.println("<p>No se realizo la operacion</p>");
            }
            }
            if("borrar".equals(request.getParameter("btn_borrar"))){
             if(cliente.borrar()>0){
            response.sendRedirect("clientes.jsp");
            }else{
            out.println("<p>No se realizo la operacion</p>");
            }
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
