package modelo_entidad;

public class PedidoItem {

    private int id;             
    private int referenciaId;    
    private int cantidad;       

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getReferenciaId() {
        return referenciaId;
    }

    public void setReferenciaId(int referenciaId) {
        this.referenciaId = referenciaId;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

}
