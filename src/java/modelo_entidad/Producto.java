package modelo_entidad;

public class Producto {
    private int id;
    private String nombre;
    private int stock;
    private int precio;
    private String descripcion;

    public Producto() {}

    public Producto(int id, String nombre, int stock, int precio, String descripcion) {
        this.id = id;
        this.nombre = nombre;
        this.stock = stock;
        this.precio = precio;
        this.descripcion = descripcion;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public int getStock() {
        return stock;
    }

    public int getPrecio() {
        return precio;
    }

    public String getDescripcion() {
        return descripcion;
    }
    

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public void setPrecio(int precio) {
        this.precio = precio;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
}
