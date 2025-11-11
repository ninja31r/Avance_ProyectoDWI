package filtros;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo_entidad.Usuario;
import java.io.IOException;

@WebFilter(urlPatterns = { "/administrar.jsp" })
public class RoleAdminFilter implements Filter {
    @Override public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) req;
        HttpServletResponse s = (HttpServletResponse) res;
        Usuario u = (Usuario) r.getSession().getAttribute("usuario");

        if (u == null || u.getRol_id() != 2) {   
            s.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        chain.doFilter(req, res);
    }
}
