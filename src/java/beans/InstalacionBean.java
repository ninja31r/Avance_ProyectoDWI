package beans;

import jakarta.inject.Named;
import jakarta.enterprise.context.RequestScoped;
import java.util.List;
import modelo_entidad.Instalacion;
import modelo_dao.InstalacionDAO;

/**
 * Bean visual para la vista agendaInstalaciones.xhtml
 * Controla el listado de instalaciones y los filtros (simulados).
 */
@Named("instalacionBean")
@RequestScoped
public class InstalacionBean {

    private List<Instalacion> instalaciones;
    private Instalacion instalacionSeleccionada;
    private String filtroTecnico;
    private String fechaDesde;
    private String fechaHasta;
    private List<Instalacion> listaInstalaciones;
    private InstalacionDAO dao;


    public InstalacionBean() {
        dao = new InstalacionDAO();
        instalaciones = dao.listarInstalaciones(); // usa DAO simulado
        instalacionSeleccionada = new Instalacion();
        
    }

    // Acción visual: ver detalle
    public void verDetalle(Instalacion i) {
        this.instalacionSeleccionada = i;
        System.out.println("Instalación seleccionada: " + i.getPedidoId());
    }

    // Acción visual: aplicar filtro (solo simulado)
    public void aplicarFiltro() {
        System.out.println("Filtro aplicado - Técnico: " + filtroTecnico +
                           " | Desde: " + fechaDesde + " | Hasta: " + fechaHasta);
    }

    // ===== Getters & Setters =====
    public List<Instalacion> getInstalaciones() { return instalaciones; }
    public void setInstalaciones(List<Instalacion> instalaciones) { this.instalaciones = instalaciones; }

    public Instalacion getInstalacionSeleccionada() { return instalacionSeleccionada; }
    public void setInstalacionSeleccionada(Instalacion instalacionSeleccionada) { this.instalacionSeleccionada = instalacionSeleccionada; }

    public String getFiltroTecnico() { return filtroTecnico; }
    public void setFiltroTecnico(String filtroTecnico) { this.filtroTecnico = filtroTecnico; }

    public String getFechaDesde() { return fechaDesde; }
    public void setFechaDesde(String fechaDesde) { this.fechaDesde = fechaDesde; }

    public String getFechaHasta() { return fechaHasta; }
    public void setFechaHasta(String fechaHasta) { this.fechaHasta = fechaHasta; }

}
