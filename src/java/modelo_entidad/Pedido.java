package modelo_entidad;

import java.util.Date;
import java.util.List;

public class Pedido {
    private int id;
    private Date fecha;
    private int usuarioId;
    private String estado;
    private List<PedidoItem> itemsProductos;
    private List<PedidoItem> itemsServicios;
    private String nombreCliente; 

    public int getId() { 
        return id;
    }
    public void setId(int id) { 
        this.id = id; 
    }

    public Date getFecha() { 
        return fecha; 
    }
    public void setFecha(Date fecha) { 
        this.fecha = fecha; 
    }

    public int getUsuarioId() { 
        return usuarioId; 
    }
    public void setUsuarioId(int usuarioId) { 
        this.usuarioId = usuarioId; 
    }

    public String getEstado() { 
        return estado; 
    }
    public void setEstado(String estado) { 
        this.estado = estado; 
    }

    public List<PedidoItem> getItemsProductos() { 
        return itemsProductos; 
    }
    public void setItemsProductos(List<PedidoItem> itemsProductos) { 
        this.itemsProductos = itemsProductos; 
    }

    public List<PedidoItem> getItemsServicios() { 
        return itemsServicios; 
    }
    public void setItemsServicios(List<PedidoItem> itemsServicios) { 
        this.itemsServicios = itemsServicios; 
    }

    public String getNombreCliente() {
        return nombreCliente;
    }
    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }
}
