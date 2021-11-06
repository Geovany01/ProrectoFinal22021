<%-- 
    Document   : Maestrodetalle.jsp
    Created on : 5/10/2021, 20:43:20
    Author     : mutsu
--%>

<%@page import="modelo.Ventas"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.InicioSesion"%>
<%@page session="true"%>
<%@page import="modelo.Ventas_detalle " %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ventas</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>

    </head>
    <body>
        <nav class="navbar navbar-expand-sm justify-content-center color-light navbar-dark bg-dark ">
            <a href="index.jsp"><p class="navbar-brand" style="margin-right: 95px; margin-left: 40px;"> Inicio</p></a> 
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-center" id="menu">

                <ul class="navbar-nav mr-auto">
                    <%
                        HttpSession s = request.getSession();
                        //Acceder a Session
                        if ((String) s.getAttribute("U") == null || (int) s.getAttribute("R") < 1) {
                            response.sendRedirect("InicioSesion.jsp");
                        } else {
                            InicioSesion login = new InicioSesion((String) s.getAttribute("U"), "");
                            DefaultTableModel tabla = new DefaultTableModel();
                            String rol = s.getAttribute("R").toString();
                            String rolEscrito;
                            switch (rol) {
                                case "1":
                                    rolEscrito = "Usted es admin";
                                    break;
                                case "2":
                                    rolEscrito = "Usted es empleado";
                                    break;
                                case "3":
                                    rolEscrito = "Usted es cliente";
                                    break;
                                default:
                                    rolEscrito = "Nos Hackeron XD";
                                    break;
                            }
                            String image = "<li class='nav-item dropdown' style='color:#fff; margin-top:5px;' >"
                                    + "<img src='" + login.LinkImage() + "' style='border-radius:50%;margin-right:5px;' width='30' height='30' alt=''>" + (String) s.getAttribute("U") + " (" + rolEscrito + ")</li>";
                            if (login.LinkImage().isEmpty()) {
                                image = "<li class='nav-item dropdown' style='color:#fff; margin-right:180px;'>"
                                        + "<img src='https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png' style='border-radius:50%; margin-right:5px;' width='30' height='30' alt=''>" + (String) s.getAttribute("U") + "</li>";
                            }

                            out.println(image);

                            tabla = login.GenerarMenu(rol);
                            for (int t = 0; t < tabla.getRowCount(); t++) {
                                if(s.getAttribute("R").toString().contains("3") && tabla.getValueAt(t, 1).toString().contains("Ventas"))
                                {
                                }
                                else{
                                String drop = "<li class='nav-item  mr-4 dropdown'>"
                                        + "<a class='nav-link dropdown-toggle' href='#' id='a" + tabla.getValueAt(t, 0) + "' role='button' data-toggle='dropdown' aria-haspopup='true' aria-expanded='true'>"
                                        + tabla.getValueAt(t, 1) + "<a/>"
                                        + " <div class='dropdown-menu' aria-labelledby='a" + tabla.getValueAt(t, 0) + "'>"
                                        + "<a class='dropdown-item' href='" + tabla.getValueAt(t, 2) + "'>" + tabla.getValueAt(t, 1) + "</a>";
                                out.println(drop);

                                DefaultTableModel tabla2 = new DefaultTableModel();
                                tabla2 = login.GenerarSubMenu(tabla.getValueAt(t, 0).toString());
                                for (int y = 0; y < tabla2.getRowCount(); y++) {
                                    if (s.getAttribute("R").toString().contains("2") && tabla2.getValueAt(y, 1).toString().contains("Empleados")) {

                                    } else {
                                        if(s.getAttribute("R").toString().contains("3") && tabla2.getValueAt(y, 1).toString().contains("Marcas") || s.getAttribute("R").toString().contains("3") && tabla2.getValueAt(y, 1).toString().contains("Proveedores")){
                                        }else{
                                         String option = "<a class='dropdown-item' href='" + tabla2.getValueAt(y, 2) + "'>" + tabla2.getValueAt(y, 1)+"</a>";
                                        out.println(option);
                                        }
                                       
                                    }

                                }
                                out.println("</div></li>");
                            }}
                        }

                    %>
                    <li class='nav-item dropdown'>
                        <a class='nav-link ml-5' href='SrCerrarSesion' style="color:#fff">Cerrar Sesion</a>
                    </li>
                </ul>
            </div>
        </nav>
        <form action="Compras.jsp" method="post" class="form-group">
            <button  name="btn_compras" id="btn_compras" value="compras" class="btn btn-danger"  >Compras</button>  
        </form>
        <h1>Formulario ventas</h1>
        <div class="container">
            <form action="sr_ventas" method="post" class="form-group">    
                <label for="lbl_nit">Nombre Nit</label> 
                <%  %>
                <select name ="drop_nit"  id="drop_nit" onchange="myFunction()" class="form-control">
                    <% Ventas ventas = new Ventas();
               
                   HashMap<String,String> drop = ventas.drop_nit();
                   out.println("Seleccione Cliente");
                   for(String i: drop.keySet()){
                       out.println("<option value='"+ i +"' >" + drop.get(i) +"   </option>");           
                        }
           
                    %> 

                </select> 

                <br>


                <label for="lbl_empleado">Empleado</label> 
                <select name ="drop_empleado"  id="drop_empleado" onchange="myFunction()" class="form-control">
                    <% Ventas ventas1 = new Ventas();
                   HashMap<String,String> drop1 = ventas1.drop_empleado();
             
                   for(String i: drop1.keySet()){
                       out.println("<option value='"+ i +"' >" + drop1.get(i) +"</option>");
                 
           
                
                        }
  
                    %> 

                </select>
                <br>

                <label for ="lbl_fecha">No_Factura</label>
                <select name ="drop_fecha"  id="drop_fecha" class="form-control" >
                    <% Ventas ventas2 = new Ventas();
                   HashMap<String,String> drop2 = ventas2.drop_fecha();
                   for(String i: drop2.keySet()){
                       out.println("<option value='"+ i +"' >" + drop2.get(i) +"   </option>");
                       }
          

                    %> 

                </select>
                <br>
                <label for="lbl_serie">Serie</label>
                <input name="txt_serie" id="txt_serie" class="form-control">   

                <button  name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary">Agregar</button>

            </form>
            <br>
            <br>
            <br>




        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>






    </body>
</html>
