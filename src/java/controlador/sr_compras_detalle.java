/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Compras_detalle;

/**
 *
 * @author mutsu
 */
public class sr_compras_detalle extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    Compras_detalle compras_detalle;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet sr_compras_detalle</title>");            
            out.println("</head>");
            out.println("<body>");
           compras_detalle = new Compras_detalle(Integer.valueOf(request.getParameter("txt_id")),Integer.valueOf(request.getParameter("drop_id_compra")),Integer.valueOf(request.getParameter("drop_product")),Integer.valueOf(request.getParameter("txt_cantidad")),Float.valueOf(request.getParameter("txt_costo_unitario")),Float.valueOf(request.getParameter("txt_subtotal")));
            
             if("agregar".equals(request.getParameter("btn_agregar"))){
            
           if(compras_detalle.agregar()>0){
               if(compras_detalle.modificarcp()>0){
               
       response.sendRedirect("Compras_detalle.jsp");
               }
           } else {
           out.println("<h1>ERROR............</h1>");
           out.println("<a href ='index.jsp'>Regresar</a> ");
           }
           }
           
             
             if("modificar".equals(request.getParameter("btn_modificar"))){
            
           if(compras_detalle.modificar()>0){
       response.sendRedirect("Compras_detalle.jsp");
       } else {
           out.println("<h1>ERROR............</h1>");
           out.println("<a href ='index.jsp'>Regresar</a> ");
           }
           } 
            
               if("eli".equals(request.getParameter("btn_eli"))){
            
           if(compras_detalle.eliminar()>0){
       response.sendRedirect("Compras_detalle.jsp");
       } else {
           out.println("<h1>ERROR............</h1>");
           out.println("<a href ='index.jsp'>Regresar</a> ");
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
