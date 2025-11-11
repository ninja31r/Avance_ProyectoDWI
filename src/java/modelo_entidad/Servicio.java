package modelo_entidad;
import java.time.LocalTime;

public class Servicio {
    private int id;
    private String nombre;
    private double precio;
    private String imagen;     
    private LocalTime duracion; 
    
    public Servicio() {}

    public Servicio(int id, String nombre, double precio, String imagen, LocalTime duracion) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.imagen = imagen;
        this.duracion = duracion;
    }

    public int getId() { 
        return id; 
    }
    public void setId(int id) { 
        this.id = id; 
    }

    public String getNombre() { 
        return nombre; 
    }
    public void setNombre(String nombre) { 
        this.nombre = nombre; 
    }

    public double getPrecio() { 
        return precio; 
    }
    public void setPrecio(double precio) { 
        this.precio = precio; 
    }

    public String getImagen() { 
        return imagen; 
    }
    public void setImagen(String imagen) { 
        this.imagen = imagen; 
    }

    public LocalTime getDuracion() { 
        return duracion; 
    }
    public void setDuracion(LocalTime duracion) { 
        this.duracion = duracion; 
    }
    
}