package DAO;

import Modelo.Usuario;
import java.sql.*;
import conexion.Conexion;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDao {

    // Validar usuario por email y contraseña
    public Usuario validar(String email, String pass) {
        Usuario obj_usu = null;
        String sql = "SELECT * FROM usuarios WHERE email = ? AND contrasena = ?";

        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, pass);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    obj_usu = new Usuario();
                    obj_usu.setIdUsu(rs.getInt("id_usuario"));
                    obj_usu.setNombreUsu(rs.getString("nombre"));
                    obj_usu.setEmailUsu(rs.getString("email"));
                    obj_usu.setPassword(rs.getString("contrasena"));
                    obj_usu.setRolUsu(rs.getInt("id_rol"));
                }
            }
        } catch (SQLException e) {
            System.out.println("⚠️ Error al validar usuario: " + e.getMessage());
        }

        return obj_usu;
    }

    // Registrar nuevo usuario
    public boolean registrarUsuario(Usuario nuevoUsuario) {
        String sql = "INSERT INTO usuarios (nombre, email, contrasena, id_rol) VALUES (?, ?, ?, ?)";

        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nuevoUsuario.getNombreUsu());
            ps.setString(2, nuevoUsuario.getEmailUsu());
            ps.setString(3, nuevoUsuario.getPassword());
            ps.setInt(4, nuevoUsuario.getRolUsu());

            int filas = ps.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            System.out.println("❌ Error al registrar usuario: " + e.getMessage());
            return false;
        }
    }

    // Listar todos los usuarios
    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";

        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsu(rs.getInt("id_usuario"));
                u.setNombreUsu(rs.getString("nombre"));
                u.setEmailUsu(rs.getString("email"));
                u.setPassword(rs.getString("contrasena"));
                u.setRolUsu(rs.getInt("id_rol"));
                lista.add(u);
            }

        } catch (SQLException e) {
            System.out.println("❌ Error al listar usuarios: " + e.getMessage());
        }

        return lista;
    }

    // ✅ (1) Actualizar nombre y correo del perfil
    public boolean actualizarPerfil(int idUsuario, String nombre, String email) {
        String sql = "UPDATE usuarios SET nombre = ?, email = ? WHERE id_usuario = ?";
        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, email);
            ps.setInt(3, idUsuario);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("❌ Error al actualizar perfil: " + e.getMessage());
            return false;
        }
    }

    // ✅ (2) Cambiar contraseña con validación de la actual
    public boolean cambiarPassword(int idUsuario, String actual, String nueva) {
        String sql = "SELECT contrasena FROM usuarios WHERE id_usuario = ?";

        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String passActual = rs.getString("contrasena");

                if (passActual.equals(actual)) {
                    String update = "UPDATE usuarios SET contrasena = ? WHERE id_usuario = ?";
                    try (PreparedStatement ps2 = conn.prepareStatement(update)) {
                        ps2.setString(1, nueva);
                        ps2.setInt(2, idUsuario);
                        return ps2.executeUpdate() > 0;
                    }
                }
            }

        } catch (SQLException e) {
            System.out.println("❌ Error al cambiar contraseña: " + e.getMessage());
        }

        return false;
    }

    // ✅ (3) Actualizar contraseña por email (ej. recuperación de cuenta)
    public boolean actualizarPassword(String email, String password) {
        String sql = "UPDATE usuarios SET contrasena = ? WHERE email = ?";
        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, password);
            ps.setString(2, email);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("❌ Error al actualizar contraseña: " + e.getMessage());
            return false;
        }
    }

    // ✅ (4) Contar todos los usuarios (para dashboard admin)
    public int obtenerCantidadUsuarios() {
        String sql = "SELECT COUNT(*) FROM usuarios";

        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println("❌ Error al contar usuarios: " + e.getMessage());
        }

        return 0;
    }

    // ✅ (5) Buscar usuario por ID (útil para editar perfil o admin)
    public Usuario buscarPorId(int idUsuario) {
        Usuario usuario = null;
        String sql = "SELECT * FROM usuarios WHERE id_usuario = ?";

        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsu(rs.getInt("id_usuario"));
                usuario.setNombreUsu(rs.getString("nombre"));
                usuario.setEmailUsu(rs.getString("email"));
                usuario.setPassword(rs.getString("contrasena"));
                usuario.setRolUsu(rs.getInt("id_rol"));
            }

        } catch (SQLException e) {
            System.out.println("❌ Error al buscar usuario por ID: " + e.getMessage());
        }

        return usuario;
    }
}
