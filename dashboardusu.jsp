<%@ page import="Modelo.Usuario, DAO.VentasDao, Modelo.Ventas, Modelo.DetalleVenta" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sesion = request.getSession(false);
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    VentasDao dao = new VentasDao();
    List<Ventas> listaVentas = dao.obtenerVentasPorUsuario(usuario.getIdUsu());

    Modelo.Ventas ventaDetalle = (Modelo.Ventas) request.getAttribute("ventaDetalle");
    List<DetalleVenta> listaDetalles = (List<DetalleVenta>) request.getAttribute("listaDetalles");
    Boolean mostrarModal = (Boolean) request.getAttribute("mostrarModal");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Dashboard | HomeCopy J&D</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="../css/dashboardusuarios.css">

    <style>
        .modal {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            display: none;
            justify-content: center;
            align-items: center;
            background: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .modal.show {
            display: flex;
        }

        .modal-box {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            width: 90%;
            max-width: 650px;
            max-height: 85%;
            overflow-y: auto;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .modal-box table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .modal-box th, .modal-box td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: center;
        }

        .modal-box th {
            background-color: #f7f7f7;
        }

        .btn-cerrar {
            background-color: #ff4d4d;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            margin-top: 15px;
            float: right;
            cursor: pointer;
        }

        .btn-cerrar:hover {
            background-color: #e60000;
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

    <!-- Sidebar y encabezado OMITIDO por brevedad -->
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <img src="../images/download.png" alt="Logo">
            <span>HOMECOPY PAPELERIA J&D</span>
        </div>

        <div class="sidebar-menu">
            <a href="#" class="active"><i class="fas fa-home"></i><span>Dashboard</span></a>
            <a href="productosVentas.jsp"><i class="fas fa-shopping-cart"></i><span>Productos</span></a>
        </div>

        <div class="sidebar-footer">
            <a href="#"><i class="fas fa-user"></i><span><%= usuario.getNombreUsu()%></span></a>
            <a href="configuracion.jsp"><i class="fas fa-cog"></i><span>Configuración</span></a>
            
                        <a href="#" onclick="confirmarCerrarSesion(event)">
                <i class="fas fa-sign-out-alt"></i>
                <span>Cerrar Sesión</span>
            </a>
        </div>
    </div>



<div class="main-content">
            <div class="header">
            <h1>Bienvenido, <%= usuario.getNombreUsu() %></h1>
            
            <div class="user-actions">
            </div>
        </div>
    <div class="recent-orders">
        <h2>Mis Órdenes</h2>
        <table>
            <thead>
                <tr>
                    <th>N° Pedido</th>
                    <th>Fecha</th>
                    <th>Total</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% if (listaVentas != null && !listaVentas.isEmpty()) {
                    for (Ventas v : listaVentas) { %>
                    <tr>
                        <td>#VENTA-<%= v.getIdVenta() %></td>
                        <td><%= v.getFecha() %></td>
                        <td>$<%= v.getTotal() %></td>
                        <td><span class="status status-completed">Completado</span></td>
                    </tr>
                <% } } else { %>
                    <tr><td colspan="4">No tienes órdenes registradas aún.</td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal de Detalle de Factura -->
<div id="modalFactura" class="modal <%= (mostrarModal != null && mostrarModal) ? "show" : "" %>">
    <div class="modal-box">
        <h2>Factura - Venta #<%= ventaDetalle != null ? ventaDetalle.getIdVenta() : "" %></h2>
        <p><strong>Fecha:</strong> <%= ventaDetalle != null ? ventaDetalle.getFecha() : "" %></p>

        <table>
            <thead>
                <tr>
                    <th>Producto</th>
                    <th>Cantidad</th>
                    <th>Precio Unitario</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <% if (listaDetalles != null) {
                    for (DetalleVenta d : listaDetalles) { %>
                    <tr>
                        <td><%= d.getNombre() %></td>
                        <td><%= d.getCantidad() %></td>
                        <td>$<%= d.getPrecio_unitario() %></td>
                        <td>$<%= d.getCantidad() * d.getPrecio_unitario() %></td>
                    </tr>
                <% } } %>
            </tbody>
        </table>

        <p style="text-align:right;"><strong>Total: $<%= ventaDetalle != null ? ventaDetalle.getTotal() : "" %></strong></p>

        <form method="get" action="dashboardusu.jsp">
            <button type="submit" class="btn-cerrar">Cerrar</button>
        </form>
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
