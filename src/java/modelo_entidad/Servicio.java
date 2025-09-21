package modelo_entidad;

import java.util.Date;

public class Servicio {
    private int id;
    private String nombre;
    private double precio;
    private String cliente;
    private String descripcion;
    private String estado;
    private Date fecha;

    public Servicio() {}

    public Servicio(int id, String nombre, double precio, String cliente, String descripcion, String estado, Date fecha) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.cliente = cliente;
        this.descripcion = descripcion;
        this.estado = estado;
        this.fecha = fecha;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public String getCliente() { return cliente; }
    public void setCliente(String cliente) { this.cliente = cliente; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public Date getFecha() { return fecha; }
    public void setFecha(Date fecha) { this.fecha = fecha; }
}
