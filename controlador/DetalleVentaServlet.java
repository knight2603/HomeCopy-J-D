package controlador;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import DAO.VentasDao;
import DAO.DetalleVentaDao;
import Modelo.Ventas;
import Modelo.DetalleVenta;

@WebServlet("/DetalleVentaServlet")
public class DetalleVentaServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int idVenta = Integer.parseInt(request.getParameter("idVenta"));

            VentasDao ventasDao = new VentasDao();
            DetalleVentaDao detalleDao = new DetalleVentaDao();

            Ventas venta = ventasDao.obtenerVentaPorId(idVenta);
            List<DetalleVenta> detalles = detalleDao.obtenerPorVenta(idVenta);

            if (venta != null && detalles != null) {
                request.setAttribute("ventaDetalle", venta);
                request.setAttribute("listaDetalles", detalles);
                request.setAttribute("mostrarModal", true); // bandera para mostrar modal
            } else {
                request.setAttribute("error", "No se encontraron detalles para la venta.");
            }

        } catch (Exception e) {
            request.setAttribute("error", "Error al procesar el detalle de la venta: " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("vistas/dashboardusu.jsp");
        dispatcher.forward(request, response);
    }
}
