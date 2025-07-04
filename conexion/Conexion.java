package conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    private static final String url = "jdbc:mysql://localhost:3306/homecopy";
    private static final String user = "root";
    private static final String pass = "";

    public static Connection conectar() {  // ✅ ¡Método ahora es estático!
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, user, pass);
            System.out.println("✅ Conexión exitosa a la base de datos");
            return conn;
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("❌ Error al conectar a la base de datos: " + e.getMessage());
            return null;
        }
    }
}

