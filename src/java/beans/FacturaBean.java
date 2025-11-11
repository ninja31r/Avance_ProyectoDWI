package beans;

import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Named;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.faces.context.FacesContext;
import modelo_dao.PedidoDAO;
import modelo_dao.UsuarioDAO;
import modelo_entidad.Producto;
import modelo_entidad.Usuario;

@Named("facturaBean")
@RequestScoped
public class FacturaBean implements Serializable {

    private List<Producto> productos;
    private String numeroFactura;
    private String clienteNombre;
    private String clienteTelefono;
    private Date fechaGenerada;

    private double subtotal;
    private double igv;
    private double total;

    @PostConstruct
    public void init() {
        try {
            FacesContext context = FacesContext.getCurrentInstance();

            // Obtener ID del pedido generado
            Integer pedidoId = (Integer) context.getExternalContext().getSessionMap().get("pedidoGenerado");
            if (pedidoId == null) {
                System.out.println("⚠️ No hay pedido en sesión.");
                return;
            }

            // Cargar productos desde BD
            PedidoDAO pedidoDAO = new PedidoDAO();
            this.productos = pedidoDAO.listarProductosPorPedido(pedidoId);

            // Cargar datos del usuario actual
            Usuario usuario = (Usuario) context.getExternalContext().getSessionMap().get("usuario");
            if (usuario != null) {
                UsuarioDAO udao = new UsuarioDAO();
                Usuario datos = udao.obtenerPorId(usuario.getId());
                this.clienteNombre = datos.getNombre() + " " + datos.getApellidos();
                this.clienteTelefono = datos.getTelefono();
            }

            // Generar fecha y número de factura
            this.fechaGenerada = new Date();
            this.numeroFactura = "FAC-" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

            calcularTotales();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void calcularTotales() {
        subtotal = productos.stream()
                .mapToDouble(p -> p.getPrecio() * p.getStock())
                .sum();
        igv = Math.round(subtotal * 0.18 * 100.0) / 100.0;
        total = Math.round((subtotal + igv) * 100.0) / 100.0;
    }

   // --- Getters existentes ---
    public List<Producto> getProductos() { 
        return productos; 
    }
    public String getNumeroFactura() { 
        return numeroFactura; 
    }
    public String getClienteNombre() { 
        return clienteNombre; 
    }
    public String getClienteTelefono() { 
        return clienteTelefono; 
    }
    public Date getFechaGenerada() { 
        return fechaGenerada; 
    }
    public double getSubtotal() { 
        return subtotal; 
    }
    public double getIgv() { 
        return igv; 
    }
    public double getTotal() { 
        return total; 
    }

    // --- Getters formateados---
    public String getSubtotalFormateado() {
        return String.format("%.2f", subtotal);
    }

    public String getIgvFormateado() {
        return String.format("%.2f", igv);
    }

    public String getTotalFormateado() {
        return String.format("%.2f", total);
    }

}
