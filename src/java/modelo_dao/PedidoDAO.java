package modelo_dao;

import utils.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import modelo_entidad.Pedido;
import modelo_entidad.PedidoItem;
import modelo_entidad.Servicio;

public class PedidoDAO {

    // -------------------- INSERTAR PEDIDO --------------------
    public int insertarPedido(Pedido pedido) {
        String sqlPedido = "INSERT INTO Pedido (fecha, usuario_id, estado) VALUES (?, ?, ?)";
        String sqlProd = "INSERT INTO Pedido_productos (pedido_id, producto_id, cantidad) VALUES (?, ?, ?)";
        String sqlServ = "INSERT INTO Pedido_servicios (pedido_id, servicio_id) VALUES (?, ?)";

        Connection con = null;
        PreparedStatement pstPedido = null;
        PreparedStatement pstProd = null;
        PreparedStatement pstServ = null;
        ResultSet rs = null;

        try {
            con = Conexion.conectar();
            con.setAutoCommit(false);

            pstPedido = con.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
            pstPedido.setTimestamp(1, new Timestamp(pedido.getFecha().getTime()));
            pstPedido.setInt(2, pedido.getUsuarioId());
            pstPedido.setString(3, pedido.getEstado() != null ? pedido.getEstado() : "pendiente");
            pstPedido.executeUpdate();

            rs = pstPedido.getGeneratedKeys();
            int pedidoId = -1;
            if (rs.next()) pedidoId = rs.getInt(1);

            // Insertar productos
            if (pedido.getItemsProductos() != null) {
                pstProd = con.prepareStatement(sqlProd);
                for (PedidoItem it : pedido.getItemsProductos()) {
                    pstProd.setInt(1, pedidoId);
                    pstProd.setInt(2, it.getReferenciaId());
                    pstProd.setInt(3, it.getCantidad());
                    pstProd.addBatch();
                }
                pstProd.executeBatch();
            }

            // Insertar servicios
            if (pedido.getItemsServicios() != null) {
                pstServ = con.prepareStatement(sqlServ);
                for (PedidoItem it : pedido.getItemsServicios()) {
                    pstServ.setInt(1, pedidoId);
                    pstServ.setInt(2, it.getReferenciaId());
                    pstServ.addBatch();
                }
                pstServ.executeBatch();
            }

            con.commit();
            return pedidoId;

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (Exception ex) {}
            e.printStackTrace();
            return -1;
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstPedido != null) pstPedido.close(); } catch (Exception e) {}
            try { if (pstProd != null) pstProd.close(); } catch (Exception e) {}
            try { if (pstServ != null) pstServ.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }

