package modelo_dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo_entidad.Usuario;

public class UsuarioDAO {

    // método para validar login
    public Usuario validar(String correo, String password) {
        Usuario u = null;

        try {
            String sql = "SELECT usuario_id, nombre, apellidos, correo, password, telefono, rol_id FROM Usuario WHERE correo=? AND password=?";
            Connection con = Conexion.conectar();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, correo);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                u = new Usuario();
                u.setId(rs.getInt("usuario_id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellidos(rs.getString("apellidos"));
                u.setCorreo(rs.getString("correo"));
                u.setPassword(rs.getString("password"));
                u.setTelefono(rs.getString("telefono"));
                u.setRol_id(rs.getInt("rol_id"));
                System.out.println("DEBUG -> Login correcto: " + u.getCorreo() + " rol=" + u.getRol_id());
            }

            rs.close();
            pst.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return u;
    }

    // método para insertar usuario
    public int insertar(Usuario u) {
        int r = 0;
        try {
            String sql = "INSERT INTO Usuario (nombre, apellidos, correo, password, telefono, rol_id) VALUES (?, ?, ?, ?, ?, ?)";
            Connection con = Conexion.conectar();
            PreparedStatement pst = con.prepareStatement(sql);

            pst.setString(1, u.getNombre());
            pst.setString(2, u.getApellidos());
            pst.setString(3, u.getCorreo());
            pst.setString(4, u.getPassword());
            pst.setString(5, u.getTelefono());
            pst.setInt(6, u.getRol_id());

            r = pst.executeUpdate();

            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    // método para listar usuarios
    public ArrayList<Usuario> listar() {
        ArrayList<Usuario> lista = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Usuario ORDER BY correo";
            Connection con = Conexion.conectar();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

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

            rs.close();
            pst.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}
