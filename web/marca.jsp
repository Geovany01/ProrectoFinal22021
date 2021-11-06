
<%@page import="modelo.Marca"%>
<%@page import="java.util.HashMap"%>
<%@page import="javax.swing.table.DefaultTableModel"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Marcas</title>
        <link href="table.css" rel="stylesheet" type="text/css">
        <link href="style.css" rel="stylesheet" type="text/css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    </head>
    <body>
        <div class="contenedor">
            <h1>Marcas existentes</h1>
            <div class="container">
                <!-- Modal -->
                <div class="modal fade" id="modalMarca" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Formulario Marca</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="SrMarca" method="post" class="form-group">
                                    <label for="lblId"><b>ID</b></label>
                                    <input type="text" name="txtId" id="txtId" class="form-control" value="0"  readonly>
                                    <label for="lblMarca"><b><h2>Ingrese la Marca</h2></b></label>
                                    <input type="text" name="txtMarca" id="txtMarca" class="form-control" placeholder="Ejemplo: CHICOTE">
                                    <br>
                                    <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                                    <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modifi</button>
                                    <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg">Eliminar</button>
                                    <button type="button" class="btn btn-secondary btn-lg" data-bs-dismiss="modal">Close</button>
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
                        <th>IdMarca</th>
                        <th>Marca</th>
                    </tr>
                </thead>
                <tbody id="tblMarcas">
                    <%
         Marca marca = new Marca();
         DefaultTableModel tabla = new DefaultTableModel();
         tabla = marca.leer();
         for (int t=0;t <tabla.getRowCount();t++){
             out.println("<tr data-id="+tabla.getValueAt(t, 0)+">");
             out.println("<td>"+ tabla.getValueAt(t, 0)+"</td>");
             out.println("<td>"+ tabla.getValueAt(t, 1)+"</td>");
             out.println("</tr>");
         }
        
                    %>
                </tbody>
            </table>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalMarca" onclick="limpiar()">Nuevo</button>
            <a href="index.jsp"><button type="button" class="btn btn-danger">Atrás <--</button></a>

        </div>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script type="text/javascript">

                function limpiar() {
                    $("#txtId").val(0);
                    $("#txtMarca").val('');
                }

                $('#tblMarcas').on('click', 'tr td', function (evt) {
                    var target, id, marca;
                    target = $(event.target);
                    id = target.parent().data('id');
                    marca = target.parent("tr").find("td").eq(1).html();

                    $("#txtId").val(id);
                    $("#txtMarca").val(marca);
                    $("#modalMarca").modal('show');
                });
        </script>
    </body>
</html>
