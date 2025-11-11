package modelo_dao;

import utils.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo_entidad.Rol;
import modelo_entidad.Usuario;

public class UsuarioDAO {

   public Usuario validar(String correo, String password) {
    String sql = """
        SELECT u.usuario_id, u.nombre, u.apellidos, u.correo, u.password, u.telefono,
               r.rol_id, r.nombre AS nombre_rol
        FROM Usuario u
        JOIN Rol r ON u.rol_id = r.rol_id
        WHERE u.correo = ? AND u.password = ?
    """;

    try (Connection con = Conexion.conectar();
         PreparedStatement pst = con.prepareStatement(sql)) {

        pst.setString(1, correo);
        pst.setString(2, password);

        try (ResultSet rs = pst.executeQuery()) {
            if (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("usuario_id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellidos(rs.getString("apellidos"));
                u.setCorreo(rs.getString("correo"));
                u.setPassword(rs.getString("password"));
                u.setTelefono(rs.getString("telefono"));
                u.setRol_id(rs.getInt("rol_id"));

                Rol rol = new Rol();
                rol.setId(rs.getInt("rol_id"));
                rol.setNombre(rs.getString("nombre_rol"));
                u.setRol(rol);

                return u;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return null;
}


    // --- Construir objeto Usuario ---
    private Usuario construirUsuario(ResultSet rs) throws Exception {
        Usuario u = new Usuario();
        u.setId(rs.getInt("usuario_id"));
        u.setNombre(rs.getString("nombre"));
        u.setApellidos(rs.getString("apellidos"));
        u.setCorreo(rs.getString("correo"));
        u.setPassword(rs.getString("password"));
        u.setTelefono(rs.getString("telefono"));
        u.setRol_id(rs.getInt("rol_id"));
        return u;
    }

    // --- Verificar si ya existe un correo ---
    public boolean existeCorreo(String correo) {
        String sql = "SELECT COUNT(*) FROM Usuario WHERE correo = ?";
        try (Connection con = Conexion.conectar();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, correo);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            System.out.println("Error al verificar correo: " + e.getMessage());
        }
        return false;
    }

    // --- Insertar nuevo usuario ---
    public int insertar(Usuario u) {
        int r = 0;
        String sql = "INSERT INTO Usuario (nombre, apellidos, correo, password, telefono, rol_id) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.conectar();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, u.getNombre());
            pst.setString(2, u.getApellidos());
            pst.setString(3, u.getCorreo());
            pst.setString(4, u.getPassword()); // Contraseña en texto plano
            pst.setString(5, u.getTelefono());
            pst.setInt(6, u.getRol_id());

            r = pst.executeUpdate();
            System.out.println("✅ Usuario insertado correctamente.");
        } catch (Exception e) {
            System.out.println("❌ Error al insertar usuario: " + e.getMessage());
        }
        return r;
    }

    // --- Listar todos los usuarios ---
    public ArrayList<Usuario> listar() {
        ArrayList<Usuario> lista = new ArrayList<>();
        String sql = "SELECT * FROM Usuario ORDER BY usuario_id";
        try (Connection con = Conexion.conectar();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("usuario_id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellidos(rs.getString("apellidos"));
                u.setCorreo(rs.getString("correo"));
                u.setPassword(rs.getString("password"));
                u.setTelefono(rs.getString("telefono"));
                u.setRol_id(rs.getInt("rol_id"));
                lista.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    // --- Actualizar usuario ---
    public boolean actualizar(Usuario u) {
        String sql = "UPDATE Usuario SET nombre=?, apellidos=?, correo=?, telefono=?, rol_id=? WHERE usuario_id=?";
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellidos());
            ps.setString(3, u.getCorreo());
            ps.setString(4, u.getTelefono());
            ps.setInt(5, u.getRol_id());
            ps.setInt(6, u.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error al actualizar usuario: " + e.getMessage());
            return false;
        }
    }

    // --- Eliminar usuario ---
    public boolean eliminar(int id) {
        String sql = "DELETE FROM Usuario WHERE usuario_id=?";
        try (Connection con = Conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error al eliminar usuario: " + e.getMessage());
            return false;
        }
    }
    
   // -------------------- OBTENER USUARIO POR ID --------------------
public Usuario obtenerPorId(int usuarioId) {
    String sql = "SELECT * FROM Usuario WHERE usuario_id = ?";
    try (Connection con = Conexion.conectar();
         PreparedStatement pst = con.prepareStatement(sql)) {

        pst.setInt(1, usuarioId);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            Usuario u = new Usuario();
            u.setId(rs.getInt("usuario_id"));
            u.setNombre(rs.getString("nombre"));
            u.setApellidos(rs.getString("apellidos"));
            u.setCorreo(rs.getString("correo"));
            u.setTelefono(rs.getString("telefono"));
            u.setRol_id(rs.getInt("rol_id"));
            return u;
        }

    } catch (Exception e) {
        System.out.println("❌ Error al obtener usuario: " + e.getMessage());
    }
    return null;
}


}
