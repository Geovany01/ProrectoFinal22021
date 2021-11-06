/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.Set;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.InicioSesion;

/**
 *
 * @author gvosc
 */
public class SrInicioSesion extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    InicioSesion login;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SrInicioSesion</title>");            
            out.println("</head>");
            out.println("<body>");
            
            login = new InicioSesion(request.getParameter("txt_usuario"), request.getParameter("txt_contrasena"));

            if (login.VerificarCredenciales() > 0) {
                HttpSession s = request.getSession();
                s.setAttribute("U",request.getParameter("txt_usuario"));
                if(login.SolicitarRol()>0){
                s.setAttribute("R",login.SolicitarRol());
                response.sendRedirect("index.jsp");
                }
                else{
                out.println("<h1>Rol Invalido</h1>");
                out.println("Hemos tenido errorea al encontrar el rol por favor cierre la aplicacion y vuelva a intertarlo");
                out.println("<a href='InicioSesion.jsp'>Regresar</a>");
                }
                
                
                
            } else {
                out.println("<h1>Credenciales Invalidas</h1>");
                out.println("Revise si usuario y contraseña estan escritos correctamente y vuelva intentar");
                out.println("<a href='InicioSesion.jsp'>Regresar</a>");
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
