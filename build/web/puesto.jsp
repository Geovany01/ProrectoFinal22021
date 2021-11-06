<%-- 
    Document   : puesto
    Created on : 5/10/2021, 10:44:52
    Author     : gvosc
--%>
<%@page import="modelo.Puesto"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Puestos</title>
        <link href="style.css" rel="stylesheet" type="text/css">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

    </head>
    <body>

        <div class="dropdown mb-3">
            <a href="#" class="btn btn-secondary dropdown-toggle" role="button" id="dropdownMenuEnlace" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                Desplegar...
            </a>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuEnlace">
                <a href="#" class="dropdown-item">Item1</a> 
                <a href="#" class="dropdown-item">Item2</a> 
            </div>
        </div>

        <div class="dropdown mb-3">
            <button class="btn btn-succes dropdown-toggle" type="button" id="dropdownMenuBoton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                Desplegar2 
            </button>
            <div class="dropdown-menu" aria-labelledby="dropdownMenuBoton">
                <a href="#" class="dropdown-item">Item1</a> 
                <a href="#" class="dropdown-item">Item2</a> 
            </div>
        </div>


        <div class="contenedor">
            <h1>Puestos existentes</h1>
            <div class="container">
                <!-- Modal -->
                <div class="modal fade" id="modalPuesto" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Formulario Puesto</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="SrPuesto" method="post" class="form">
                                    <h2 class="form_title">Ingresar Datos</h2>
                                    <div class="form_container">
                                        <div class="form_group">
                                            <input type="text" name="txtId" id="txtId" class="form_imput" value="0" readonly>
                                            <label for="lblId" class="form_label">ID</label>
                                            <span class="form_line"></span>
                                        </div>
                                        <div class="form_group">
                                            <input type="text" name="txtPuesto" id="txtPuesto" class="form_imput" placeholder="Ejemplo: Gerente">
                                            <label for="lblPuesto" class="form_label">Ingrese el Puesto:</label>
                                            <span class="form_line"></span>
                                        </div>
                                        <div class="btn_group">
                                            <button name="btn_agregar" id="btn_agregar" value="agregar" class="form_submit">Agregar</button>
                                            <button name="btn_modificar" id="btn_modificar" value="modificar" class="form_submit">Modificar</button>
                                            <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="form_submit">Eliminar</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <br>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>IdPuesto</th>
                        <th>Puesto</th>
                    </tr>
                </thead>
                <tbody id="tblPuestos">
                    <%
         Puesto puesto = new Puesto();
         DefaultTableModel tabla = new DefaultTableModel();
         tabla = puesto.leer();
         for (int t=0;t <tabla.getRowCount();t++){
             out.println("<tr data-id="+tabla.getValueAt(t, 0)+">");
             out.println("<td>"+ tabla.getValueAt(t, 0)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 1)+"</td>");
             out.println("</tr>");
         }
        
                    %>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalPuesto" onclick="limpiar()">Nuevo</button>
            <a href="index.jsp"><button type="button" class="btn btn-danger">Atrás <--</button></a>

        </div>
                
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>

        <script type="text/javascript">

                function limpiar() {
                    $("#txtId").val(0);
                    $("#txtPuesto").val('');
                }

                $('#tblPuestos').on('click', 'tr td', function (evt) {
                    var target, id, puesto;
                    target = $(event.target);
                    id = target.parent().data('id');
                    puesto = target.parent("tr").find("td").eq(1).html();

                    $("#txtId").val(id);
                    $("#txtPuesto").val(puesto);
                    $("#modalPuesto").modal('show');
                });
        </script>
    </body>
</html>
