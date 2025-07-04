package controlador;

import DAO.UsuarioDao;
import Modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "RegistrarUsuario", urlPatterns = {"/RegistrarUsuario"})
public class RegistrarUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validación básica de campos vacíos
        if (nombre == null || email == null || password == null ||
            nombre.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            
            request.setAttribute("fail", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Crear objeto Usuario
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombreUsu(nombre.trim());
        nuevoUsuario.setEmailUsu(email.trim());
        nuevoUsuario.setPassword(password.trim());
        nuevoUsuario.setRolUsu(2); // Rol cliente por defecto

        // Intentar registrar
        UsuarioDao dao = new UsuarioDao();
        boolean registrado = dao.registrarUsuario(nuevoUsuario);

        if (registrado) {
            System.out.println("✅ Usuario registrado correctamente.");
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("fail", "Error al registrar usuario. Intenta nuevamente.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
