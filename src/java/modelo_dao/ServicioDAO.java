package modelo_dao;

import utils.Conexion;
import java.sql.*;
import java.util.*;
import modelo_entidad.Servicio;

public class ServicioDAO {

    public List<Servicio> listar() {
        List<Servicio> lista = new ArrayList<>();
        String sql = "SELECT * FROM Servicios"; 
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Servicio s = new Servicio();
                s.setId(rs.getInt("servicio_id"));
                s.setNombre(rs.getString("nombre"));
                s.setPrecio(rs.getDouble("precio"));
                s.setCliente(rs.getString("cliente"));
                s.setDescripcion(rs.getString("descripcion"));
                s.setEstado(rs.getString("estado"));
                s.setFecha(rs.getDate("fecha"));
                lista.add(s);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar servicios: " + e.getMessage());
        }
        return lista;
    }

    // ✅ Registrar servicio
    public void registrar(Servicio s) {
        String sql = "INSERT INTO Servicios(nombre, precio, cliente, descripcion, estado, fecha) VALUES (?, ?, ?, ?, ?, ?)"; 
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getNombre());
            ps.setDouble(2, s.getPrecio());
            ps.setString(3, s.getCliente());
            ps.setString(4, s.getDescripcion());
            ps.setString(5, s.getEstado());
            ps.setDate(6, new java.sql.Date(s.getFecha().getTime()));

            ps.executeUpdate();
            System.out.println("✅ Servicio registrado correctamente");
        } catch (SQLException e) {
            System.out.println("Error al registrar servicio: " + e.getMessage());
        }
    }

    // ✅ Actualizar servicio
    public void actualizar(Servicio s) {
        String sql = "UPDATE Servicios SET nombre=?, precio=?, cliente=?, descripcion=?, estado=?, fecha=? WHERE servicio_id=?"; 
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getNombre());
            ps.setDouble(2, s.getPrecio());
            ps.setString(3, s.getCliente());
            ps.setString(4, s.getDescripcion());
            ps.setString(5, s.getEstado());
            ps.setDate(6, new java.sql.Date(s.getFecha().getTime()));
            ps.setInt(7, s.getId());

            ps.executeUpdate();
            System.out.println("✅ Servicio actualizado correctamente");
        } catch (SQLException e) {
            System.out.println("Error al actualizar servicio: " + e.getMessage());
        }
    }

    // ✅ Eliminar servicio
    public void eliminar(int id) {
        String sql = "DELETE FROM Servicios WHERE servicio_id=?"; 
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
            System.out.println("✅ Servicio eliminado correctamente");
        } catch (SQLException e) {
            System.out.println("Error al eliminar servicio: " + e.getMessage());
        }
    }
}
