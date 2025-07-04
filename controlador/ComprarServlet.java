package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;

import DAO.DetalleVentaDao;
import DAO.ProductoDao;
import DAO.VentasDao;
import Modelo.DetalleVenta;
import Modelo.Producto;
import Modelo.Usuario;
import Modelo.Ventas;

@WebServlet("/ComprarServlet")
public class ComprarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Map<String, String[]> parametros = request.getParameterMap();
        List<DetalleVenta> detalles = new ArrayList<>();

        double total = 0;

        for (String key : parametros.keySet()) {
            if (key.startsWith("cantidades[")) {
                int idProducto = Integer.parseInt(key.substring(11, key.length() - 1));
                int cantidad = Integer.parseInt(parametros.get(key)[0]);

                if (cantidad > 0) {
                    Producto producto = new ProductoDao().obtenerPorId(idProducto);
                    if (producto != null) {
                        double subtotal = cantidad * producto.getPrecio();
                        total += subtotal;

                        DetalleVenta detalle = new DetalleVenta();
                        detalle.setIdProducto(idProducto);
                        detalle.setCantidad(cantidad);
                        detalle.setPrecio_unitario(producto.getPrecio());
                        detalles.add(detalle);
                    }
                }
            }
        }

        if (!detalles.isEmpty()) {
            Ventas venta = new Ventas();
            venta.setIdUsuario(usuario.getIdUsu());
            venta.setFecha(new java.util.Date());
            venta.setTotal(total);
            venta.setIdMetodo(1); // Puedes cambiar el método de pago según tu lógica

            VentasDao ventasDao = new VentasDao();
            int idVenta = ventasDao.registrarYObtenerId(venta);

            for (DetalleVenta detalle : detalles) {
                detalle.setIdVenta(idVenta);
                new DetalleVentaDao().registrarDetalle(detalle);
            }

            response.sendRedirect("vistas/productosVentas.jsp?compraExitosa=1");
        } else {
            response.sendRedirect("vistas/productosVentas.jsp?compraExitosa=0");
        }
    }
}
