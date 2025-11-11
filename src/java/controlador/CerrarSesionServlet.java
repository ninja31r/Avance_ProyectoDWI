package controlador;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name="CerrarSesion", urlPatterns={"/CerrarSesion"})
public class CerrarSesionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp) throws IOException {
        HttpSession ses = req.getSession(false);
        if (ses != null) ses.invalidate();
        resp.sendRedirect("index.jsp");
    }
}
