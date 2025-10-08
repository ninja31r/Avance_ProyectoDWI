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

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }
    
}
