package controlador;

import DAO.VentasDao;
import Modelo.Usuario;
import Modelo.Ventas;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "VentasServlet", urlPatterns = {"/VentasServlet"})
public class VentasServlet extends HttpServlet {

    private final VentasDao ventasDao = new VentasDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");

        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Parámetros del formulario
            String fechaStr = request.getParameter("fecha"); // formato: yyyy-MM-dd
            String totalStr = request.getParameter("total");

            // Validaciones básicas
            if (fechaStr == null || totalStr == null || totalStr.isEmpty()) {
                request.setAttribute("mensajeError", "Campos incompletos.");
                request.getRequestDispatcher("ventas/registrarVenta.jsp").forward(request, response);
                return;
            }

            Date fecha = new SimpleDateFormat("yyyy-MM-dd").parse(fechaStr);
            double total = Double.parseDouble(totalStr);

            // Crear objeto venta
            Ventas venta = new Ventas();
            venta.setIdUsuario(usuario.getIdUsu());  // obtenemos el id del usuario logueado
            venta.setFecha(fecha);
            venta.setTotal(total);

            boolean guardado = ventasDao.registrarVenta(venta);

            if (guardado) {
                request.setAttribute("mensajeExito", "✅ Venta registrada correctamente.");
            } else {
                request.setAttribute("mensajeError", "❌ Error al registrar la venta.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("mensajeError", "❌ Error al procesar la venta: " + e.getMessage());
        }

        request.getRequestDispatcher("ventas/registrarVenta.jsp").forward(request, response);
    }
}
