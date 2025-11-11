package controlador;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalTime;
import java.util.List;
import modelo_dao.ServicioDAO;
import modelo_entidad.Servicio;

@WebServlet(name = "svltServicio", urlPatterns = {"/ServicioServlet", "/svltServicio"})
public class ServicioServlet extends HttpServlet {

    private final ServicioDAO dao = new ServicioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesar(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        procesar(request, response);
    }

    private void procesar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null || accion.isBlank()) accion = "listar";

        
        String jspDestino = "menuServicios.jsp";

        switch (accion) {
            case "registrar": {
                Servicio s = new Servicio();
                s.setNombre(request.getParameter("nombre"));
                s.setPrecio(parseDoubleSafe(request.getParameter("precio")));
                s.setImagen(request.getParameter("imagen"));
                s.setDuracion(parseHoraSafe(request.getParameter("duracion"))); // formato HH:mm o HH:mm:ss
                dao.registrar(s);
                break;
            }
            case "editar": {
                Servicio s = new Servicio();
                s.setId(parseIntSafe(request.getParameter("id")));
                s.setNombre(request.getParameter("nombre"));
                s.setPrecio(parseDoubleSafe(request.getParameter("precio")));
                s.setImagen(request.getParameter("imagen"));
                s.setDuracion(parseHoraSafe(request.getParameter("duracion")));
                dao.actualizar(s);
                break;
            }
            case "eliminar": {
                int id = parseIntSafe(request.getParameter("id"));
                dao.eliminar(id);
                break;
            }
            case "listar":
            default: {
                
                jspDestino = "servicios.jsp";
                break;
            }
        }

        List<Servicio> lista = dao.listar();
        request.setAttribute("listaServicios", lista);
        RequestDispatcher rd = request.getRequestDispatcher(jspDestino);
        rd.forward(request, response);
    }

    private int parseIntSafe(String s) {
        try { return Integer.parseInt(s); } catch (Exception e) { return 0; }
    }

    private double parseDoubleSafe(String s) {
        try { return Double.parseDouble(s); } catch (Exception e) { return 0.0; }
    }

    private LocalTime parseHoraSafe(String s) {
        try {
            if (s == null || s.isBlank()) return null;
            // admite "HH:mm" o "HH:mm:ss"
            if (s.length() == 5) s = s + ":00";
            return LocalTime.parse(s);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet CRUD de Servicios";
    }
}
