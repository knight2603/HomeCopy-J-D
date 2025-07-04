package DAO;

import Modelo.Ventas;
import java.sql.*;
import java.util.*;
import conexion.Conexion;

public class VentasDao {

    // ✅ Obtener ventas por usuario
    public List<Ventas> obtenerVentasPorUsuario(int idUsuario) {
        List<Ventas> lista = new ArrayList<>();
        String sql = "SELECT id_venta, id_usuario, id_metodo, fecha, total FROM ventas WHERE id_usuario = ? ORDER BY fecha DESC";

        try (Connection conn = Conexion.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ventas v = new Ventas();
                v.setIdVenta(rs.getInt("id_venta"));
                v.setIdUsuario(rs.getInt("id_usuario"));
                v.setIdMetodo(rs.getInt("id_metodo"));
                v.setFecha(rs.getDate("fecha"));
                v.setTotal(rs.getDouble("total"));
                lista.add(v);
            }

        } catch (SQLException e) {
            System.out.println("❌ Error al obtener ventas: " + e.getMessage());
        }

        return lista;
    }

    // ✅ Registrar nueva venta
    public boolean registrarVenta(Ventas venta) {
        String sql = "INSERT INTO ventas (id_usuario, id_metodo, fecha, total) VALUES (?, ?, ?, ?)";

        try (Connection conn = Conexion.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, venta.getIdUsuario());
            ps.setInt(2, venta.getIdMetodo());

            if (venta.getFecha() != null) {
                ps.setDate(3, new java.sql.Date(venta.getFecha().getTime()));
            } else {
                ps.setDate(3, new java.sql.Date(System.currentTimeMillis())); // Fecha actual si es null
            }

            ps.setDouble(4, venta.getTotal());

            int filas = ps.executeUpdate();
            System.out.println("✅ Venta registrada con éxito.");
            return filas > 0;

        } catch (SQLException e) {
            System.out.println("❌ Error al registrar venta: " + e.getMessage());
            return false;
        }
    }

    // ✅ Obtener una venta específica por su ID
    public Ventas obtenerVentaPorId(int idVenta) {
        Ventas venta = null;
        String sql = "SELECT * FROM ventas WHERE id_venta = ?";

        try (Connection conn = Conexion.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idVenta);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                venta = new Ventas();
                venta.setIdVenta(rs.getInt("id_venta"));
                venta.setIdUsuario(rs.getInt("id_usuario"));
                venta.setIdMetodo(rs.getInt("id_metodo"));
                venta.setFecha(rs.getDate("fecha"));
                venta.setTotal(rs.getDouble("total"));
            }

        } catch (SQLException e) {
            System.out.println("❌ Error al obtener venta por ID: " + e.getMessage());
        }

        return venta;
    }

    // ❌ Este método está duplicado y no se usa, así que lo eliminamos
    /*
    public boolean agregarVenta(Ventas venta) {
        throw new UnsupportedOperationException("Método no implementado");
    }
    */

    public int registrarYObtenerId(Ventas venta) {
    int idGenerado = -1;
    String sql = "INSERT INTO ventas (id_usuario, id_metodo, fecha, total) VALUES (?, ?, ?, ?)";

    try (Connection conn = Conexion.conectar();
         PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

        ps.setInt(1, venta.getIdUsuario());
        ps.setInt(2, venta.getIdMetodo());
        ps.setDate(3, new java.sql.Date(venta.getFecha().getTime()));
        ps.setDouble(4, venta.getTotal());

        int filas = ps.executeUpdate();
        if (filas > 0) {
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                idGenerado = rs.getInt(1);
            }
        }
    } catch (SQLException e) {
        System.out.println("❌ Error al registrar venta: " + e.getMessage());
    }

    return idGenerado;
}

}
