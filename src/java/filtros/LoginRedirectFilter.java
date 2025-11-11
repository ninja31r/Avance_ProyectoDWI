package filtros;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo_entidad.Usuario;

@WebFilter(urlPatterns = {"/login.jsp", "/Login"})
public class LoginRedirectFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        Usuario u = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (u != null) {
            // Usuario ya autenticado → redirigir según rol
            switch (u.getRol_id()) {
                case 1: // Cliente
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    return;
                case 2: // Admin
                    response.sendRedirect(request.getContextPath() + "/administrar.jsp");
                    return;
                case 3: // Trabajador/Ventas
                    response.sendRedirect(request.getContextPath() + "/menuPedidos.xhtml");
                    return;
                default:
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    return;
            }
        }

        // Si no hay usuario, continuar al login normalmente
        chain.doFilter(req, res);
    }
}
