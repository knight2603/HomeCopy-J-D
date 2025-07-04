<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
    <title>Login</title>
</head>
<body>
    <a href="index.jsp" class="volver">Volver</a>

    <div class="container">
        <form action="ValidarUsuario" method="POST">
            <h1>Iniciar Sesión</h1>
            <p>Ingrese sus credenciales para acceder</p>

            <!-- Campo de correo -->
            <div class="form-group">
                <label for="correo">Correo electrónico</label>
                <input type="email" id="correo" name="email" required placeholder="ejemplo@correo.com">
            </div>

            <!-- Campo de contraseña -->
            <div class="form-group">
                <label for="contrasena">Contraseña</label>
                <div class="password-container">
                    <input type="password" id="contrasena" name="pass" required placeholder="Ingrese su contraseña">
                    <span class="toggle-password" id="togglePassword">👁️</span>
                </div>
                <a href="forgetpassword.html" class="forgot-password">Olvidé mi contraseña</a>
            </div>

            <!-- Campo oculto para enviar acción -->
            <input type="hidden" name="accion" value="Ingresar">

            <!-- Mostrar mensaje de error si existe -->
            <%
                String failMsg = (String) request.getAttribute("fail");
                if (failMsg != null) {
            %>
                <div style="color: red; margin-top: 10px;">
                    <%= failMsg %>
                </div>
            <%
                }
            %>

            <button type="submit">Iniciar sesión</button>
        </form>
    </div>

    <script src="js/login-unificado.js"></script>
</body>
</html>
