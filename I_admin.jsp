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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | HomeCopy J&D</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="../css/dashboardusuarios.css">
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
            <a href="#" class="active">
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
             <a href="#" onclick="confirmarCerrarSesion(event)">
               <i class="fas fa-sign-out-alt"></i>
                <span>Cerrar Sesión</span>
            </a>

        </div>
    </div>
    
    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <h1>Bienvenido, <%= usuario.getNombreUsu() %></h1>
            
            <div class="user-actions">
            </div>
        </div>
        
        <!-- Cards -->
        <div class="cards">
            <div class="card">
                <div class="card-header">
                    <div>
                        <div class="card-title">Pedidos Activos</div>
                        <div class="card-value">5</div>
                        <div class="card-text">+2 esta semana</div>
                    </div>
                    <div class="card-icon bg-primary">
                        <i class="fas fa-boxes"></i>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <div>
                        <div class="card-title">Gastos Totales</div>
                        <div class="card-value">$1,250.00</div>
                        <div class="card-text">+$150 este mes</div>
                    </div>
                    <div class="card-icon bg-secondary">
                        <i class="fas fa-receipt"></i>
                    </div>
                </div>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <div>
                        <div class="card-title">Productos Favoritos</div>
                        <div class="card-value">12</div>
                        <div class="card-text">3 en oferta</div>
                    </div>
                    <div class="card-icon bg-success">
                        <i class="fas fa-heart"></i>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Recent Orders -->
        <div class="recent-orders">
            <div class="table-header">
                <h2>Pedidos Recientes</h2>
                <button class="btn btn-outline">Ver todos</button>
            </div>
            
            <table>
                <thead>
                    <tr>
                        <th>N° Pedido</th>
                        <th>Fecha</th>
                        <th>Productos</th>
                        <th>Total</th>
                        <th>Estado</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>#PC-2548</td>
                        <td>15/06/2023</td>
                        <td>5 artículos</td>
                        <td>$375.50</td>
                        <td><span class="status status-completed">Completado</span></td>
                        <td><button class="btn btn-primary">Ver</button></td>
                    </tr>
                    <tr>
                        <td>#PC-2519</td>
                        <td>10/06/2023</td>
                        <td>3 artículos</td>
                        <td>$145.75</td>
                        <td><span class="status status-completed">Completado</span></td>
                        <td><button class="btn btn-primary">Ver</button></td>
                    </tr>
                    <tr>
                        <td>#PC-2493</td>
                        <td>05/06/2023</td>
                        <td>8 artículos</td>
                        <td>$420.00</td>
                        <td><span class="status status-processing">En proceso</span></td>
                        <td><button class="btn btn-primary">Ver</button></td>
                    </tr>
                    <tr>
                        <td>#PC-2476</td>
                        <td>02/06/2023</td>
                        <td>2 artículos</td>
                        <td>$89.90</td>
                        <td><span class="status status-pending">Pendiente</span></td>
                        <td><button class="btn btn-primary">Ver</button></td>
                    </tr>
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
