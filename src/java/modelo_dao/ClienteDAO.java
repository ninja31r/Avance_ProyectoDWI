package modelo_dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import modelo_entidad.Cliente;

public class ClienteDAO {

    // metodo para validar login
    public Cliente validar(String usuario, String password) {
        Cliente cliente = null;

        try {
            String sql = "SELECT * FROM cliente WHERE usuario=? AND password=?";
            Connection con = Conexion.conectar(); 
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, usuario);
            pst.setString(2, password);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                cliente = new Cliente();
                cliente.setId(rs.getInt("id"));
                cliente.setUsuario(rs.getString("usuario"));
                cliente.setPassword(rs.getString("password"));
            }

            rs.close();
            pst.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return cliente;
    }

    // meetodo para insertar cliente
    public int insertar(Cliente cli) {
        int r = 0;
        try {
            String sql = "INSERT INTO cliente (usuario, password) VALUES (?, ?)";
            Connection con = Conexion.conectar();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, cli.getUsuario());
            pst.setString(2, cli.getPassword());
            r = pst.executeUpdate();

            pst.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return r;
    }

    // metodo para listar clientes
    public ArrayList<Cliente> listar() {
        ArrayList<Cliente> lista = new ArrayList<>();
        try {
            String sql = "SELECT * FROM cliente ORDER BY usuario";
            Connection con = Conexion.conectar();
            PreparedStatement pst = con.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Cliente cli = new Cliente();
                cli.setId(rs.getInt("id"));
                cli.setUsuario(rs.getString("usuario"));
                cli.setPassword(rs.getString("password"));
                lista.add(cli);
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
