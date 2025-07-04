<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>¿Olvidaste tu Contraseña?</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/forgetpassword.css">
</head>
<body>

    <div class="logo">
        <img src="images/download.png" alt="Logo">
        <button class="btn"><a href="login.jsp">Volver</a></button>
    </div>

    <div class="container">
        <h1>¿Olvidaste tu Contraseña?</h1>
        <p>Ingresa tu correo electrónico y tu nueva contraseña.</p>

        <!-- ✅ Bloque para mostrar mensajes -->
        <%
            String error = (String) request.getAttribute("error");
            String exito = (String) request.getAttribute("exito");
            if (error != null) {
        %>
            <div style="color: red; margin-bottom: 15px;"><%= error %></div>
        <% } else if (exito != null) { %>
            <div style="color: green; margin-bottom: 15px;"><%= exito %></div>
        <% } %>

        <form id="password-form" action="RecuperarPassword" method="POST">
            <label for="email">Correo:</label>
            <div class="custom-input">
                <input type="email" name="email" placeholder="Correo Electrónico" required>
            </div>
        
            <label for="password">Contraseña nueva:</label>
            <div class="custom-input">
                <input type="password" id="password" name="password" placeholder="Contraseña" required>
            </div>
        
            <label for="password2">Confirme su contraseña:</label>
            <div class="custom-input">
                <input type="password" id="password2" name="password2" placeholder="Confirmar contraseña" required>
            </div>
        
            <button type="submit" class="Change">Cambiar</button>
        </form>
    </div>

    <script src="js/forgetpassword.js"></script>
</body>
</html>
