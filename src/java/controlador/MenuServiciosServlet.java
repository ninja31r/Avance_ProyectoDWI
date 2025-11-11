package controlador;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo_dao.ServicioDAO;
import modelo_dto.DtoServicio;
import modelo_entidad.Servicio;

@WebServlet(name = "MenuServiciosServlet", urlPatterns = {"/MenuServiciosServlet", "/menuserviciosServlet"})
public class MenuServiciosServlet extends HttpServlet {

    private final ServicioDAO dao = new ServicioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<DtoServicio> lista = dao.listarDTO();
request.setAttribute("listaServicios", lista);

        RequestDispatcher rd = request.getRequestDispatcher("menuServicios.jsp");
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "panel CRUD de servicios";
    }
}
