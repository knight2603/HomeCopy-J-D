package controlador;

import DAO.UsuarioDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/RecuperarPassword")
public class RecuperarPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String password2 = request.getParameter("password2");

        if (!password.equals(password2)) {
            // Redirigir con error si las contraseñas no coinciden
            request.setAttribute("error", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("forgetpassword.jsp").forward(request, response);
            return;
        }

        UsuarioDao usuarioDao = new UsuarioDao();
        boolean actualizada = usuarioDao.actualizarPassword(email, password);

        if (actualizada) {
            // Redirigir al login con mensaje de éxito
            response.sendRedirect("login.jsp?mensaje=Password actualizada correctamente");
        } else {
            // Redirigir con error si no se pudo actualizar
            request.setAttribute("error", "No se pudo actualizar la contraseña. Verifica tu correo.");
            request.getRequestDispatcher("forgetpassword.jsp").forward(request, response);
        }
    }
}
