package modelo;

import java.awt.HeadlessException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class Cliente extends Persona {

    private String NIT;
    private int genero;
    private String correo;
    private String fechaIngreso;
    Conexion nuevaConexion;

    public Cliente() {

    }

    public Cliente(String NIT, int genero, String correo, String fechaIngreso, 
            int id, String nombres, String apellidos, String telefono) {
        super(id, nombres, apellidos, telefono);
        this.NIT = NIT;
        this.genero = genero;
        this.correo = correo;
        this.fechaIngreso = fechaIngreso;
    }

    public String getNIT() {
        return NIT;
    }

    public void setNIT(String NIT) {
        this.NIT = NIT;
    }

    public int getGenero() {
        return genero;
    }

    public void setGenero(int genero) {
        this.genero = genero;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            nuevaConexion = new Conexion();
            String query = "SELECT C.idCliente as id, c.nombres, c.apellidos, "
                    + "c.NIT, c.genero, c.telefono, c.correoElectronico, c.fechaIngreso from clientes as c;";
            nuevaConexion.abrirConexion();
            ResultSet consulta = nuevaConexion.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"ID", "Nombres", "Apellidos", "NIT", "Genero", "Telefono", "Correo", "FechaIngreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[8];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("nombres");
                datos[2] = consulta.getString("apellidos");
                datos[3] = consulta.getString("NIT");
                datos[4] = consulta.getString("genero");
                datos[5] = consulta.getString("telefono");
                datos[6] = consulta.getString("correoElectronico");
                datos[7] = consulta.getString("fechaIngreso");
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
            query = "INSERT INTO clientes(nombres, apellidos, NIT,"
                    + "genero, telefono, correoElectronico, fechaIngreso) VALUES(?,?,?,?,?,?,?);";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getNIT());
            parametro.setInt(4, getGenero());
            parametro.setString(5, getTelefono());
            parametro.setString(6, getCorreo());
            parametro.setString(7, getFechaIngreso());
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
            query = "update clientes set nombres=?, apellidos=?, NIT=?, genero=?, telefono=?, correoElectronico=?, fechaIngreso=? where idCliente = ?;";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getNIT());
            parametro.setInt(4, getGenero());
            parametro.setString(5, getTelefono());         
            parametro.setString(6, getCorreo());
            parametro.setString(7, getFechaIngreso());
            parametro.setInt(8, getId());
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
            query = "delete from clientes where idCliente = ?;";
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
