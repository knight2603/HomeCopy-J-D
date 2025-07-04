package controlador;

import DAO.UsuarioDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/SettingsController")
public class SettingsController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession();
        int idUsuario = (int) session.getAttribute("id");  // Asegúrate de guardar el ID en sesión al iniciar

        String tipo = request.getParameter("tipo");

        UsuarioDao dao = new UsuarioDao();
        boolean resultado = false;
        String mensaje = "";

        if ("perfil".equals(tipo)) {
            String nombre = request.getParameter("name");
            String email = request.getParameter("email");
            resultado = dao.actualizarPerfil(idUsuario, nombre, email);
            mensaje = resultado ? "Perfil actualizado correctamente." : "Error al actualizar el perfil.";

        } else if ("password".equals(tipo)) {
            String actual = request.getParameter("currentPassword");
            String nueva = request.getParameter("newPassword");
            String confirmar = request.getParameter("confirmPassword");

            if (!nueva.equals(confirmar)) {
                mensaje = "Las nuevas contraseñas no coinciden.";
            } else {
                resultado = dao.cambiarPassword(idUsuario, actual, nueva);
                mensaje = resultado ? "Contraseña cambiada correctamente." : "Error: contraseña actual incorrecta.";
            }
        }

        request.setAttribute("mensaje", mensaje);
        request.getRequestDispatcher("settings.jsp").forward(request, response);
    }
}
