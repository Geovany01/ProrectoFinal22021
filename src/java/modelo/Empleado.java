package modelo;

import java.awt.HeadlessException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class Empleado extends Persona {

    private String DPI;
    private int genero; 
    private int idPuesto;
    private String fechaInicioLabores;
    private String fechaIngreso;
    Conexion nuevaConexion;

    public Empleado() {

    }

    public Empleado(String DPI, int genero, String fechaInicioLabores, String fechaIngreso,
            int idPuesto, int id, String nombres, String apellidos, String direccion, 
            String telefono, String fechaNacimiento) {
        super(id, nombres, apellidos, direccion, telefono, fechaNacimiento);
        this.DPI = DPI;
        this.genero = genero;
        this.fechaInicioLabores = fechaInicioLabores;
        this.fechaIngreso = fechaIngreso;
        this.idPuesto = idPuesto;
    }

    public String getDPI() {
        return DPI;
    }

    public void setDPI(String DPI) {
        this.DPI = DPI;
    }
    
    public int getGenero() {
        return genero;
    }

    public void setGenero(int genero) {
        this.genero = genero;
    }
    
    public String getFechaInicioLabores() {
        return fechaInicioLabores;
    }

    public void setFechaInicioLabores(String fechaInicioLabores) {
        this.fechaInicioLabores = fechaInicioLabores;
    }

    public String getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public int getIdPuesto() {
        return idPuesto;
    }

    public void setIdPuesto(int idPuesto) {
        this.idPuesto = idPuesto;
    }

    public DefaultTableModel leer() {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            nuevaConexion = new Conexion();
            String query = "SELECT e.idEmpleado as id,e.nombres,e.apellidos,e.direccion,"
                    + "e.telefono,e.DPI,e.genero,e.fechaNacimiento,p.puesto,e.idPuesto,e.fechaInicioLabores, "
                    + "e.fechaIngreso FROM empleados as e inner join puestos as p on e.idPuesto = p.idPuesto;";
            nuevaConexion.abrirConexion();
            ResultSet consulta = nuevaConexion.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"ID", "Nombres", "Apellidos", "Direccion", 
                "Telefono", "DPI", "Genero", "FNacimiento", "Puesto", "idPuesto", "FechaInicioLabores", "FechaIngreso"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[12];
            while(consulta.next()) {
                datos[0] = consulta.getString("id");
            datos[1] = consulta.getString("nombres");
            datos[2] = consulta.getString("apellidos");
            datos[3] = consulta.getString("direccion");
            datos[4] = consulta.getString("telefono");
            datos[5] = consulta.getString("DPI");
            datos[6] = consulta.getString("genero");
            datos[7] = consulta.getString("fechaNacimiento");
            datos[8] = consulta.getString("puesto");
            datos[9] = consulta.getString("fechaInicioLabores");
            datos[10] = consulta.getString("fechaIngreso");
            datos[11] = consulta.getString("idPuesto");
                tabla.addRow(datos);
            }
            nuevaConexion.cerrarConexion();
        } catch(Exception ex) {
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
            query = "INSERT INTO empleados(nombres, apellidos, direccion,"
                    + "telefono, DPI, genero, fechaNacimiento, idPuesto, fechaInicioLabores, fechaIngreso) VALUES(?,?,?,?,?,?,?,?,?,?);";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setString(5, getDPI());
            parametro.setInt(6, getGenero());
            parametro.setString(7, getFechaNacimiento());
            parametro.setInt(8, getIdPuesto());
            parametro.setString(9, getFechaInicioLabores());
            parametro.setString(10, getFechaIngreso());
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
            query = "update empleados set nombres=?, apellidos=?, direccion=?,"
                    + "telefono=?, DPI=?, genero=?, fechaNacimiento=?, idPuesto=?, fechaInicioLabores=?, fechaIngreso=? where idEmpleado = ?;";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getNombres());
            parametro.setString(2, getApellidos());
            parametro.setString(3, getDireccion());
            parametro.setString(4, getTelefono());
            parametro.setString(5, getDPI());
            parametro.setInt(6, getGenero());
            parametro.setString(7, getFechaNacimiento());
            parametro.setInt(8, getIdPuesto());
            parametro.setString(9, getFechaInicioLabores());
            parametro.setString(10, getFechaIngreso());
            parametro.setInt(11, getId());
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
            query = "delete from empleados where idEmpleado = ?;";
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
