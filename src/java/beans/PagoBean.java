
package beans;

import jakarta.inject.Named;
import jakarta.enterprise.context.RequestScoped;
import java.io.Serializable;

@Named("pagoBean")
@RequestScoped
public class PagoBean implements Serializable {
    private String metodo;

    public String getMetodo() {
        return metodo;
    }

    public void setMetodo(String metodo) {
        this.metodo = metodo;
    }
    
}

