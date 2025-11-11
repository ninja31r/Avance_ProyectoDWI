package modelo_dto;

public class DtoServicio {
    private int id;
    private String nombre;
    private double precio; 
    private String imagen;
    private String duracion; 

    public DtoServicio() {}

    public DtoServicio(int id, String nombre, double precio, String imagen, String duracion) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.imagen = imagen;
        this.duracion = duracion;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public String getImagen() { return imagen; }
    public void setImagen(String imagen) { this.imagen = imagen; }

    public String getDuracion() { return duracion; }
    public void setDuracion(String duracion) { this.duracion = duracion; }
}
