package dao;

import util.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.Usuario;

public class ProductoDAO {

    // método para validar login
    public Usuario validar(String correo, String password) {
        Usuario u = null;

        try {
            String sql = "SELECT * FROM Usuario WHERE correo=? AND password=?";
            Connection con = Conexion.conectar();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, correo);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                u = new Usuario();
                u.setId(rs.getInt("usuario_id"));
                u.setCorreo(rs.getString("correo"));
                u.setPassword(rs.getString("password"));
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
            String sql = "INSERT INTO usuario (correo, password) VALUES (?, ?)";
            Connection con = Conexion.conectar();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, u.getCorreo());
            pst.setString(2, u.getPassword());
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
            String sql = "SELECT * FROM usuario ORDER BY correo";
            Connection con = Conexion.conectar();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setCorreo(rs.getString("correo")); 
                u.setPassword(rs.getString("password"));
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
