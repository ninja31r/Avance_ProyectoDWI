package modelo_entidad;

public class Usuario {
    private int id;
    private String correo;   // antes: usuario
    private String password;
    private int rol_id;

    public Usuario() {}

    public Usuario(int id, String correo, String password) {
        this.id = id;
        this.correo = correo;
        this.password = password;
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