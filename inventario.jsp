<%@ page import="Modelo.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.Producto" %>
<%@ page import="DAO.ProductoDao" %>

<%
    HttpSession sesion = request.getSession(false);
    Usuario usuario = (Usuario) sesion.getAttribute("usuario");

    if (usuario == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    ProductoDao dao = new ProductoDao();
    List<Producto> lista = dao.obtenerTodos();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inventario |</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="../css/dashboardusuarios.css">
    <style>
        .modal {
            position: fixed; top: 0; left: 0;
            width: 100%; height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex; align-items: center; justify-content: center;
            z-index: 1000;
        }
        .modal-content {
            background: white;
            padding: 20px;
            border-radius: 10px;
            width: 400px;
        }
        .modal.hidden {
            display: none;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
        }
        .form-buttons {
            display: flex;
            justify-content: space-between;
        }
        .btn-edit {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 5px 10px;
            margin-right: 5px;
            cursor: pointer;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
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
    <%
    String msg = request.getParameter("msg");
%>
<script>
    <% if ("agregado".equals(msg)) { %>
    Swal.fire({
        icon: 'success',
        title: '¡Producto agregado!',
        text: 'El producto ha sido registrado correctamente.',
        timer: 2000,
        showConfirmButton: false
    });
    <% } else if ("editado".equals(msg)) { %>
    Swal.fire({
        icon: 'info',
        title: '¡Producto actualizado!',
        text: 'Los datos se han guardado exitosamente.',
        timer: 2000,
        showConfirmButton: false
    });
    <% } else if ("eliminado".equals(msg)) { %>
    Swal.fire({
        icon: 'warning',
        title: '¡Producto eliminado!',
        text: 'El producto ha sido eliminado correctamente.',
        timer: 2000,
        showConfirmButton: false
    });
    <% } %>
</script>


<<!-- Sidebar -->
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
        <a href="inventario.jsp" class="active">
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
        <h1>Inventario de Productos</h1>
        <div class="user-actions">
            <!-- ... -->
        </div>
    </div>

    <div class="recent-orders">
        <div class="table-header">
            <h2>Lista de Productos</h2>
            <button class="btn btn-outline" onclick="abrirModalAgregar()">Agregar</button>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Acción</th>
                </tr>
            </thead>
            <tbody>
                <% for (Producto p : lista) { %>
                <tr>
                    <td><%= p.getId() %></td>
                    <td><%= p.getNombre() %></td>
                    <td><%= p.getDescripcion() %></td>
                    <td>$<%= p.getPrecio() %></td>
                    <td><%= p.getStock() %></td>
<td>
    <button class="btn-edit" 
        onclick="abrirModalEditar(<%= p.getId() %>, '<%= p.getNombre() %>', '<%= p.getDescripcion() %>', <%= p.getPrecio() %>, <%= p.getStock() %>)">
        Editar
    </button>

    <button type="button" class="btn-delete" onclick="confirmarEliminar(<%= p.getId() %>)">
        Eliminar
    </button>
</td>

                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal Agregar -->
<div id="modalAgregar" class="modal hidden">
    <div class="modal-content">
        <h2>Agregar Producto</h2>
        <form action="../InventarioServlet" method="post">
            <input type="hidden" name="accion" value="agregar">
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" name="nombre" id="nombre" required>
            </div>
            <div class="form-group">
                <label for="descripcion">Descripción:</label>
                <input type="text" name="descripcion" id="descripcion" required>
            </div>
            <div class="form-group">
                <label for="precio">Precio:</label>
                <input type="number" name="precio" id="precio" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="stock">Stock:</label>
                <input type="number" name="stock" id="stock" required>
            </div>
            <div class="form-buttons">
                <button type="submit" class="btn btn-primary">Guardar</button>
                <button type="button" class="btn btn-secondary" onclick="cerrarModalAgregar()">Cancelar</button>
            </div>
        </form>
    </div>
</div>

<!-- Modal Editar -->
<div id="modalEditar" class="modal hidden">
    <div class="modal-content">
        <h2>Editar Producto</h2>
        <form action="../InventarioServlet" method="post">
            <input type="hidden" name="accion" value="editar">
            <input type="hidden" name="id" id="editarId">
            <div class="form-group">
                <label for="editarNombre">Nombre:</label>
                <input type="text" name="nombre" id="editarNombre" required>
            </div>
            <div class="form-group">
                <label for="editarDescripcion">Descripción:</label>
                <input type="text" name="descripcion" id="editarDescripcion" required>
            </div>
            <div class="form-group">
                <label for="editarPrecio">Precio:</label>
                <input type="number" name="precio" id="editarPrecio" step="0.01" required>
            </div>
            <div class="form-group">
                <label for="editarStock">Stock:</label>
                <input type="number" name="stock" id="editarStock" required>
            </div>
            <div class="form-buttons">
                <button type="submit" class="btn btn-primary">Actualizar</button>
                <button type="button" class="btn btn-secondary" onclick="cerrarModalEditar()">Cancelar</button>
            </div>
        </form>
    </div>
</div>

<script>
    function abrirModalAgregar() {
        document.getElementById('modalAgregar').classList.remove('hidden');
    }
    function cerrarModalAgregar() {
        document.getElementById('modalAgregar').classList.add('hidden');
    }

    function abrirModalEditar(id, nombre, descripcion, precio, stock) {
        document.getElementById('editarId').value = id;
        document.getElementById('editarNombre').value = nombre;
        document.getElementById('editarDescripcion').value = descripcion;
        document.getElementById('editarPrecio').value = precio;
        document.getElementById('editarStock').value = stock;
        document.getElementById('modalEditar').classList.remove('hidden');
    }
    function cerrarModalEditar() {
        document.getElementById('modalEditar').classList.add('hidden');
    }
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
    function confirmarEliminar(id) {
        Swal.fire({
            title: '¿Estás seguro?',
            text: "Esta acción no se puede deshacer.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Sí, eliminar',
            cancelButtonText: 'Cancelar'
        }).then((result) => {
            if (result.isConfirmed) {
                // Crear y enviar el formulario de eliminación
                const form = document.createElement('form');
                form.method = 'post';
                form.action = '../InventarioServlet';

                const accionInput = document.createElement('input');
                accionInput.type = 'hidden';
                accionInput.name = 'accion';
                accionInput.value = 'eliminar';
                form.appendChild(accionInput);

                const idInput = document.createElement('input');
                idInput.type = 'hidden';
                idInput.name = 'id';
                idInput.value = id;
                form.appendChild(idInput);

                document.body.appendChild(form);
                form.submit();
            }
        });
    }
</script>
</body>
</html>
