package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    private static final String URL = "jdbc:mysql://164.152.40.3:3306/bd_dwi";
    private static final String USUARIO = "root";
    private static final String PASSWORD = "12345678";

    public static Connection conectar() {
        Connection conexion = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL, USUARIO, PASSWORD);
            System.out.println(" Conexión exitosa a la base de datos");
        } catch (ClassNotFoundException e) {
            System.out.println(" No se encontró el driver JDBC: " + e.getMessage());
        } catch (SQLException e) {
            System.out.println(" Error al conectar a la base de datos: " + e.getMessage());
        }

        return conexion;
    }
}
