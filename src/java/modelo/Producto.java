
package modelo;

import java.awt.HeadlessException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;

public class Producto {
    private int idProducto, idMarca, existencia;
    private String producto, descripcion,imagen,fechaIngreso;
    private Float precioCosto, precioVenta;
    private Conexion nuevaConexion;

    public Producto(){}

    public Producto(int idProducto, int idMarca, int existencia, String producto, String descripcion, String imagen, String fechaIngreso, Float precioCosto, Float precioVenta) {
        this.idProducto = idProducto;
        this.idMarca = idMarca;
        this.existencia = existencia;
        this.producto = producto;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.fechaIngreso = fechaIngreso;
        this.precioCosto = precioCosto;
        this.precioVenta = precioVenta;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public int getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(int idMarca) {
        this.idMarca = idMarca;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getFechaIngreso() {
        return fechaIngreso;
    }

    public void setFechaIngreso(String fechaIngreso) {
        this.fechaIngreso = fechaIngreso;
    }

    public Float getPrecioCosto() {
        return precioCosto;
    }

    public void setPrecioCosto(Float precioCosto) {
        this.precioCosto = precioCosto;
    }

    public Float getPrecioVenta() {
        return precioVenta;
    }

    public void setPrecioVenta(Float precioVenta) {
        this.precioVenta = precioVenta;
    }   
    
    public HashMap dropSangre() {
        HashMap<String, String> drop = new HashMap();
        try {
            String query = "SELECT idProducto as id, producto FROM productos;";
            nuevaConexion = new Conexion();
            nuevaConexion.abrirConexion();
            ResultSet consulta = nuevaConexion.conexionBD.createStatement().executeQuery(query);
            while (consulta.next()) {
                drop.put(consulta.getString("id"), consulta.getString("producto"));
            }
            nuevaConexion.cerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return drop;
    }
    
public DefaultTableModel leer(){
 DefaultTableModel tabla = new DefaultTableModel();
 try{
     nuevaConexion = new Conexion();
     nuevaConexion.abrirConexion();
      String query = "SELECT p.idProducto as id,p.producto,m.marca,p.idMarca,p.descripcion,p.imagen,p.precioCosto,p.precioVenta,p.existencia,p.fechaIngreso FROM productos as p inner join marcas as m on p.idMarca = m.idMarca;";
      ResultSet consulta = nuevaConexion.conexionBD.createStatement().executeQuery(query);
      String encabezado[] = {"id","producto","idmarca","descripcion","imagen","precioCosto","precioVenta","existencia","fechaIngreso","marca"};
      tabla.setColumnIdentifiers(encabezado);
      String datos[] = new String[10];
      while (consulta.next()){
          datos[0] = consulta.getString("id");
          datos[1] = consulta.getString("producto");
          datos[2] = consulta.getString("marca");
          datos[3] = consulta.getString("descripcion");
          datos[4] = consulta.getString("imagen");
          datos[5] = consulta.getString("precioCosto");
          datos[6] = consulta.getString("precioVenta");
          datos[7] = consulta.getString("existencia");
          datos[8] = consulta.getString("fechaIngreso");
          datos[9] = consulta.getString("idMarca");
          tabla.addRow(datos);
      
      }
      
     nuevaConexion.cerrarConexion();
 }catch(SQLException ex){
     System.out.println(ex.getMessage());
 }
 return tabla;
 }
    
    public int agregar(){
        int retorno = 0;
        try{
            PreparedStatement parametro;
            nuevaConexion = new Conexion();
            String query = "INSERT INTO productos (producto, idMarca, descripcion, imagen, precioCosto, precioVenta, existencia, fechaIngreso) VALUES (?,?,?,?,?,?,?,?);";
            nuevaConexion.abrirConexion();
            parametro = (PreparedStatement)nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getProducto());
            parametro.setInt(2, getIdMarca());
            parametro.setString(3, getDescripcion());
            parametro.setString(4, getImagen());
            parametro.setFloat(5, getPrecioCosto());
            parametro.setFloat(6, getPrecioVenta());
            parametro.setInt(7, getExistencia());
            parametro.setString(8, getFechaIngreso());
            retorno = parametro.executeUpdate();
            nuevaConexion.cerrarConexion();
        }catch(Exception ex){
            System.out.println(ex.getMessage());
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
            query = "update productos set producto=?, idMarca=?, descripcion=?,"
                    + "imagen=?, precioCosto=?, precioVenta=?, existencia=?, fechaIngreso=? where idProducto = ?;";
            parametro = (PreparedStatement) nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setString(1, getProducto());
            parametro.setInt(2, getIdMarca());
            parametro.setString(3, getDescripcion());
            parametro.setString(4, getImagen());
            parametro.setFloat(5, getPrecioCosto());
            parametro.setFloat(6, getPrecioVenta());
            parametro.setInt(7, getExistencia());
            parametro.setString(8, getFechaIngreso());
            parametro.setInt(9, getIdProducto());
            retorno = parametro.executeUpdate();
            nuevaConexion.cerrarConexion();
        } catch (HeadlessException | SQLException ex) {
            System.out.println("Error..." + ex.getMessage());
            retorno = 0;
        }
        return retorno;
    }
    
    
    public int eliminar (){
        int retorno =0;
        try{
            PreparedStatement parametro;
            nuevaConexion = new Conexion();
            String query = "delete from productos  where idProducto = ?;";
            nuevaConexion.abrirConexion();
            parametro = (PreparedStatement)nuevaConexion.conexionBD.prepareStatement(query);
            parametro.setInt(1, getIdProducto());
            retorno = parametro.executeUpdate();
            nuevaConexion.cerrarConexion();
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    return retorno;
    }
}
