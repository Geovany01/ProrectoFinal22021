<%-- 
    Document   : index
    Created on : 6/09/2021, 19:09:24
pattern="[E]{1}[0-9]{3}" required
    Author     : gvosc
--%>
<%@page import="modelo.Marca"%>
<%@page import="modelo.Producto"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.InicioSesion"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Productos</title>
        <script type="text/javascript" src="app.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>
    <body>

        <div style="display: block; position: absolute; width: 100%">
            <nav class="navbar navbar-expand-sm justify-content-center color-light navbar-dark bg-dark ">
                <a href="index.jsp"><p class="navbar-brand" style="margin-right: 95px; margin-left: 40px;"> Inicio</p></a>                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#menu">
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
        </div>

        <div class="container" style="margin-top: 80px;">
            <!-- Modal -->
            <div class="modal fade" id="modalProducto" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="SrProducto" name="formulario" method="post" class="form" enctype="multipart/form-data">

                                <h2 class="form_title">Ingresar Datos</h2>
                                <div class="form_container">
                                    <div class="form_group">
                                        <input type="text" name="txtId" id="txtId" class="form_imput" value="0" readonly>
                                        <label for="lblId" class="form_label">ID</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <input type="text" name="txtProducto" id="txtProducto" class="form_imput" placeholder="Ejemplo: Notebook">
                                        <label for="lblProducto" class="form_label">Producto:</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <label for="lblMarca" class="form_label">Marca:</label>

                                    </div>
                                    <br>

                                    <div class="drop_link">                                         
                                        <select name="dropMarca" id="dropMarca" class="dropMarca">

                                            <%
                                                Marca marca = new Marca();
                                                HashMap<String, String> drop = marca.dropSangre();
                                                for (String i : drop.keySet()) {
                                                    out.println("<option value='" + i + "' >" + drop.get(i) + "</option>");
                                                }
                                            %>

                                        </select>
                                        

                                    </div>

                                    <div class="form_group">
                                        <input type="text" name="txtDescripcion" id="txtDescripcion" class="form_imput" placeholder="Ejemplo: Gama">
                                        <label for="lblDescripción" class="form_label">Descripción:</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <label for="lblImagen" class="form_label">Imagen</label>

                                    </div>
                                    <br>
                                    <div class="form_group">
                                        <input type="file" onchange="cargarArchivo(this)" name="txtImagen" id="txtImagen" class="form_imput" placeholder="Ejemplo: prueba.jpg">
                                        <input type="hidden" name="nombre" value="">
                                    </div>
                                    <div class="form_group">
                                        <input type="text" name="txtPrecioCosto" id="txtPrecioCosto" class="form_imput" placeholder="Ejemplo: Q.15000">
                                        <label for="lblPrecioCosto" class="form_label">PrecioCosto:</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <input type="text" name="txtPrecioVenta" id="txtPrecioVenta" class="form_imput" placeholder="Ejemplo: Q.17000">
                                        <label for="lblPrecioVenta" class="form_label">PrecioVenta:</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <input type="text" name="txtExistencia" id="txtExistencia" class="form_imput" placeholder="Ejemplo: 5">
                                        <label for="lblExistencia" class="form_label">Existencia:</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <input type="text" name="txtFechaIngreso" id="txtFechaIngreso" class="form_imput" placeholder="Ejemplo: YYY-MM-DD">
                                        <label for="lblFechaIngreso" class="form_label">Ingreso:</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="btn_group">
                                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="form_submit">Agregar</button>
                                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="form_submit">Modificar</button>
                                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="form_submit">Eliminar</button>
                                    </div>
                                </div>                                

                            </form>
                            <iframe name="null" style="display:none;"></iframe>
                        </div>
                    </div>
                </div>
            </div>

            <br>
            <h1>Productos</h1>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Marca</th>
                        <th>Descripción</th>
                        <th>Imagen</th>
                        <th>Precio Costo</th>
                        <th>Precio Venta</th>
                        <th>Existencia</th>
                        <th>FechaIngreso</th>  
                    </tr>
                </thead>
                <tbody id="tblProductos">
                    <%
                        Producto producto = new Producto();
                        DefaultTableModel tabla = new DefaultTableModel();
                        tabla = producto.leer();
                        for (int t = 0; t < tabla.getRowCount(); t++) {
                            out.println("<tr data-id=" + tabla.getValueAt(t, 0) + " data-id_m=" + tabla.getValueAt(t, 9) + ">");
                            out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                                
                            out.println("<td><img src='img/" + tabla.getValueAt(t, 4) + "' style='max-width:75px;max-height:75px;border-radius:.4em'></td>");
                                
                           /*out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");*/
                            out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 7) + "</td>");
                            out.println("<td>" + tabla.getValueAt(t, 8) + "</td>");
                            out.println("</tr>");
                        }

                    %>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalProducto" onclick="limpiar()">Nuevo</button>
            <a href="index.jsp"><button type="button" class="btn btn-danger">Atrás <--</button></a>
            <a href="marca.jsp"><button type="button" id="btn_modificar" class="form_submit">Crud Marca</button></a>
        </div> 



        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
        <script type="text/javascript">

                function limpiar() {
                    $("#txtId").val(0);
                    $("#dropMarca").val(1);
                    $("#txtProducto").val('');
                    $("#txtDescripcion").val('');
                    $("#txtImagen").val('');
                    $("#txtPrecioCosto").val('');
                    $("#txtPrecioVenta").val('');
                    $("#txtExistencia").val('');
                    $("#txtFechaIngreso").val('');
                }

                $('#tblProductos').on('click', 'tr td', function (evt) {
                    var target, id, id_m, producto, descripcion, /*imagen,*/ precioCosto, precioVenta, existencia, fechaIngreso;
                    target = $(event.target);
                    id = target.parent().data('id');
                    id_m = target.parent().data('id_m');
                    producto = target.parent("tr").find("td").eq(0).html();
                    descripcion = target.parent("tr").find("td").eq(2).html();
                    /*imagen = target.parent("tr").find("td").eq(3).html();*/
                    precioCosto = target.parent("tr").find("td").eq(4).html();
                    precioVenta = target.parent("tr").find("td").eq(5).html();
                    existencia = target.parent("tr").find("td").eq(6).html();
                    fechaIngreso = target.parent("tr").find("td").eq(7).html();


                    $("#txtId").val(id);
                    $("#dropMarca").val(id_m);
                    $("#txtProducto").val(producto);
                    $("#txtDescripcion").val(descripcion);
                    /*$("#txtImagen").val(imagen);*/
                    $("#txtPrecioCosto").val(precioCosto);
                    $("#txtPrecioVenta").val(precioVenta);
                    $("#txtExistencia").val(existencia);
                    $("#txtFechaIngreso").val(fechaIngreso);
                    $("#modalProducto").modal('show');
                });
        </script>
    </body>
</html>

