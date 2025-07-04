package controlador;

import DAO.UsuarioDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import Modelo.Usuario;

@WebServlet(name = "ValidarUsuario", urlPatterns = {"/ValidarUsuario"})
public class ValidarUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null || !accion.equalsIgnoreCase("Ingresar")) {
            request.setAttribute("fail", "Ingrese Usuario y Contraseña.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Obtener credenciales del formulario
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");

        System.out.println("➡️ Validando usuario: " + email);

        UsuarioDao usuarioDao = new UsuarioDao();
        Usuario usuario = null;

        usuario = usuarioDao.validar(email, pass);

        if (usuario != null && usuario.getEmailUsu() != null) {
            int rol = usuario.getRolUsu();

            // ✅ Crear o recuperar la sesión
            HttpSession sesion = request.getSession(true);
            sesion.setAttribute("usuario", usuario);  // Guardar usuario en sesión

            // ✅ Redirección según el rol
            if (rol == 1) {
                System.out.println("✅ Usuario autenticado como ADMIN.");
                response.sendRedirect("vistas/I_admin.jsp");
            } else if (rol == 2) {
                System.out.println("✅ Usuario autenticado como USUARIO.");
                response.sendRedirect("vistas/dashboardusu.jsp");
            } else {
                System.out.println("❗ Rol no reconocido: " + rol);
                request.setAttribute("fail", "Rol de usuario no reconocido.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            // ❌ Credenciales incorrectas
            System.out.println("❌ Credenciales inválidas.");
            request.setAttribute("fail", "Usuario o contraseña incorrectos.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}