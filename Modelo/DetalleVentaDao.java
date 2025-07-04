package DAO;

import Modelo.DetalleVenta;
import conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DetalleVentaDao {

    public List<DetalleVenta> obtenerPorVenta(int idVenta) {
        List<DetalleVenta> lista = new ArrayList<>();
        String sql = """
            SELECT d.id_detalle, d.id_venta, d.id_producto, d.cantidad, d.precio_unitario, p.nombre
            FROM detalle_venta d
            JOIN productos p ON d.id_producto = p.id_producto
            WHERE d.id_venta = ?
        """;

        try (Connection conn = Conexion.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idVenta);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DetalleVenta dv = new DetalleVenta();
                dv.setIdDetalle(rs.getInt("id_detalle"));
                dv.setIdVenta(rs.getInt("id_venta"));
                dv.setIdProducto(rs.getInt("id_producto"));
                dv.setCantidad(rs.getInt("cantidad"));
                dv.setPrecio_unitario(rs.getDouble("precio_unitario"));
                dv.setNombre(rs.getString("nombre")); // nombre del producto

                lista.add(dv);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

public boolean registrarDetalle(DetalleVenta detalle) {
    String sql = "INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES (?, ?, ?, ?)";

    try (Connection conn = Conexion.conectar();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, detalle.getIdVenta());
        ps.setInt(2, detalle.getIdProducto());
        ps.setInt(3, detalle.getCantidad());
        ps.setDouble(4, detalle.getPrecio_unitario());

        return ps.executeUpdate() > 0;

    } catch (SQLException e) {
        System.out.println("❌ Error al registrar detalle de venta: " + e.getMessage());
        return false;
    }
}

}
