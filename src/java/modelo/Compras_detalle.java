/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.sql.PreparedStatement;
import javax.swing.table.AbstractTableModel;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author mutsu
 */
public class Compras_detalle {
    
    private int id,id_compra,id_producto,cantidad;
            float precio_costo,subtotal;
            
    private Conexion cn;
    public Compras_detalle(){}

    public Compras_detalle(int id, int id_compra, int id_producto, int cantidad, float precio_costo, float subtotal) {
        this.id = id;
        this.id_compra = id_compra;
        this.id_producto = id_producto;
        this.cantidad = cantidad;
        this.precio_costo = precio_costo;
        this.subtotal = subtotal;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_compra() {
        return id_compra;
    }

    public void setId_compra(int id_compra) {
        this.id_compra = id_compra;
    }

    public int getId_producto() {
        return id_producto;
    }

    public void setId_producto(int id_producto) {
        this.id_producto = id_producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public float getPrecio_costo() {
        return precio_costo;
    }

    public void setPrecio_costo(float precio_costo) {
        this.precio_costo = precio_costo;
    }

    public float getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }
    
     public HashMap drop_id_compra(){
    HashMap<String,String> drop3 = new HashMap();
    try{
        cn=new Conexion();
        String query="SELECT MAX(idCompra), Max(idCompra)  FROM compras;";
        cn.abrirConexion();
        ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
        while(consulta.next()){
        drop3.put(consulta.getString("Max(idCompra)"), consulta.getString("Max(idCompra)"));
        
        }
        
        cn.cerrarConexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
   
    return drop3;
    } 
     
     public HashMap drop_product(){
    HashMap<String,String> drop03 = new HashMap();
    try{
        cn=new Conexion();
        String query="select c.idProducto, concat_ws( '    ' ,c.producto,p.marca) as pm from productos as c inner join marcas as p on c.idMarca = p.idMarca;";
        cn.abrirConexion();
        ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
        while(consulta.next()){
        drop03.put(consulta.getString("c.idProducto"), consulta.getString("pm"));
        
        }
        
        cn.cerrarConexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
   
    return drop03;
    }

     
     
    public int agregar(){
        int retorno =0;
    try {
    PreparedStatement parametro;
    cn = new Conexion();
    String query="INSERT INTO compras_detalle(idCompra,idProducto,cantidad,precioCostoUnitario,subtotal) VALUES(?,?,?,?,?);";
    cn.abrirConexion();
    parametro=(PreparedStatement)cn.conexionBD.prepareStatement(query);
    parametro.setInt(1, getId_compra());
     parametro.setInt(2, getId_producto());
      parametro.setInt(3, getCantidad());
       parametro.setFloat(4, getPrecio_costo());
        parametro.setFloat(5, getSubtotal());
         retorno = parametro.executeUpdate();
        
    
    
    cn.cerrarConexion();
        
        
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    retorno =0;
    }
    return retorno;
    } 
     
    
        public int modificar(){
      int retorno =0;
    try {
    PreparedStatement parametro;
    cn = new Conexion();
    String query="update compras_detalle set idProducto=?,cantidad=?,precioCostoUnitario=?,subtotal=?  where idCompraDetalle=? ;";
    cn.abrirConexion();
    parametro=(PreparedStatement)cn.conexionBD.prepareStatement(query);
    parametro.setInt(1, getId_producto());
     parametro.setInt(2, getCantidad());
      parametro.setFloat(3, getPrecio_costo());
       parametro.setFloat(4, getSubtotal());
       
           parametro.setInt(5, getId());
          
         retorno = parametro.executeUpdate();
    
    
    cn.cerrarConexion();
        
        
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    retorno =0;
    }
    return retorno;
    
    
    }
     
     
     public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            String query = "select  c.idCompraDetalle as id,c.idCompra,p.producto,d.marca,c.cantidad,c.precioCostoUnitario,c.subtotal from compras_detalle as c inner join productos as p on c.idProducto= p.idProducto  inner join marcas as d on c.idProducto=d.idMarca     where idCompra =(select MAX(idCompra) from compras_detalle);";
            cn.abrirConexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
String encabezado[] = {"ventaD","Venta","producto","marca","cantidad","precio unitario","subtotal"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] =new String[7];
            while (consulta.next()){
           
            
            datos[0] = consulta.getString("id");
            datos[1] = consulta.getString("idCompra");
            datos[2] = consulta.getString("producto");
            datos[3] = consulta.getString("marca");
            datos[4] = consulta.getString("cantidad");
            datos[5] = consulta.getString("precioCostoUnitario");
            datos[6] = consulta.getString("subtotal");
           
        
            tabla.addRow(datos);
            
            }
            
           
            cn.cerrarConexion();
            
        }catch(SQLException ex){
           System.out.println("Error" + ex.getMessage());  
        }
        return tabla;
    
    } 
     
     
     
     public DefaultTableModel leerventa(){
        DefaultTableModel tabla1 = new DefaultTableModel();
        try{
            cn = new Conexion();
            String query = " select c.idCompra,c.noOrdenCompra,c.fechaOrden,p.proveedor, c.fechaIngreso from compras as c inner join proveedores as p on c.idProveedor = p.idProveedor  Where c.idCompra =(select MAX(idCompra) from compras);";
            cn.abrirConexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
String encabezado[] = {"Compra","No.Orden","Fecha orden","Proveedor","Fecha ingreso"};
            tabla1.setColumnIdentifiers(encabezado);
            String datos[] =new String[5];
            while (consulta.next()){
            datos[0] = consulta.getString("c.idCompra");
            datos[1] = consulta.getString("c.noOrdenCompra");
            datos[2] = consulta.getString("c.fechaOrden");
            datos[3] = consulta.getString("p.proveedor");
            datos[4] = consulta.getString("c.fechaIngreso");
            
        
            tabla1.addRow(datos);
            
            }
            cn.cerrarConexion();
            
        }catch(SQLException ex){
           System.out.println("Error" + ex.getMessage());  
        }
        return tabla1;
    
    } 
     
    
     
      public int eliminar(){
     int retorno =0;
    try {
    PreparedStatement parametro;
    cn = new Conexion();
    String query="delete from compras_detalle where idCompraDetalle=?;";
    cn.abrirConexion();
    parametro=(PreparedStatement)cn.conexionBD.prepareStatement(query);
    
           parametro.setInt(1, getId());
          
         retorno = parametro.executeUpdate();
    
    
    cn.cerrarConexion();
        
        
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    retorno =0;
    }
    return retorno;
    
    
    } 
      
       public int modificarcp(){
      int retorno =0;
    try {
    PreparedStatement parametro;
    cn = new Conexion();
    String query="update productos set existencia=existencia + ?, precioCosto=?, precioVenta=(precioCosto*0.25)+precioCosto   where idProducto=? ;";
    cn.abrirConexion();
    parametro=(PreparedStatement)cn.conexionBD.prepareStatement(query);
     parametro.setInt(1, getCantidad());
      parametro.setFloat(2, getPrecio_costo());
      parametro.setInt(3, getId_producto());
       
      
         retorno = parametro.executeUpdate();
    
    
    cn.cerrarConexion();
        
        
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    retorno =0;
    }
    return retorno;
    
    
    }
    
}
