package modelo_dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import modelo_entidad.Instalacion;

/**
 * DAO temporal con datos simulados.
 *sespues aquí irá la conexión con BD.
 */
public class InstalacionDAO {

    public List<Instalacion> listarInstalaciones() {
        List<Instalacion> lista = new ArrayList<>();

        lista.add(new Instalacion(1, "Carlos Rojas", "Técnico A", "PED-001", new Date(), "09:00", "Programada"));
        lista.add(new Instalacion(2, "María Flores", "Técnico B", "PED-002", new Date(), "11:00", "Pendiente"));
        lista.add(new Instalacion(3, "Luis Soto", "Técnico C", "PED-003", new Date(), "15:00", "Completada"));

        return lista;
    }
}
