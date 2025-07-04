<%@ page import="Modelo.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sesion = request.getSession(false);
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Configuración | </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="../css/dashboardusuarios.css">
    <style>
        .settings-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .settings-container h2 {
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            font-weight: 600;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        button {
            background-color: #3498db;
            color: #fff;
            padding: 10px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #2980b9;
        }
        .form-section {
            margin-bottom: 40px;
        }     
    .swal2-confirm {
        background-color: #3085d6 !important;
    }
    .swal2-cancel {
        background-color: #d33 !important;
    }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-header">
        <img src="../images/download.png" alt="Logo">
        <span>HOMECOPY PAPELERIA j&D</span>
    </div>
    <div class="sidebar-menu">
        <a href="I_admin.jsp">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="inventario.jsp">
            <i class="fas fa-box"></i>
            <span>Inventario</span>
        </a>
        <a href="users.jsp">
            <i class="fas fa-users"></i>
            <span>Usuarios</span>
        </a>
        <a href="settings.jsp" class="active">
            <i class="fas fa-cog"></i>
            <span>Configuración</span>
        </a>
    </div>
    <div class="sidebar-footer">
        <a href="#">
            <i class="fas fa-user"></i>
            <span><%= usuario.getNombreUsu() %></span>
        </a>
            <a href="#" onclick="confirmarCerrarSesion(event)">
                <i class="fas fa-sign-out-alt"></i>
                <span>Cerrar Sesión</span>
            </a>
    </div>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="header">
        <h1>Configuración de Cuenta</h1>
    </div>

    <div class="settings-container">
        <!-- Actualizar nombre y correo -->
        <div class="form-section">
            <h2>Actualizar Información</h2>
            <form action="../UsuarioServlet" method="post">
                <input type="hidden" name="accion" value="actualizarPerfil">
                <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsu() %>">

                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" value="<%= usuario.getNombreUsu() %>" required>
                </div>

                <div class="form-group">
                    <label for="email">Correo:</label>
                    <input type="email" id="email" name="email" value="<%= usuario.getEmailUsu() %>" required>
                </div>

                <button type="submit">Actualizar</button>
            </form>
        </div>

        <!-- Cambiar contraseña -->
        <div class="form-section">
            <h2>Cambiar Contraseña</h2>
            <form action="../UsuarioServlet" method="post">
                <input type="hidden" name="accion" value="cambiarPassword">
                <input type="hidden" name="idUsuario" value="<%= usuario.getIdUsu() %>">

                <div class="form-group">
                    <label for="actual">Contraseña Actual:</label>
                    <input type="password" id="actual" name="actual" required>
                </div>

                <div class="form-group">
                    <label for="nueva">Nueva Contraseña:</label>
                    <input type="password" id="nueva" name="nueva" required>
                </div>

                <button type="submit">Cambiar Contraseña</button>
            </form>
        </div>
    </div>
</div>
                            <script>
    function confirmarCerrarSesion(event) {
        event.preventDefault(); // evita la redirección inmediata

        Swal.fire({
            title: '¿Estás seguro?',
            text: "¿Deseas cerrar sesión?",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Sí, cerrar sesión',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Redirige al cerrar sesión
                window.location.href = '../login.jsp';
            }
        });
    }
            </script>
</body>
</html>
