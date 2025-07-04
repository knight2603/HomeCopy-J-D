package DAO;

import conexion.Conexion;
import java.sql.*;

public class PedidoDao {

    public boolean registrarPedido(String nombre, String email, String telefono, String direccion, String detalle, double total) {
        String sql = "INSERT INTO pedidos (nombre, email, telefono, direccion, detalle, total) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nombre);
            ps.setString(2, email);
            ps.setString(3, telefono);
            ps.setString(4, direccion);
            ps.setString(5, detalle);  // productos serializados en JSON, por ejemplo
            ps.setDouble(6, total);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("❌ Error al registrar pedido: " + e.getMessage());
            return false;
        }
    }
}
