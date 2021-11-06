package controlador;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import modelo.Producto;

@MultipartConfig
public class SrProducto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    Producto producto;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SrProducto</title>");
            out.println("</head>");
            out.println("<body>");
            
            /*---------------------Archivo--------------------*/
            String nombre = request.getParameter("nombre");
            Part archivo = request.getPart("txtImagen");
            InputStream inputStream = archivo.getInputStream();
            File file = new File("C:/Users/gvosc/Desktop/ProyectoProgra22021/web/img/" + nombre);
            FileOutputStream outPut = new FileOutputStream(file);
            int dato = inputStream.read();
            while(dato != -1){
                outPut.write(dato);
                dato = inputStream.read();
            }
         
            outPut.close();
            inputStream.close();
            
            String ruta = nombre;
            
            /*---------------------Archivo--------------------*/
            
            producto = new Producto(Integer.valueOf(request.getParameter("txtId")),
                                    Integer.valueOf(request.getParameter("dropMarca")),
                                    Integer.valueOf(request.getParameter("txtExistencia")),
                                    request.getParameter("txtProducto"), request.getParameter("txtDescripcion"),
                                    /*request.getParameter("txtImagen")*/ruta, request.getParameter("txtFechaIngreso"),
                                    Float.valueOf(request.getParameter("txtPrecioCosto")),
                                    Float.valueOf(request.getParameter("txtPrecioVenta")));

            if ("agregar".equals(request.getParameter("btn_agregar"))) {
                if (producto.agregar() > 0) {
                    response.sendRedirect("producto.jsp");
                } else {
                    out.println("<h1> xxxxxxNo se ingreso xxxxxxxxxx </h1>");
                    out.println("<a href='producto.jsp'>Regresar...</a>");
                }
            }

            //Botón Modificar
            if ("modificar".equals(request.getParameter("btn_modificar"))) {
                if (producto.modificar() > 0) {
                    response.sendRedirect("producto.jsp");
                } else {
                    out.println("<h1> xxxxxxNo se modificó xxxxxxxxxx </h1>");
                    out.println("<a href='producto.jsp'>Regresar...</a>");
                }
            }

            //Botón Eliminar
            if ("eliminar".equals(request.getParameter("btn_eliminar"))) {
                if (producto.eliminar() > 0) {
                    response.sendRedirect("producto.jsp");
                } else {
                    out.println("<h1> xxxxxxNo se eliminó xxxxxxxxxx </h1>");
                    out.println("<a href='producto.jsp'>Regresar...</a>");
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
