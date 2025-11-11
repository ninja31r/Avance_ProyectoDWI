package modelo_dao;

import utils.Conexion;
import java.sql.*;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import modelo_dto.DtoServicio;
import modelo_entidad.Servicio;

public class ServicioDAO {
    
    public List<DtoServicio> listarDTO() {
    List<DtoServicio> lista = new ArrayList<>();
    String sql = "SELECT servicio_id, nombre, precio, imagen, duracion FROM Servicios ORDER BY servicio_id DESC";
    try (Connection con = Conexion.conectar();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            int id = rs.getInt("servicio_id");
            String nombre = rs.getString("nombre");
            double precio = rs.getDouble("precio");
            String imagen = rs.getString("imagen");
            Time t = rs.getTime("duracion");
            String duracion = (t != null) ? t.toLocalTime().toString().substring(0,5) : "";
            lista.add(new DtoServicio(id, nombre, precio, imagen, duracion));
        }
    } catch (SQLException e) {
        System.out.println("Error al listar servicios DTO: " + e.getMessage());
    }
    return lista;
}
    
    // Listar todos
    public List<Servicio> listar() {
        List<Servicio> lista = new ArrayList<>();
        String sql = "SELECT servicio_id, nombre, precio, imagen, duracion FROM Servicios ORDER BY servicio_id DESC";
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Servicio s = new Servicio();
                s.setId(rs.getInt("servicio_id"));
                s.setNombre(rs.getString("nombre"));
                s.setPrecio(rs.getDouble("precio"));
                s.setImagen(rs.getString("imagen"));
                Time t = rs.getTime("duracion");
                s.setDuracion(t != null ? t.toLocalTime() : null);
                lista.add(s);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar servicios: " + e.getMessage());
        }
        return lista;
    }

    // Registrar
    public void registrar(Servicio s) {
        String sql = "INSERT INTO Servicios (nombre, precio, imagen, duracion) VALUES (?,?,?,?)";
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getNombre());
            ps.setDouble(2, s.getPrecio());
            ps.setString(3, s.getImagen());
            if (s.getDuracion() != null) {
                ps.setTime(4, Time.valueOf(s.getDuracion()));
            } else {
                ps.setNull(4, Types.TIME);
            }
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al registrar servicio: " + e.getMessage());
        }
    }

    // Actualizar
    public void actualizar(Servicio s) {
        String sql = "UPDATE Servicios SET nombre=?, precio=?, imagen=?, duracion=? WHERE servicio_id=?";
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, s.getNombre());
            ps.setDouble(2, s.getPrecio());
            ps.setString(3, s.getImagen());
            if (s.getDuracion() != null) {
                ps.setTime(4, Time.valueOf(s.getDuracion()));
            } else {
                ps.setNull(4, Types.TIME);
            }
            ps.setInt(5, s.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al actualizar servicio: " + e.getMessage());
        }
    }

    // Eliminar
    public void eliminar(int id) {
        String sql = "DELETE FROM Servicios WHERE servicio_id=?";
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error al eliminar servicio: " + e.getMessage());
        }
    }
}
