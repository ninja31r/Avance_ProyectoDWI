package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import modelo_dao.UsuarioDAO;
import modelo_entidad.Usuario;

@WebServlet(name = "RegistroClienteServlet", urlPatterns = {"/RegistroClienteServlet"})
public class RegistroClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Obtener datos del formulario
        String nombre = req.getParameter("nombre");
        String apellidos = req.getParameter("apellidos");
        String telefono = req.getParameter("telefono");
        String correo = req.getParameter("correo");
        String password = req.getParameter("password");

        // Validaciones básicas
        if (nombre == null || nombre.isEmpty() ||
            apellidos == null || apellidos.isEmpty() ||
            correo == null || correo.isEmpty() ||
            password == null || password.isEmpty()) {

            req.setAttribute("mensaje", "Todos los campos son obligatorios.");
            req.getRequestDispatcher("registroCliente.jsp").forward(req, res);
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();

        // Verificar si el correo ya existe
        if (dao.existeCorreo(correo)) {
            req.setAttribute("mensaje", "Ya existe un usuario con ese correo electrónico.");
            req.getRequestDispatcher("registroCliente.jsp").forward(req, res);
            return;
        }

        // Crear objeto Usuario (sin hash)
        Usuario nuevo = new Usuario();
        nuevo.setNombre(nombre.trim());
        nuevo.setApellidos(apellidos.trim());
        nuevo.setTelefono(telefono.trim());
        nuevo.setCorreo(correo.trim());
        nuevo.setPassword(password.trim()); 
        nuevo.setRol_id(1); // Rol cliente

        // Insertar en BD
        int resultado = dao.insertar(nuevo);

        if (resultado > 0) {
            req.setAttribute("mensaje", "Registro exitoso. Ahora puede iniciar sesión.");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        } else {
            req.setAttribute("mensaje", "Error al registrar el usuario. Intente nuevamente.");
            req.getRequestDispatcher("registroCliente.jsp").forward(req, res);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        res.sendRedirect("registroCliente.jsp");
    }
}
