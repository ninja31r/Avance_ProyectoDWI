package beans;

import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.SessionScoped;
import jakarta.inject.Named;
import java.io.Serializable;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import modelo_entidad.Pedido;
import modelo_entidad.Servicio;
import modelo_dao.PedidoDAO;

@Named("pedidosBean")
@SessionScoped
public class PedidosBean implements Serializable {

    // ================= ATRIBUTOS =================
    private List<Pedido> listaPedidos;
    private Pedido pedidoSeleccionado; 
    private PedidoDAO pedidoDAO = new PedidoDAO();
    private int usuarioId = 1;
    private String busqueda;
    private int contadorCarrito = 0;

    private List<String> listaInstalaciones = new ArrayList<>();
    private List<String> listaMantenimientos = new ArrayList<>();

    private String cliente;
    private String servicio;
    private String tecnico;
    private String descripcion;
    private String tipoMantenimiento;
    private String fecha;

    // =============== SERVICIOS SOLICITADOS ===============
    private List<Servicio> listaServiciosSolicitados = new ArrayList<>();
    private Servicio servicioSeleccionado;

    // ================= CICLO DE VIDA =================
    @PostConstruct
    public void init() {
        listaServiciosSolicitados.add(new Servicio(1, "Instalación de cámaras", 120.00, "instalacion.png", LocalTime.parse("01:30")));
        listaServiciosSolicitados.add(new Servicio(2, "Mantenimiento de red", 150.00, "mantenimiento.png", LocalTime.parse("02:00")));
        // Se eliminó el servicio de soporte remoto
    }

    // ================= FUNCIONES VISUALES =================
    public void registrarInstalacion() {
        if (cliente != null && !cliente.isEmpty()) {
            listaInstalaciones.add(cliente + " - " + servicio + " - " + tecnico);
            limpiarCampos();
        }
    }

    public void registrarMantenimiento() {
        if (cliente != null && !cliente.isEmpty()) {
            listaMantenimientos.add(cliente + " - " + servicio + " - " + tipoMantenimiento);
            limpiarCampos();
        }
    }

    public void verDetalleServicio(Servicio servicio) {
        this.servicioSeleccionado = servicio;
    }

    public void asignarTecnico() {
        if (servicioSeleccionado != null && tecnico != null && !tecnico.isEmpty()) {
            System.out.println("Técnico asignado: " + tecnico + " al servicio: " + servicioSeleccionado.getNombre());
        }
    }

    public void guardarComentario() {
        if (servicioSeleccionado != null && descripcion != null && !descripcion.isEmpty()) {
            System.out.println("Comentario guardado para " + servicioSeleccionado.getNombre() + ": " + descripcion);
        }
    }

    private void limpiarCampos() {
        cliente = "";
        servicio = "";
        tecnico = "";
        descripcion = "";
        tipoMantenimiento = "";
        fecha = "";
    }

    // ================= NAVEGACIÓN =================
    public String irRegistrarPedido() {
        return "registrarPedido.xhtml?faces-redirect=true";
    }

    public String irListaPedidos() {
        listaPedidos = pedidoDAO.listarPedidosPorUsuario(usuarioId);
        return "listaPedidos.xhtml?faces-redirect=true";
    }

    public String irGestionPedidos() {
        listaPedidos = pedidoDAO.listarPedidosPorUsuario(usuarioId);
        return "gestionPedidos.xhtml?faces-redirect=true";
    }

    public String irMantenimiento() {
        return "mantenimiento.xhtml?faces-redirect=true";
    }

    public String irInstalacion() {
        return "instalacion.xhtml?faces-redirect=true";
    }

    // 🔴 Método irSoporte eliminado

    public void seleccionarPedido(Pedido pedido) {
        this.pedidoSeleccionado = pedido;
    }

    public void actualizarPedidoEstado() {
        if (pedidoSeleccionado != null) {
            try {
                pedidoDAO.actualizarEstado(pedidoSeleccionado);
            } catch (Exception e) {
                System.out.println("Método actualizarEstado aún no implementado en PedidoDAO.");
            }
        }
    }

