package modelo;

import java.awt.HeadlessException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class Puesto {

    private int idPuesto;
    private String puesto;
    Conexion nuevaConexion;

    public Puesto() {

    }

    public Puesto(int idPuesto, String puesto) {
        this.idPuesto = idPuesto;
        this.puesto = puesto;
    }

    public int getIdPuesto() {
        return idPuesto;
    }

    public void setIdPuesto(int idPuesto) {
        this.idPuesto = idPuesto;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }

    public HashMap dropSangre() {
        HashMap<String, String> drop = new HashMap();
        try {
            String query = "SELECT idPuesto as id, puesto FROM puestos";
            nuevaConexion = new Conexion();
            nuevaConexion.abrirConexion();
            ResultSet consulta = nuevaConexion.conexionBD.createStatement().executeQuery(query);
            while (consulta.next()) {
                drop.put(consulta.getString("id"), consulta.getString("puesto"));
            }
            nuevaConexion.cerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return drop;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            nuevaConexion = new Conexion();
            String query = "SELECT p.idPuesto as id, p.puesto FROM puestos as p;";
            nuevaConexion.abrirConexion();
            ResultSet consulta = nuevaConexion.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"id", "puesto"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[2];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("puesto");
                tabla.addRow(datos);
            }
            nuevaConexion.cerrarConexion();
        } catch (Exception ex) {
            System.out.println("Exception = " + ex.getMessage());
        }
        return tabla;
    }


    public int agregar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            String query;
            nuevaConexion = new Conexion();
            nuevaConexion.abrirConexion();
            query = "INSERT INTO puestos(puesto) VALUES(?);";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getPuesto());
            retorno = parametro.executeUpdate();
            nuevaConexion.cerrarConexion();
        } catch (HeadlessException | SQLException ex) {
            System.out.println("Error..." + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }


    public int modificar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            String query;
            nuevaConexion = new Conexion();
            nuevaConexion.abrirConexion();
            query = "update puestos set puesto=? where idPuesto = ?;";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getPuesto());
            parametro.setInt(2, getIdPuesto());
            retorno = parametro.executeUpdate();
            nuevaConexion.cerrarConexion();
        } catch (HeadlessException | SQLException ex) {
            System.out.println("Error..." + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }


    public int eliminar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            String query;
            nuevaConexion = new Conexion();
            nuevaConexion.abrirConexion();
            query = "delete from puestos where idPuesto = ?;";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setInt(1, getIdPuesto());
            retorno = parametro.executeUpdate();
            nuevaConexion.cerrarConexion();

        } catch (HeadlessException | SQLException ex) {
            System.out.println("Error..." + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

}
