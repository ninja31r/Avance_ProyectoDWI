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

@WebServlet(name = "ProductoServlet", urlPatterns = {"/ProductoServlet"})
public class ProductoServlet extends HttpServlet {

    private ProductoDAO dao = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // LISTAR PRODUCTOS PÚBLICOS
        List<Producto> lista = dao.listar();
        request.setAttribute("productos", lista);
        RequestDispatcher rd = request.getRequestDispatcher("productos.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Este servlet público no procesa POST
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Método no permitido");
    }
}
