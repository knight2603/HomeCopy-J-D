<%@ page import="Modelo.Usuario" %>
<%@ page import="DAO.UsuarioDao" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sesion = request.getSession(false);
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    UsuarioDao dao = new UsuarioDao();
    List<Usuario> lista = dao.listarUsuarios();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Usuarios | Papelería Creativa</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/dashboardusuarios.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
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
        <a href="users.jsp" class="active">
            <i class="fas fa-users"></i>
            <span>Usuarios</span>
        </a>
    </div>
    <div class="sidebar-footer">
        <a href="#">
            <i class="fas fa-user"></i>
            <span><%= usuario.getNombreUsu() %></span>
        </a>
        <a href="settings.jsp">
            <i class="fas fa-cog"></i>
            <span>Configuración</span>
        </a>
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
        <h1>Usuarios Registrados</h1>
    </div>

    <!-- Tabla de Usuarios -->
    <div class="recent-orders">
        <div class="table-header">
            <h2>Lista de Usuarios</h2>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Rol</th>
                </tr>
            </thead>
            <tbody>
                <% for (Usuario u : lista) { %>
                <tr>
                    <td><%= u.getIdUsu() %></td>
                    <td><%= u.getNombreUsu() %></td>
                    <td><%= u.getEmailUsu() %></td>
                    <td>
                        <%= (u.getRolUsu() == 1) ? "Administrador" :
                            (u.getRolUsu() == 2) ? "Cliente" : "Otro" %>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
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
