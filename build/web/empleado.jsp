<%-- 
    Document   : index
    Created on : 6/09/2021, 19:09:24
pattern="[E]{1}[0-9]{3}" required
    Author     : gvosc
<input type="text" name="txtGenero" id="txtGenero" class="form_imput" placeholder="Ejemplo: Masculino/Femenino">
--%>
<%@page import="modelo.Puesto"%>
<%@page import="modelo.Empleado"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Empleados</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>
    <body>

        <div class="contenedorEmpleado">
            <h1>Formulario Empleados</h1>
            <div class="container">
                <!-- Modal -->
                <div class="modal fade" id="modalEmpleado" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="SrEmpleado" method="post" class="form">

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
                                            <input type="text" name="txtDireccion" id="txtDireccion" class="form_imput" placeholder="Ejemplo: Calle, Depto. País">
                                            <label for="lblDireccion" class="form_label">Dirección:</label>
                                            <span class="form_line"></span>
                                        </div>
                                        <div class="form_group">
                                            <input type="number" name="txtTelefono" id="txtTelefono" class="form_imput" placeholder="Ejemplo: 12784536">
                                            <label for="lblTelefono" class="form_label">Teléfono:</label>
                                            <span class="form_line"></span>
                                        </div>
                                        <div class="form_group">
                                            <input type="text" name="txtDPI" id="txtDPI" class="form_imput" placeholder="Ejemplo: 1243 12354 0201">
                                            <label for="lblDPI" class="form_label">DPI:</label>
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
                                            <input type="date" name="txtFechaNacimiento" id="txtFechaNacimiento" class="form_imput" placeholder="Ejemplo: yyy-MM-DD">
                                            <label for="lblFechaNacimiento" class="form_label">Nacimiento:</label>
                                            <span class="form_line"></span>
                                        </div>

                                        <div class="form_group">
                                            <label for="lblPuesto" class="form_label">Puesto:</label>

                                        </div>
                                        <br>
                                        <select name="dropPuesto" id="dropPuesto" class="form-control">
                                            <%
                                                Puesto puesto = new Puesto();
                                                HashMap<String,String> drop = puesto.dropSangre();
                                                for(String i: drop.keySet()) {
                                                    out.println("<option value='" + i + "' >" + drop.get(i) + "</option>");
                                                }
                                            %>
                                        </select>
                                        <div class="form_group">
                                            <input type="date" name="txtFechaInicioLabores" id="txtFechaInicioLabores" class="form_imput" placeholder="Ejemplo: yyy-MM-DD">
                                            <label for="lblFechaInicioLabores" class="form_label">Inicio Labores:</label>
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
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Nombres</th>
                            <th>Apellidos</th>
                            <th>Direccion</th>
                            <th>Telefono</th>
                            <th>DPI</th>
                            <th>Genero</th>
                            <th>Nacimiento</th>
                            <th>Puesto</th>
                            <th>Inicio Labores</th>
                            <th>Ingreso</th>
                        </tr>
                    </thead>
                    <tbody id="tblEmpleados">
                        <%
             Empleado empleado = new Empleado();
             DefaultTableModel tabla = new DefaultTableModel();
             tabla = empleado.leer();
             for (int t=0;t <tabla.getRowCount();t++){
                 out.println("<tr data-id=" + tabla.getValueAt(t, 0) + " data-id_p="+tabla.getValueAt(t, 11) + ">");
                 out.println("<td>"+ tabla.getValueAt(t, 1)+"</td>");
                 out.println("<td>"+ tabla.getValueAt(t, 2)+"</td>");
                 out.println("<td>"+ tabla.getValueAt(t, 3)+"</td>");
                 out.println("<td>"+ tabla.getValueAt(t, 4)+"</td>");
                 out.println("<td>"+ tabla.getValueAt(t, 5)+"</td>");
                 out.println("<td>"+ tabla.getValueAt(t, 6)+"</td>");
                 out.println("<td>"+ tabla.getValueAt(t, 7)+"</td>");
                 out.println("<td>"+ tabla.getValueAt(t, 8)+"</td>");
                 out.println("<td>"+ tabla.getValueAt(t, 9)+"</td>");
                 out.println("<td>"+ tabla.getValueAt(t, 10)+"</td>");
                 out.println("</tr>");
             }
        
                        %>
                    </tbody>
                </table>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalEmpleado" onclick="limpiar()">Nuevo</button>
                <a href="index.jsp"><button type="button" class="btn btn-danger">Atrás <--</button></a>
            </div> 
        </div>


        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script type="text/javascript">

                    function limpiar() {
                        $("#txtId").val(0);
                        $("#dropPuesto").val(1);
                        $("#txtNombres").val('');
                        $("#txtApellidos").val('');
                        $("#txtDireccion").val('');
                        $("#txtTelefono").val('');
                        $("#txtDPI").val('');
                        $("#txtGenero").val('');
                        $("#txtFechaNacimiento").val('');
                        $("#txtFechaInicioLabores").val('');
                        $("#txtFechaIngreso").val('');
                    }

                    $('#tblEmpleados').on('click', 'tr td', function (evt) {
                        var target, id, id_p, nombres, apellidos, direccion, telefono, DPI, genero, nacimiento, fechaInicioLabores, fechaIngreso;
                        target = $(event.target);
                        id = target.parent().data('id');
                        id_p = target.parent().data('id_p');
                        nombres = target.parent("tr").find("td").eq(0).html();
                        apellidos = target.parent("tr").find("td").eq(1).html();
                        direccion = target.parent("tr").find("td").eq(2).html();
                        telefono = target.parent("tr").find("td").eq(3).html();
                        DPI = target.parent("tr").find("td").eq(4).html();
                        genero = target.parent("tr").find("td").eq(5).html();
                        nacimiento = target.parent("tr").find("td").eq(6).html();
                        fechaInicioLabores = target.parent("tr").find("td").eq(8).html();
                        fechaIngreso = target.parent("tr").find("td").eq(9).html();


                        $("#txtId").val(id);
                        $("#dropPuesto").val(id_p);
                        $("#txtNombres").val(nombres);
                        $("#txtApellidos").val(apellidos);
                        $("#txtDireccion").val(direccion);
                        $("#txtTelefono").val(telefono);
                        $("#txtDPI").val(DPI);
                        $("#txtGenero").val(genero);
                        $("#txtFechaNacimiento").val(nacimiento);
                        $("#txtFechaInicioLabores").val(fechaInicioLabores);
                        $("#txtFechaIngreso").val(fechaIngreso);
                        $("#modalEmpleado").modal('show');
                    });
        </script>
    </body>
</html>

