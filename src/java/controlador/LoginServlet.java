package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo_dao.UsuarioDAO;
import modelo_entidad.Usuario;

@WebServlet(name = "LoginServlet", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String correo = req.getParameter("correo");
        String password = req.getParameter("password");

        UsuarioDAO dao = new UsuarioDAO();
        Usuario u = dao.validar(correo, password);

        if (u == null) {
            req.setAttribute("error", "Correo o contraseña incorrectos");
            req.getRequestDispatcher("login.jsp").forward(req, res);
            return;
        }

        // Crear sesión
        HttpSession ses = req.getSession(true);
        ses.setAttribute("usuario", u);

        // Redirección según el rol
        switch (u.getRol_id()) {
            case 1: // Cliente
                res.sendRedirect("index.jsp");
                break;

            case 2: // Administrador
                res.sendRedirect("administrar.jsp");
                break;

            case 3: // Trabajador / Técnico
                res.sendRedirect("menuPedidos.xhtml"); // o menuServicios.jsp según tu estructura
                break;

            default:
                // Si no tiene rol válido
                ses.invalidate();
                res.sendRedirect("login.jsp?error=rol");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String accion = req.getParameter("accion");

        if ("logout".equalsIgnoreCase(accion)) {
            HttpSession ses = req.getSession(false);
            if (ses != null) ses.invalidate();
            res.sendRedirect("login.jsp?msg=logout");
        } else {
            res.sendRedirect("login.jsp");
        }
    }
}
