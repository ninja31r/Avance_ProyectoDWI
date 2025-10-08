package controlador;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import modelo_dao.ProductoDAO;
import modelo_dto.DtoProducto;

@WebServlet(name = "MenuProductoServlet", urlPatterns = {"/MenuProductoServlet"})
public class MenuProductoServlet extends HttpServlet {

    private final ProductoDAO dao = new ProductoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<DtoProducto> lista = dao.listarDTO();
        
        request.setAttribute("productos", lista);
        request.getRequestDispatcher("menuProductos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DtoProducto dto = new DtoProducto();
        dto.setNombre(request.getParameter("nombre"));
        dto.setStock(Integer.parseInt(request.getParameter("stock")));
        dto.setPrecio(Integer.parseInt(request.getParameter("precio")));
        dto.setImagen(request.getParameter("imagen"));

        dao.agregarDTO(dto);
        response.setStatus(HttpServletResponse.SC_OK);
        response.sendRedirect("MenuProductoServlet");
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        DtoProducto dto = new DtoProducto();
        dto.setId(id);

        dao.eliminarDTO(dto);
        response.setStatus(HttpServletResponse.SC_OK);
    }
}