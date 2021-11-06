package modelo;

import java.awt.HeadlessException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {

    public Connection conexionBD;
    private final String puerto = "3306";
    private final String bd = "proyecto_progra22021";
    private final String urlConexion = String.format("jdbc:mysql://localhost:%s/%s", puerto, bd);
    private final String usuario = "user1";
    private final String contra = "user1";
    private final String jdbc = "com.mysql.cj.jdbc.Driver";

    public void abrirConexion() {
        try {
            Class.forName(jdbc);
            conexionBD = DriverManager.getConnection(urlConexion, usuario, contra);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        }
    }

    public void cerrarConexion() {
        try {
            conexionBD.close();
        } catch (SQLException ex) {
            System.out.println("Error:" + ex.getMessage());
        }
    }
}
