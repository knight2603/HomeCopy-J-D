package controlador;

import Modelo.Producto;
import DAO.ProductoDao;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet(name = "InventarioServlet", urlPatterns = {"/InventarioServlet"})
public class InventarioServlet extends HttpServlet {

    ProductoDao dao = new ProductoDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("vistas/inventario.jsp");
            return;
        }

        switch (accion) {
            case "agregar":
                agregarProducto(request, response);
                break;

            case "editar":
                editarProducto(request, response);
                break;

            case "eliminar":
                eliminarProducto(request, response);
                break;

            default:
                response.sendRedirect("vistas/inventario.jsp");
        }
    }

    private void agregarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            Producto p = new Producto();
            p.setNombre(nombre);
            p.setDescripcion(descripcion);
            p.setPrecio(precio);
            p.setStock(stock);
            p.setImagen(""); // Puedes agregar imagen luego si manejas archivos
            p.setIdMarca(1); // Marca fija por ahora

            dao.agregar(p);
            response.sendRedirect("vistas/inventario.jsp?msg=agregado");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("vistas/inventario.jsp?msg=error");
        }
    }

    private void editarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int stock = Integer.parseInt(request.getParameter("stock"));

            Producto p = new Producto();
            p.setId(id);
            p.setNombre(nombre);
            p.setDescripcion(descripcion);
            p.setPrecio(precio);
            p.setStock(stock);

            dao.actualizar(p);
            response.sendRedirect("vistas/inventario.jsp?msg=editado");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("vistas/inventario.jsp?msg=error");
        }
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int idEliminar = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(idEliminar);
            response.sendRedirect("vistas/inventario.jsp?msg=eliminado");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("vistas/inventario.jsp?msg=error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Producto> productos = dao.obtenerTodos();
        request.setAttribute("productos", productos);
        request.getRequestDispatcher("vistas/inventario.jsp").forward(request, response);
    }
}
