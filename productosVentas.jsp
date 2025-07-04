<%@ page import="java.util.List" %>
<%@ page import="Modelo.Producto" %>
<%@ page import="DAO.ProductoDao" %>
<%@ page import="Modelo.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession sesion = request.getSession(false);
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    ProductoDao dao = new ProductoDao();
    List<Producto> listaProductos = dao.obtenerTodos();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Comprar Productos</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
<body class="flex font-sans bg-gray-100">

<!-- Sidebar -->
<div class="w-64 min-h-screen bg-blue-900 text-white flex flex-col justify-between">
    <div>
        <div class="p-6 flex items-center gap-3 border-b border-blue-700">
            <img src="../images/download.png" alt="Logo" class="w-10 h-10">
            <h1 class="text-lg font-semibold">HomeCopy J&D</h1>
        </div>
        <nav class="flex flex-col p-4 space-y-2">
            <a href="dashboardusu.jsp" class="hover:bg-blue-700 px-4 py-2 rounded transition">
                <i class="fas fa-home mr-2"></i>Dashboard
            </a>
            <a href="#" class="bg-blue-700 px-4 py-2 rounded">
                <i class="fas fa-shopping-cart mr-2"></i>Productos
            </a>
            <a href="configuracion.jsp"><i class="fas fa-cog"></i><span>Configuración</span></a>
        </nav>
    </div>
    <div class="p-4 border-t border-blue-700">
        <p class="mb-2 flex items-center gap-2">
            <i class="fas fa-user"></i>
            <%= usuario.getNombreUsu() %>
        </p>
        <a href="#" onclick="confirmarCerrarSesion(event)" class="flex items-center gap-2 hover:bg-blue-700 px-4 py-2 rounded transition">
            <i class="fas fa-sign-out-alt"></i>
            <span>Cerrar Sesión</span>
        </a>
    </div>
</div>


<!-- Main Content -->
<div class="flex-1 p-10">
<div class="header">
            <h1>Bienvenido, <%= usuario.getNombreUsu() %></h1>
            
            <div class="user-actions">
            </div>
    <h2 class="text-2xl font-bold mb-6 text-gray-800">Catálogo de Productos</h2>

    <form method="post" action="../ComprarServlet">
        <div class="overflow-x-auto bg-white shadow-md rounded-lg">
            <table class="min-w-full text-center text-sm">
                <thead class="bg-blue-600 text-white">
                    <tr>
                        <th class="p-4">Producto</th>
                        <th class="p-4">Descripción</th>
                        <th class="p-4">Precio</th>
                        <th class="p-4">Disponible</th>
                        <th class="p-4">Cantidad</th>
                    </tr>
                </thead>
                <tbody class="text-gray-700">
                    <% for (Producto p : listaProductos) { %>
                        <tr class="border-t">
                            <td class="p-3 font-medium"><%= p.getNombre() %></td>
                            <td class="p-3"><%= p.getDescripcion() %></td>
                            <td class="p-3">$<%= p.getPrecio() %></td>
                            <td class="p-3"><%= p.getStock() %></td>
                            <td class="p-3">
                                <input type="number" name="cantidades[<%= p.getId() %>]" min="0" max="<%= p.getStock() %>" class="w-20 px-2 py-1 border rounded text-center">
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="mt-6 text-center">
            <button type="submit" class="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded text-lg font-semibold transition">Realizar Compra</button>
        </div>
    </form>

    <% if (request.getParameter("compraExitosa") != null) { 
        String success = request.getParameter("compraExitosa");
        if ("1".equals(success)) { %>
            <script>
                Swal.fire({
                    icon: 'success',
                    title: '¡Compra realizada!',
                    text: 'Tu compra fue registrada exitosamente.',
                    confirmButtonColor: '#3085d6'
                });
            </script>
        <% } else { %>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'No seleccionaste ningún producto válido.',
                    confirmButtonColor: '#d33'
                });
            </script>
        <% } 
    } %>
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
