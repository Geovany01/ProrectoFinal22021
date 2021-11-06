<%-- 
    Document   : index
    Created on : 6/09/2021, 19:09:24
    Author     : gvosc
--%>
<%@page import="modelo.Cliente"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario Empleados</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>
    <body>

        <div class="container">
            <!-- Modal -->
            <div class="modal fade" id="modalCliente" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="SrCliente" method="post" class="form">
                                <h2 class="form_title">Ingresar Datos</h2>
                                <div class="form_container">

                                    <div class="form_group">
                                        <input type="text" name="txtId" id="txtId" class="form_imput" value="0" readonly>
                                        <label for="lblId" class="form_label">ID</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <input type="text" name="txtNombres" id="txtNombres" class="form_imput" placeholder="Ejemplo: Carlos">
                                        <label for="lblNombres" class="form_label">Nombres:</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <input type="text" name="txtApellidos" id="txtApellidos" class="form_imput" placeholder="Ejemplo: Ramírez">
                                        <label for="lblApellidos" class="form_label">Apellidos:</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <input type="text" name="txtNit" id="txtNit" class="form_imput" placeholder="Ejemplo: 1243-1">
                                        <label for="lblNit" class="form_label">NIT:</label>
                                        <span class="form_line"></span>
                                    </div>
                                    <div class="form_group">
                                        <label for="lblGenero" class="form_label">Género:</label>
                                        <br>
                                        <input type="radio" name="txtGenero" value="1">Masculino   
                                        <input type="radio" name="txtGenero" value="0">Femenino
                                        <span class="form_line"></span>
                                        <br>                                                                                        
                                    </div>
                                    <div class="form_group">
                                        <input type="number" name="txtTelefono" id="txtTelefono" class="form_imput" placeholder="Ejemplo: 12784536">
                                        <label for="lblTelefono" class="form_label">Teléfono:</label>
                                        <span class="form_line"></span>
                                    </div>                                    
                                    <div class="form_group">
                                        <input type="date" name="txtCorreo" id="txtCorreo" class="form_imput" placeholder="Ejemplo: usuario@dominio.com">
                                        <label for="lblCorreo" class="form_label">E-mail</label>
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
                        </div>
                    </div>
                </div>
            </div>




            <br>
            <h1>Clientes</h1>
            <table class="table table-bordered">
                <thead>
                    <tr>

                        <th>Nombres</th>
                        <th>Apellidos</th>
                        <th>NIT</th>
                        <th>Genero</th>
                        <th>Telefono</th>
                        <th>E-mail</th>
                        <th>Ingreso</th>
                    </tr>
                </thead>
                <tbody id="tblClientes">
                    <%
         Cliente cliente = new Cliente();
         DefaultTableModel tabla = new DefaultTableModel();
         tabla = cliente.leer();
         for (int t=0;t <tabla.getRowCount();t++){
             out.println("<tr data-id="+tabla.getValueAt(t, 0)+">");
             out.println("<td>"+ tabla.getValueAt(t, 1)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 2)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 3)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 4)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 5)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 6)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 7)+"</td>");
             out.println("</tr>");
         }
        
                    %>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalCliente" onclick="limpiar()">Nuevo Cliente</button>
            <a href="index.jsp"><button type="button" class="btn btn-danger">Atrás <--</button></a>
        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script type="text/javascript">

                function limpiar() {
                    $("#txtId").val(0);
                    $("#txtNombres").val('');
                    $("#txtApellidos").val('');
                    $("#txtNit").val('');
                    $("#txtGenero").val('');
                    $("#txtTelefono").val('');
                    $("#txtCorreo").val('');
                    $("#txtFechaIngreso").val('');
                }

                $('#tblClientes').on('click', 'tr td', function (evt) {
                    var target, id, nombres, apellidos, nit, genero, telefono, correo, ingreso;
                    target = $(event.target);
                    id = target.parent().data('id');
                    nombres = target.parent("tr").find("td").eq(0).html();
                    apellidos = target.parent("tr").find("td").eq(1).html();
                    nit = target.parent("tr").find("td").eq(2).html();
                    genero = target.parent("tr").find("td").eq(3).html();
                    telefono = target.parent("tr").find("td").eq(4).html();
                    correo = target.parent("tr").find("td").eq(5).html();
                    ingreso = target.parent("tr").find("td").eq(6).html();


                    $("#txtId").val(id);
                    $("#txtNombres").val(nombres);
                    $("#txtApellidos").val(apellidos);
                    $("#txtNit").val(nit);
                    $("#txtGenero").val(genero);
                    $("#txtTelefono").val(telefono);
                    $("#txtCorreo").val(correo);
                    $("#txtFechaIngreso").val(ingreso);
                    $("#modalCliente").modal('show');
                });
        </script>
    </body>
</html>
