<%@page import="modelo.Proveedor"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page import="modelo.InicioSesion"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario Proveedores</title>
        <link href="table.css" rel="stylesheet" type="text/css">
        <link href="style.css" rel="stylesheet" type="text/css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    </head>
    <body>
        <div style="display: block; position: absolute; width: 100%">
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
        </div>
        <div class="container" style="margin-top: 60px;">
            <!-- Modal -->
            <div class="modal fade" id="modalProveedor" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-body">
                            <form action="SrProveedor" method="post" class="form-group">
                                <label for="lblId"><b>ID</b></label>
                                <input type="text" name="txtId" id="txtId" class="form-control" value="0"  readonly>
                                <label for="lblNombres"><b>Proveedor</b></label>
                                <input type="text" name="txtNombres" id="txtNombres" class="form-control" placeholder="Ejemplo: Nombre1 Nombre2">
                                <label for="lblDireccion"><b>Direccion</b></label>
                                <input type="text" name="txtDireccion" id="txtDireccion" class="form-control" placeholder="Ejemplo: Lugar Calle Av.">
                                <label for="lblNit"><b>NIT</b></label>
                                <input type="text" name="txtNit" id="txtNit" class="form-control" placeholder="Ejemplo: E001" >
                                <label for="lblTelefono"><b>Telefono</b></label>
                                <input type="number" name="txtTelefono" id="txtTelefono" class="form-control" placeholder="Ejemplo: 12345678">
                                <br>
                                <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                                <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modifi</button>
                                <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg">Eliminar</button>
                                <button type="button" id="btn_close" class="btn btn-secondary btn-lg" data-bs-dismiss="modal">Close</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>




            <br>
            <h1>Proveedores</h1>
            <table class="table table-bordered">
                <thead>
                    <tr>

                        <th>Proveedor</th>
                        <th>Direccion</th>
                        <th>NIT</th>
                        <th>Telefono</th>
                    </tr>
                </thead>
                <tbody id="tblProveedores">
                    <%
         Proveedor proveedor = new Proveedor();
         DefaultTableModel tabla = new DefaultTableModel();
         tabla = proveedor.leer();
         for (int t=0;t <tabla.getRowCount();t++){
             out.println("<tr data-id="+tabla.getValueAt(t, 0)+">");
             out.println("<td>"+ tabla.getValueAt(t, 1)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 2)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 3)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 4)+"</td>");
             out.println("</tr>");
         }
        
                    %>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalProveedor" onclick="limpiar()">Nuevo Proveedor</button>
            <a href="index.jsp"><button type="button" class="btn btn-danger">Atrás <--</button></a>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
        <script type="text/javascript">

                function limpiar() {
                    $("#txtId").val(0);
                    $("#txtNombres").val('');
                    $("#txtNit").val('');
                    $("#txtDireccion").val('');
                    $("#txtTelefono").val('');
                }

                $('#tblProveedores').on('click', 'tr td', function (evt) {
                    var target, id, proveedor, nit, direccion, telefono;
                    target = $(event.target);
                    id = target.parent().data('id');
                    proveedor = target.parent("tr").find("td").eq(0).html();
                    nit = target.parent("tr").find("td").eq(1).html();
                    direccion = target.parent("tr").find("td").eq(2).html();
                    telefono = target.parent("tr").find("td").eq(3).html();

                    $("#txtId").val(id);
                    $("#txtNombres").val(proveedor);
                    $("#txtNit").val(nit);
                    $("#txtDireccion").val(direccion);
                    $("#txtTelefono").val(telefono);
                    $("#modalProveedor").modal('show');
                });
        </script>
    </body>
</html>
