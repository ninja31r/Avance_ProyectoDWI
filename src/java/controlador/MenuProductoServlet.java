package controlador;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo_dao.ProductoDAO;
import modelo_entidad.Producto;

@WebServlet(name = "MenuProductoServlet", urlPatterns = {"/MenuProductoServlet"})
public class MenuProductoServlet extends HttpServlet {

    private ProductoDAO dao = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null || accion.equals("listar")) {
            listarProductos(request, response);
        } else if (accion.equals("eliminar")) {
            eliminarProducto(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        } else if (accion.equals("agregar")) {
            agregarProducto(request, response);
        }  else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        }
    }

    // ================== MÉTODOS PRIVADOS ==================

    private void listarProductos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Producto> lista = dao.listar();
        request.setAttribute("productos", lista);
        RequestDispatcher rd = request.getRequestDispatcher("menuProductos.jsp");
        rd.forward(request, response);
    }

    private void agregarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String nombre = request.getParameter("nombre");
        int stock = Integer.parseInt(request.getParameter("stock"));
        int precio = Integer.parseInt(request.getParameter("precio"));
        String imagen = request.getParameter("imagen");

        Producto p = new Producto(0, nombre, stock, precio, imagen);
        dao.agregar(p);
        response.sendRedirect("MenuProductoServlet");
    }

    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.eliminar(id);
        response.sendRedirect("MenuProductoServlet");
    }

}
