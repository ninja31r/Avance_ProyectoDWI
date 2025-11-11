package beans;

import jakarta.enterprise.context.SessionScoped;
import jakarta.inject.Named;
import java.io.Serializable;
import jakarta.faces.context.FacesContext;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import modelo_entidad.Usuario;

@Named("perfilUsuarioBean")
@SessionScoped
public class PerfilUsuarioBean implements Serializable {

    private Usuario usuario;
    private String rol; 

    public PerfilUsuarioBean() {}

    public Usuario getUsuario() {
        if (usuario == null) {
            try {
                FacesContext facesContext = FacesContext.getCurrentInstance();
                HttpSession session = (HttpSession) facesContext.getExternalContext().getSession(true);
                usuario = (Usuario) session.getAttribute("usuario");

                if (usuario == null) {
                    FacesContext.getCurrentInstance().getExternalContext()
                        .redirect("login.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    // metodo para obtener el rol desde el correo
    public String getRol() {
        if (rol == null && usuario != null) {
            String correo = usuario.getCorreo();

            if (correo.startsWith("ADM")) {
                rol = "admin";
            } else if (correo.startsWith("TRAB")) {
                rol = "trabajador";
            } else if (correo.startsWith("CL")) {
                rol = "cliente";
            } else {
                rol = "otro";
            }
        }
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String regresar() {
        try {
            FacesContext.getCurrentInstance().getExternalContext()
                .redirect("index.jsp");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
    public String regresarAnterior() {
    return "gestionPedidos.xhtml?faces-redirect=true";
}

}
