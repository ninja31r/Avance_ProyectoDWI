package modelo_entidad;

/**
 * Entidad Cliente
 * Representa los datos básicos del cliente que crea tickets de soporte.
 */
public class Cliente {
    private String nombre;
    private String correo;

    public Cliente() {}

    public Cliente(String nombre, String correo) {
        this.nombre = nombre;
        this.correo = correo;
    }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
}
