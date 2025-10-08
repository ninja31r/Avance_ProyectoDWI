package modelo_dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo_entidad.Producto;
import utils.Conexion;

public class ProductoDAO {

    private Connection connection;

    public ProductoDAO() {
        this.connection = Conexion.conectar();
    }

    public List<Producto> listar() {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM Productos";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setId(rs.getInt("producto_id"));
                producto.setNombre(rs.getString("nombre"));
                producto.setStock(rs.getInt("stock"));
                producto.setPrecio(rs.getInt("precio"));
                producto.setImagen(rs.getString("imagen"));
                productos.add(producto);
            }
            System.out.println("listado productos "+ productos.size());

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }

    public boolean agregar(Producto p) {
        String sql = "INSERT INTO Productos (nombre, stock, precio, imagen) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, p.getNombre());
            ps.setInt(2, p.getStock());
            ps.setInt(3, p.getPrecio());
            ps.setString(4, p.getImagen());
            int filas = ps.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean eliminar(int id) {
        String sql = "DELETE FROM Productos WHERE producto_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            int filas = ps.executeUpdate();
            return filas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
