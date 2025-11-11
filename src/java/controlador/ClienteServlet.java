package controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo_dao.UsuarioDAO;
import modelo_entidad.Usuario;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "ClienteServlet", urlPatterns = {"/ClienteServlet"})
public class ClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        UsuarioDAO dao = new UsuarioDAO();
        String redirect = "clientes.jsp";

        try {
            if ("agregar".equals(accion)) {
                String nombre = request.getParameter("nombre");
                String apellidos = request.getParameter("apellidos");
                String correo = request.getParameter("correo");
                String password = request.getParameter("password");
                String telefono = request.getParameter("telefono");
                int rol = Integer.parseInt(request.getParameter("rol"));

                Usuario u = new Usuario();
                u.setNombre(nombre);
                u.setApellidos(apellidos);
                u.setCorreo(correo);
                u.setPassword(password);
                u.setTelefono(telefono);
                u.setRol_id(rol);

                dao.insertar(u);
                redirect += "?msg=agregado";

            } else if ("editar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String nombre = request.getParameter("nombre");
                String apellidos = request.getParameter("apellidos");
                String correo = request.getParameter("correo");
                String telefono = request.getParameter("telefono");
                int rol = Integer.parseInt(request.getParameter("rol"));

                Usuario u = new Usuario();
                u.setId(id);
                u.setNombre(nombre);
                u.setApellidos(apellidos);
                u.setCorreo(correo);
                u.setTelefono(telefono);
                u.setRol_id(rol);

                dao.actualizar(u);
                redirect += "?msg=editado";

            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                redirect += "?msg=eliminado";
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirect += "?msg=error";
        }

        response.sendRedirect(redirect);
    }
}
