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
import modelo_entidad.Servicio;

@WebServlet(name = "svltServicio", urlPatterns = {"/svltServicio"})
public class ServicioServlet extends HttpServlet {

    private ServicioDAO dao = new ServicioDAO();

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
        System.out.println("Acción recibida: " + accion);

        if (accion == null) accion = "listar";

        String jspDestino = "menuServicios.jsp";

        switch (accion) {
            case "registrar": {
                try {
                    System.out.println("Entrando en REGISTRAR...");
                    Servicio s = new Servicio();
                    s.setNombre(request.getParameter("nombre"));
                    s.setPrecio(Double.parseDouble(request.getParameter("precio")));
                    s.setImagen(request.getParameter("imagen"));
                    
                    System.out.println("Datos recibidos para registrar:");
                    System.out.println("Nombre: " + s.getNombre());
                    System.out.println("Precio: " + s.getPrecio());
                    System.out.println("Imagen: " + s.getImagen());
                    
                    dao.registrar(s);
                } catch (Exception e) {
                    System.out.println("Error en registrar: " + e.getMessage());
                    e.printStackTrace();
                }
                break;
            }
            case "editar": {
                try {
                    System.out.println("Entrando en EDITAR...");
                    Servicio s = new Servicio();
                    s.setId(Integer.parseInt(request.getParameter("id")));
                    s.setNombre(request.getParameter("nombre"));
                    s.setPrecio(Double.parseDouble(request.getParameter("precio")));
                    s.setImagen(request.getParameter("imagen"));

                    System.out.println("Datos recibidos para editar ID=" + s.getId());
                    dao.actualizar(s);
                } catch (Exception e) {
                    System.out.println(" Error en editar: " + e.getMessage());
                    e.printStackTrace();
                }
                break;
            }
            case "eliminar": {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    System.out.println(" Eliminando servicio con ID=" + id);
                    dao.eliminar(id);
                } catch (Exception e) {
                    System.out.println("Error en eliminar: " + e.getMessage());
                    e.printStackTrace();
                }
                break;
            }
            case "listar":
            default:
                System.out.println("Listando servicios...");
                jspDestino = "servicios.jsp";
                break;
        }

        List<Servicio> lista = dao.listar();
        System.out.println("Cantidad de servicios listados: " + lista.size());

        request.setAttribute("listaServicios", lista);
        RequestDispatcher rd = request.getRequestDispatcher(jspDestino);
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet CRUD de servicios con logs de depuración";
    }
}
