
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
        <link rel="stylesheet" href="css/form.css">

        <title>Login</title>
    </head>
    <body>
        
        <form action="SrInicioSesion" class="form" method="post">
            <h2 class="form_title">Iniciar Sesión</h2>
            <p class="form_paragraph">Aún no tienes una cuenta? <a href="#" class="form_link">Entra aquí</a></p>
            <div class="form_container">
                <div class="form_group">
                    <input type="text" name="user" id="user" class="form_imput" placeholder="usuario@dominio.com">
                    <label for="user" class="form_label">Usuario:</label>
                    <span class="form_line"></span>
                </div>
                <div class="form_group">
                    <input type="password" name="password" id="password" class="form_imput" placeholder=" ">
                    <label for="password" class="form_label">Contraseña:</label>
                    <span class="form_line"></span>
                </div>
                <input type="submit" class="form_submit" value="Entrar">
            </div>
        </form>

        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

    </body>
</html>

