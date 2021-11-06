package modelo;

import java.awt.HeadlessException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class Proveedor extends Persona {

    Conexion nuevaConexion;

    public Proveedor() {

    }

    public Proveedor(int id, String nombres, String NIT, String direccion, String telefono) {
        super(id, nombres, NIT, direccion, telefono);
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            nuevaConexion = new Conexion();
            String query = "SELECT p.idProveedor as id, p.proveedor, p.NIT, p.direccion, p.telefono FROM proveedores as p;";
            nuevaConexion.abrirConexion();
            ResultSet consulta = nuevaConexion.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"ID", "Proveedor", "NIT", "Direccion", "Telefono"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[5];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("proveedor");
                datos[2] = consulta.getString("NIT");
                datos[3] = consulta.getString("direccion");
                datos[4] = consulta.getString("telefono");
                tabla.addRow(datos);
            }
            nuevaConexion.cerrarConexion();
        } catch (Exception ex) {
            System.out.println("Exception = " + ex.getMessage());
        }
        return tabla;
    }

    @Override
    public int agregar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            String query;
            nuevaConexion = new Conexion();
            nuevaConexion.abrirConexion();
            query = "INSERT INTO proveedores(proveedor, NIT, direccion, telefono) VALUES(?,?,?,?);";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getNIT());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            retorno = parametro.executeUpdate();
            nuevaConexion.cerrarConexion();
        } catch (HeadlessException | SQLException ex) {
            System.out.println("Error..." + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    @Override
    public int modificar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            String query;
            nuevaConexion = new Conexion();
            nuevaConexion.abrirConexion();
            query = "update proveedores set proveedor=?, NIT=?, direccion=?, telefono=? where idProveedor = ?;";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getNIT());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setInt(5, getId());
            retorno = parametro.executeUpdate();
            nuevaConexion.cerrarConexion();
        } catch (HeadlessException | SQLException ex) {
            System.out.println("Error..." + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

    @Override
    public int eliminar() {
        int retorno = 0;
        try {
            PreparedStatement parametro;
            String query;
            nuevaConexion = new Conexion();
            nuevaConexion.abrirConexion();
            query = "delete from proveedores where idProveedor = ?;";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setInt(1, getId());
            retorno = parametro.executeUpdate();
            nuevaConexion.cerrarConexion();
        } catch (HeadlessException | SQLException ex) {
            System.out.println("Error..." + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }

}
