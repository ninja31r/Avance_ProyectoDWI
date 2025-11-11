package modelo_entidad;

import java.util.Date;

public class Instalacion {
    private int id;
    private String clienteNombre;
    private String tecnicoNombre;
    private String pedidoId;
    private Date fechaInstalacion;
    private String hora;
    private String estado;

    public Instalacion() {}

    public Instalacion(int id, String clienteNombre, String tecnicoNombre, String pedidoId,
                       Date fechaInstalacion, String hora, String estado) {
        this.id = id;
        this.clienteNombre = clienteNombre;
        this.tecnicoNombre = tecnicoNombre;
        this.pedidoId = pedidoId;
        this.fechaInstalacion = fechaInstalacion;
        this.hora = hora;
        this.estado = estado;
    }

    // ===== Getters y Setters =====
    public int getId() { 
        return id; 
    }
    public void setId(int id) { 
        this.id = id; 
    }

    public String getClienteNombre() { 
        return clienteNombre; 
    }
    public void setClienteNombre(String clienteNombre) { 
        this.clienteNombre = clienteNombre; 
    }

    public String getTecnicoNombre() { 
        return tecnicoNombre; 
    }
    public void setTecnicoNombre(String tecnicoNombre) { 
        this.tecnicoNombre = tecnicoNombre; 
    }

    public String getPedidoId() { 
        return pedidoId; 
    }
    public void setPedidoId(String pedidoId) { 
        this.pedidoId = pedidoId; 
    }

    public Date getFechaInstalacion() { 
        return fechaInstalacion; 
    }
    public void setFechaInstalacion(Date fechaInstalacion) { 
        this.fechaInstalacion = fechaInstalacion; 
    }

    public String getHora() { 
        return hora; 
    }
    public void setHora(String hora) { 
        this.hora = hora; 
    }

    public String getEstado() { 
        return estado; 
    }
    public void setEstado(String estado) { 
        this.estado = estado; 
    }
}
