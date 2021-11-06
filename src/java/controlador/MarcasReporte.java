/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.html.WebColors;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.ResultSet;
import modelo.Conexion;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author mutsu
 */
public class MarcasReporte extends HttpServlet {
  private Conexion cn;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/pdf");
        OutputStream out =response.getOutputStream();
       
         try{
            
             try {
               
                  cn = new Conexion();
            String query = "select marca from marcas;";
            cn.abrirConexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);

        String timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
        System.out.println(timeStamp); 
        
      
        
             Document documento = new Document();
             PdfWriter.getInstance(documento, out);
             documento.open();
             
             Image imagenes = Image.getInstance("C:\\Users\\gvosc\\Desktop\\ProyectoProgra22021\\1431098283_691735_1431098420_noticia_normal.jpg");
             imagenes.setAlignment(Element.ALIGN_LEFT);
             imagenes.scaleToFit(120, 120);
             documento.add(imagenes);
             
              Paragraph fecha1 = new Paragraph();
             Font fontfecha = new Font(Font.FontFamily.HELVETICA,9,Font.BOLD,BaseColor.BLACK);
             fecha1.add(new Phrase("Empresa:Company S.A. ", fontfecha));
             fecha1.add(new Phrase(Chunk.NEWLINE));
             fecha1.add(new Phrase("Direccion:4ta Calle Antigua Guatemala ", fontfecha));
             fecha1.add(new Phrase(Chunk.NEWLINE));
             fecha1.add(new Phrase("Telefono: 7832-5605 ", fontfecha));
             fecha1.add(new Phrase(Chunk.NEWLINE));
             fecha1.add(new Phrase("Fecha de impresion: " +timeStamp, fontfecha));
             fecha1.setAlignment(Element.ALIGN_LEFT);
             fecha1.add(new Phrase(Chunk.NEWLINE));
             fecha1.add(new Phrase(Chunk.NEWLINE)); 
            documento.add(fecha1); 
            
             
            
             
             Paragraph par1 = new Paragraph();
             Font fonttitulo = new Font(Font.FontFamily.TIMES_ROMAN,17,Font.UNDERLINE,BaseColor.BLACK);
             par1.add(new Phrase("REPORTE MARCAS",fonttitulo));
             par1.setAlignment(Element.ALIGN_CENTER);
             par1.add(new Phrase(Chunk.NEWLINE));
             par1.add(new Phrase(Chunk.NEWLINE));
             par1.add(new Phrase(Chunk.NEWLINE));
             documento.add(par1);
             
           
             PdfPTable tabla = new PdfPTable(1);
             PdfPCell celda1 = new PdfPCell (new Paragraph("Marcas",FontFactory.getFont("Arial", 12, Font.BOLD,BaseColor.WHITE)));
             
             BaseColor myColor = WebColors.getRGBColor("#A00000");
             celda1.setBackgroundColor(myColor);
   
             tabla.addCell(celda1);
             
             
             
             int cont=0;
              while (consulta.next()){
                  cont++;
              tabla.addCell(consulta.getString(1));
              
              }
             
             
             documento.add(tabla);
             
             documento.close();
             
             
             }catch(Exception ex){ex.getMessage();}
             
        }finally {out.close();}
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
