//
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- <%@page import="modelo.InicioSesion"%>--%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://fonts.googleapis.com/css2?family=Pacifico&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
        <link href="https://fontawesome.com/v4.7.0/assets/font-awesome/css/font-awesome.css" rel="stylesheet"/>

        <title>Login</title>
    </head>
    <body>
        <style>
            body{
                background-image:linear-gradient(
                    rgba(0, 0, 0,.4), 
                    rgba(0, 0, 0,.4)
                    ),
                    url(https://cdn.pixabay.com/photo/2018/07/11/11/14/ecommerce-3530785_960_720.jpg);
                background-size: cover;
                -webkit-background-size: cover;
                -moz-background-size: cover;
                background-repeat: no-repeat;
                background-attachment: fixed;

                h1{
                    font-family:'Pacifico', cursive;
                    color:#343A40;
                    text-align: center;
                }
                .contenedor{
                    background: rgba(255,255,255,.8);
                }
                #main-form .main-form .shortfieldz .zmdi-link {
                    position: absolute;
                    font-size: 28px;
                    top: 10px; 
                    left: 25px; 
                    color: #8c8c8c;
                    border-radius: 20px; 
                    pointer-events: none;
                }
            </style>
            <form action="SrInicioSesion" method="post">
              <div class="container">
                <div class="row justify-content-md-center align-items-center vh-100">
                    <div class="col-sm-8">
                        <div class="justify-content-md-center" style="background: rgba(255,255,255,.8);">
                            <h1>Login</h1>
                            Usuario:
                            <input type="text" id="txt_usuario" name="txt_usuario" class="form-control">
                            Contraseña:
                            <input type="password" id="txt_contrasena" name="txt_contrasena" class="form-control">
                            <br>
                            <button class="btn-primary" name="btn_aceptar" id="btn_aceptar" value="aceptar">Inicio Sesion</button>
                        </div>
                    </div>
                </div>
            </div>  
            </form>
            
            <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

        </body>
    </html>

