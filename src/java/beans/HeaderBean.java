package beans;

import jakarta.enterprise.context.SessionScoped;
import jakarta.inject.Named;
import java.io.Serializable;
import jakarta.faces.context.FacesContext;
import modelo_entidad.Usuario;

/**
 * HeaderBean sincronizado con la sesión HTTP creada por los servlets JSP.
 * Permite mostrar el menú correcto según el rol (Admin, Trabajador o Cliente)
 * sin necesidad de volver a loguearse dentro del entorno JSF.
 */
@Named("headerBean")
@SessionScoped
public class HeaderBean implements Serializable {

    private Usuario usuarioLog;

    public Usuario getUsuarioLog() {
        // Sincroniza automáticamente con la sesión creada por LoginServlet
        if (usuarioLog == null) {
            try {
                Object obj = FacesContext.getCurrentInstance()
                        .getExternalContext()
                        .getSessionMap()
                        .get("usuario"); // misma clave usada en tu LoginServlet
                if (obj instanceof Usuario) {
                    usuarioLog = (Usuario) obj;
                }
            } catch (Exception e) {
                System.out.println("HeaderBean: no se pudo leer usuario de sesión → " + e.getMessage());
            }
        }
        return usuarioLog;
    }

    public void setUsuarioLog(Usuario usuarioLog) {
        this.usuarioLog = usuarioLog;
        FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put("usuario", usuarioLog);
    }

    public String getNombreUsuario() {
        Usuario u = getUsuarioLog();
        if (u != null) return u.getNombre() + " " + u.getApellidos();
        return "Invitado";
    }

    public boolean isAdmin() {
        Usuario u = getUsuarioLog();
        return u != null && u.getCorreo() != null && u.getCorreo().startsWith("ADM");
    }

    public boolean isCliente() {
        Usuario u = getUsuarioLog();
        return u != null && u.getCorreo() != null && u.getCorreo().startsWith("CL");
    }

    public boolean isTrabajador() {
        Usuario u = getUsuarioLog();
        return u != null && u.getCorreo() != null && u.getCorreo().startsWith("TRAB");
    }

    public String cerrarSesion() {
        FacesContext.getCurrentInstance().getExternalContext().invalidateSession();
        usuarioLog = null;
        return "/index.xhtml?faces-redirect=true";
    }
}