    public Pedido obtenerPedidoPorId(int idPedido) {
        try {
            return pedidoDAO.obtenerPedidoPorId(idPedido);
        } catch (Exception e) {
            System.out.println("Método obtenerPedidoPorId aún no implementado en PedidoDAO.");
            return null;
        }
    }

    public void buscarPedidos() {
        listaPedidos = pedidoDAO.buscarPedidos(busqueda);
    }

    // ================= MÉTODO PARA IR A FACTURA =================
    public String prepararFactura() {
        if (this.pedidoSeleccionado == null) {
            this.pedidoSeleccionado = new Pedido();
        }
        return "factura.xhtml?faces-redirect=true";
    }

    // ================= GETTERS Y SETTERS =================
    public List<Pedido> getListaPedidos() { 
        return listaPedidos; 
    }
    public void setListaPedidos(List<Pedido> listaPedidos) { 
        this.listaPedidos = listaPedidos; 
    }

    public Pedido getPedidoSeleccionado() { 
        return pedidoSeleccionado; 
    }
    public void setPedidoSeleccionado(Pedido pedidoSeleccionado) { 
        this.pedidoSeleccionado = pedidoSeleccionado; 
    }

    public PedidoDAO getPedidoDAO() { 
        return pedidoDAO; 
    }
    public void setPedidoDAO(PedidoDAO pedidoDAO) { 
        this.pedidoDAO = pedidoDAO; 
    }

    public int getUsuarioId() { 
        return usuarioId; 
    }
    public void setUsuarioId(int usuarioId) { 
        this.usuarioId = usuarioId; 
    }

    public String getBusqueda() { 
        return busqueda; 
    }
    public void setBusqueda(String busqueda) { 
        this.busqueda = busqueda; 
    }

    public List<String> getListaInstalaciones() { 
        return listaInstalaciones; 
    }
    public void setListaInstalaciones(List<String> listaInstalaciones) { 
        this.listaInstalaciones = listaInstalaciones; 
    }

    public List<String> getListaMantenimientos() { 
        return listaMantenimientos; 
    }
    public void setListaMantenimientos(List<String> listaMantenimientos) { 
        this.listaMantenimientos = listaMantenimientos; 
    }

    public String getCliente() { 
        return cliente; 
    }
    public void setCliente(String cliente) { 
        this.cliente = cliente; 
    }

    public String getServicio() { 
        return servicio; 
    }
    public void setServicio(String servicio) { 
        this.servicio = servicio; 
    }

    public String getTecnico() { 
        return tecnico; 
    }
    public void setTecnico(String tecnico) { 
        this.tecnico = tecnico; 
    }

    public String getDescripcion() { 
        return descripcion; 
    }
    public void setDescripcion(String descripcion) { 
        this.descripcion = descripcion; 
    }

    public String getTipoMantenimiento() { 
        return tipoMantenimiento; 
    }
    public void setTipoMantenimiento(String tipoMantenimiento) { 
        this.tipoMantenimiento = tipoMantenimiento; 
    }

    public String getFecha() { 
        return fecha; 
    }
    public void setFecha(String fecha) { 
        this.fecha = fecha; 
    }

    public List<Servicio> getListaServiciosSolicitados() { 
        return listaServiciosSolicitados; 
    }
    public void setListaServiciosSolicitados(List<Servicio> listaServiciosSolicitados) { 
        this.listaServiciosSolicitados = listaServiciosSolicitados; 
    }

    public Servicio getServicioSeleccionado() { 
        return servicioSeleccionado; 
    }
    public void setServicioSeleccionado(Servicio servicioSeleccionado) { 
        this.servicioSeleccionado = servicioSeleccionado; 
    }

    public int getContadorCarrito() { 
        return contadorCarrito; 
    }
    public void incrementarCarrito() { 
        contadorCarrito++; 
    }
    public void vaciarCarrito() { 
        contadorCarrito = 0; 
    }
}
