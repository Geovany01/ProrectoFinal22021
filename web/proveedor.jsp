<%@page import="modelo.Proveedor"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formulario Proveedores</title>
        <link href="table.css" rel="stylesheet" type="text/css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    </head>
    <body>

        <div class="container">
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
