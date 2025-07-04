package controlador;

import DAO.UsuarioDao;
import Modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    UsuarioDao dao = new UsuarioDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("actualizarPerfil".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("idUsuario"));
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");

            boolean actualizado = dao.actualizarPerfil(id, nombre, email);
            if (actualizado) {
                // También actualiza la sesión si cambia nombre/email
                Usuario u = (Usuario) request.getSession().getAttribute("usuario");
                u.setNombreUsu(nombre);
                u.setEmailUsu(email);
            }
            response.sendRedirect("vistas/settings.jsp");
        }

        if ("cambiarPassword".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("idUsuario"));
            String actual = request.getParameter("actual");
            String nueva = request.getParameter("nueva");

            boolean exito = dao.cambiarPassword(id, actual, nueva);

            if (exito) {
                response.sendRedirect("vistas/settings.jsp?mensaje=ok");
            } else {
                response.sendRedirect("vistas/settings.jsp?error=pass");
            }
        }
    }
}
