package modelo_dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo_dto.DtoProducto;
import utils.Conexion;

public class ProductoDAO {

    private Connection connection;

    public ProductoDAO() {
        this.connection = Conexion.conectar();
    }

    public List<DtoProducto> listarDTO() {
        List<DtoProducto> productosDTO = new ArrayList<>();
        String sql = "SELECT * FROM Productos";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                DtoProducto dto = new DtoProducto(
                    rs.getInt("producto_id"),
                    rs.getString("nombre"),
                    rs.getInt("stock"),
                    rs.getInt("precio"),
                    rs.getString("imagen")
                );
                productosDTO.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productosDTO;
    }

    public void agregarDTO(DtoProducto dto) {
        String sql = "INSERT INTO Productos (nombre, stock, precio, imagen) VALUES (?, ?, ?, ?)";
        
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, dto.getNombre());
            ps.setInt(2, dto.getStock());
            ps.setInt(3, dto.getPrecio());
            ps.setString(4, dto.getImagen());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public boolean eliminarDTO(DtoProducto dto) {
        String sql = "DELETE FROM Productos WHERE producto_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            
            ps.setInt(1, dto.getId());
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
