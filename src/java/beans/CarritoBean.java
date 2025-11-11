package beans;

import jakarta.enterprise.context.SessionScoped;
import jakarta.inject.Named;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import jakarta.faces.context.FacesContext;
import modelo_dao.PedidoDAO;
import modelo_entidad.Producto;
import modelo_entidad.Pedido;
import modelo_entidad.PedidoItem;
import modelo_entidad.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@Named("carritoBean")
@SessionScoped
public class CarritoBean implements Serializable {

    private List<Producto> carrito = new ArrayList<>();

    //  Agregar producto desde el parámetro URL (solo si viene ?producto=)
        public void agregarDesdeParametro() {
         FacesContext context = FacesContext.getCurrentInstance();
         String idParam = context.getExternalContext().getRequestParameterMap().get("productoId");
         String nombreParam = context.getExternalContext().getRequestParameterMap().get("producto");

         if (idParam != null && !idParam.isEmpty()) {
             try {
                 int prodId = Integer.parseInt(idParam);
                 // cargar producto desde BD por id
                 Producto prodBD = obtenerProductoDesdeBD(prodId);
                 if (prodBD != null) {
                     // evita duplicados por id real
                     boolean existe = carrito.stream().anyMatch(p -> p.getId() == prodBD.getId());
                     if (!existe) carrito.add(prodBD);
                 }
                 return;
             } catch (Exception e) {
                 e.printStackTrace();
                 // si falla, podemos intentar fallback por nombre
             }
         }

         // fallback: si venía nombre (compatibilidad con lo que ya tienes)
         if (nombreParam != null && !nombreParam.isEmpty()) {
             boolean existe = carrito.stream()
                     .anyMatch(p -> p.getNombre().equalsIgnoreCase(nombreParam));
             if (!existe) {
                 Producto nuevo = new Producto();
                 nuevo.setId(carrito.size() + 1);
                 nuevo.setNombre(nombreParam);
                 nuevo.setStock(1);
                 nuevo.setPrecio(10);
                 carrito.add(nuevo);
             }
         }
     }
     // Método auxiliar: carga producto desde la BD por id
     private Producto obtenerProductoDesdeBD(int productoId) {
         String sql = "SELECT producto_id, nombre, precio, imagen, stock FROM Productos WHERE producto_id = ?";
         try (Connection con = utils.Conexion.conectar();
              PreparedStatement pst = con.prepareStatement(sql)) {
             pst.setInt(1, productoId);
             try (ResultSet rs = pst.executeQuery()) {
                 if (rs.next()) {
                     Producto p = new Producto();
                     p.setId(rs.getInt("producto_id"));
                     p.setNombre(rs.getString("nombre"));
                     // Asegúrate de que Producto.precio es double; si es int usa rs.getInt
                     p.setPrecio(rs.getDouble("precio")); // preferible double
                     p.setImagen(rs.getString("imagen"));
                     p.setStock(rs.getInt("stock"));
                     return p;
                 }
             }
         } catch (Exception e) {
             System.out.println("Error al cargar producto desde BD: " + e.getMessage());
         }
         return null;
     }

    // Eliminar producto
    public void eliminarProducto(int idProducto) {
        carrito.removeIf(p -> p.getId() == idProducto);
    }

    // Vaciar todo el carrito
    public void vaciarCarrito() {
        carrito.clear();
    }

    // Calcular total
    public double getTotal() {
        return carrito.stream()
                .mapToDouble(p -> p.getPrecio() * p.getStock())
                .sum();
    }

    // Obtener lista del carrito
    public List<Producto> getCarrito() {
        return carrito;
    }

    // Generar factura (almacena los productos en sesión)
    public String generarFactura() {
        FacesContext context = FacesContext.getCurrentInstance();

        // Obtener usuario logueado desde la sesión
        Usuario usuario = (Usuario) context.getExternalContext().getSessionMap().get("usuario");

        if (usuario == null) {
            System.out.println("⚠️ No hay usuario en sesión. Redirigiendo a login...");
            return "login.jsp?faces-redirect=true";
        }

        // Crear el objeto Pedido
        Pedido pedido = new Pedido();
        pedido.setUsuarioId(usuario.getId());
        pedido.setFecha(new Date());
        pedido.setEstado("pendiente");

        // Convertir productos del carrito a PedidoItem
        List<PedidoItem> items = new ArrayList<>();
        for (Producto p : carrito) {
            PedidoItem item = new PedidoItem();
            item.setReferenciaId(p.getId());
            item.setCantidad(p.getStock());
            items.add(item);
        }
        pedido.setItemsProductos(items);

        // Guardar el pedido en la BD
        PedidoDAO dao = new PedidoDAO();
        int pedidoId = dao.insertarPedido(pedido);

        if (pedidoId > 0) {
            System.out.println("✅ Pedido registrado correctamente con ID: " + pedidoId);
            context.getExternalContext().getSessionMap().put("productosFactura", carrito);

            // Guarda el ID del pedido en sesión para la factura
            context.getExternalContext().getSessionMap().put("pedidoGenerado", pedidoId);

            vaciarCarrito(); // Limpia el carrito después de registrar el pedido
            return "factura?faces-redirect=true";
        } else {
            System.out.println("❌ Error al registrar el pedido en la base de datos.");
            return null;
        }
    }
}