    // -------------------- LISTAR PEDIDOS POR USUARIO --------------------
    public List<Pedido> listarPedidosPorUsuario(int usuarioId) {
        List<Pedido> lista = new ArrayList<>();
        String sql = "SELECT pedido_id, fecha, usuario_id, estado FROM Pedido WHERE usuario_id = ?";

        try (Connection con = Conexion.conectar();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, usuarioId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                Pedido p = new Pedido();
                p.setId(rs.getInt("pedido_id"));
                p.setFecha(new Date(rs.getTimestamp("fecha").getTime()));
                p.setUsuarioId(rs.getInt("usuario_id"));
                p.setEstado(rs.getString("estado"));
                lista.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    // -------------------- LISTAR TODOS LOS PEDIDOS (TRABAJADOR) --------------------
    public List<Pedido> listarPedidos() {
        List<Pedido> lista = new ArrayList<>();
        String sql = "SELECT pedido_id, fecha, usuario_id, estado FROM Pedido ORDER BY fecha DESC";

        try (Connection con = Conexion.conectar();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Pedido p = new Pedido();
                p.setId(rs.getInt("pedido_id"));
                p.setFecha(new Date(rs.getTimestamp("fecha").getTime()));
                p.setUsuarioId(rs.getInt("usuario_id"));
                p.setEstado(rs.getString("estado"));
                lista.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lista;
    }

    // -------------------- OBTENER PEDIDO POR ID --------------------
    public Pedido obtenerPedidoPorId(int pedidoId) {
        Pedido pedido = null;
        String sql = "SELECT pedido_id, fecha, usuario_id, estado FROM Pedido WHERE pedido_id = ?";

        try (Connection con = Conexion.conectar();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setInt(1, pedidoId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                pedido = new Pedido();
                pedido.setId(rs.getInt("pedido_id"));
                pedido.setFecha(new Date(rs.getTimestamp("fecha").getTime()));
                pedido.setUsuarioId(rs.getInt("usuario_id"));
                pedido.setEstado(rs.getString("estado"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return pedido;
    }
    
// -------------------- LISTAR SERVICIOS DE UN PEDIDO --------------------
public List<modelo_entidad.Servicio> listarServiciosPorPedido(int pedidoId) {
    List<modelo_entidad.Servicio> lista = new ArrayList<>();

    String sql = "SELECT s.servicio_id, s.nombre, s.precio, s.duracion, s.imagen " +
                 "FROM Pedido_servicios ps " +
                 "INNER JOIN Servicios s ON ps.servicio_id = s.servicio_id " +
                 "WHERE ps.pedido_id = ?";

    try (Connection con = Conexion.conectar();
         PreparedStatement pst = con.prepareStatement(sql)) {

        pst.setInt(1, pedidoId);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            modelo_entidad.Servicio s = new modelo_entidad.Servicio();
            s.setId(rs.getInt("servicio_id"));
            s.setNombre(rs.getString("nombre"));
            s.setPrecio(rs.getDouble("precio"));
            s.setImagen(rs.getString("imagen"));

            Time dur = rs.getTime("duracion");
            if (dur != null) {
                s.setDuracion(dur.toLocalTime());
            }

            lista.add(s);
        }

    } catch (Exception e) {
        System.out.println("Error en listarServiciosPorPedido: " + e.getMessage());
    }

    return lista;
}


    // -------------------- ACTUALIZAR ESTADO DEL PEDIDO --------------------
    public boolean actualizarEstado(Pedido pedido) {
        String sql = "UPDATE Pedido SET estado = ? WHERE pedido_id = ?";
        try (Connection con = Conexion.conectar();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, pedido.getEstado());
            pst.setInt(2, pedido.getId());
            int filas = pst.executeUpdate();
            return filas > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public List<Pedido> buscarPedidos(String texto) {
    List<Pedido> lista = new ArrayList<>();
    String sql = """
        SELECT p.pedido_id, p.fecha, p.usuario_id, p.estado, u.nombre AS nombre_cliente
        FROM Pedido p
        JOIN Usuario u ON p.usuario_id = u.usuario_id
        WHERE u.nombre LIKE ? OR CAST(p.pedido_id AS CHAR) LIKE ?
        ORDER BY p.fecha DESC
    """;

    try (Connection cn = Conexion.conectar();
         PreparedStatement ps = cn.prepareStatement(sql)) {

        ps.setString(1, "%" + texto + "%");
        ps.setString(2, "%" + texto + "%");
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Pedido p = new Pedido();
            p.setId(rs.getInt("pedido_id"));
            p.setFecha(rs.getDate("fecha"));
            p.setUsuarioId(rs.getInt("usuario_id"));
            p.setEstado(rs.getString("estado"));
            p.setNombreCliente(rs.getString("nombre_cliente"));
            lista.add(p);
        }

    } catch (SQLException e) {
        System.out.println("Error al buscar pedidos: " + e.getMessage());
    }

    return lista;
}
// -------------------- LISTAR PRODUCTOS DE UN PEDIDO --------------------
public List<modelo_entidad.Producto> listarProductosPorPedido(int pedidoId) {
    List<modelo_entidad.Producto> lista = new ArrayList<>();
    String sql = """
        SELECT p.producto_id, p.nombre, p.precio, pp.cantidad
        FROM Pedido_productos pp
        INNER JOIN Productos p ON pp.producto_id = p.producto_id
        WHERE pp.pedido_id = ?
    """;

    try (Connection con = Conexion.conectar();
         PreparedStatement pst = con.prepareStatement(sql)) {

        pst.setInt(1, pedidoId);
        ResultSet rs = pst.executeQuery();

        while (rs.next()) {
            modelo_entidad.Producto prod = new modelo_entidad.Producto();
            prod.setId(rs.getInt("producto_id"));
            prod.setNombre(rs.getString("nombre"));
            prod.setPrecio(rs.getDouble("precio"));
            prod.setStock(rs.getInt("cantidad"));
            lista.add(prod);
        }

    } catch (Exception e) {
        System.out.println("Error al listar productos del pedido: " + e.getMessage());
    }

    return lista;
}


}
