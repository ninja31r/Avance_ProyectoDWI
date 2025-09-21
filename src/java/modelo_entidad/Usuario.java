package modelo_entidad;

public class Usuario {
    private int id;
    private String nombre;
    private String apellidos;
    private String correo;   // antes: usuario
    private String password;
    private String telefono;
    private int rol_id;

    public Usuario() {}

    public Usuario(int id, String nombre, String apellidos, String correo, String password, String telefono, int rol_id) {
        this.id = id;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.correo = correo;
        this.password = password;
        this.telefono = telefono;
        this.rol_id = rol_id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    
    public int getId() { 
        return id; 
    }
    public void setId(int id) { 
        this.id = id; 
    }

    public String getCorreo() { 
        return correo; 
    }
    public void setCorreo(String correo) { 
        this.correo = correo; 
    }

    public String getPassword() { 
        return password; 
    }
    public void setPassword(String password) { 
        this.password = password; 
    }
    public int getRol_id() {
        return rol_id;
    }
    public void setRol_id(int rol_id) {
        this.rol_id = rol_id;
    }
}