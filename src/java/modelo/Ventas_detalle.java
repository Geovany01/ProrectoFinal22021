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
public class Ventas_detalle {
    private 
	    int id,id_venta , id_producto,cantidad ;
            float precio_unitario ,subtotal;

             private Conexion cn;
   public Ventas_detalle(){}

    public Ventas_detalle(int id,int id_venta, int id_producto, int cantidad, float precio_unitario, float subtotal) {
        this.id=id;
        this.id_venta = id_venta;
        this.id_producto = id_producto;
        this.cantidad = cantidad;
        this.precio_unitario = precio_unitario;
        this.subtotal = subtotal;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    
    
    public int getId_venta() {
        return id_venta;
    }

    public void setId_venta(int id_venta) {
        this.id_venta = id_venta;
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

    public float getPrecio_unitario() {
        return precio_unitario;
    }

    public void setPrecio_unitario(float precio_unitario) {
        this.precio_unitario = precio_unitario;
    }

    public float getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(float subtotal) {
        this.subtotal = subtotal;
    }
     
     public HashMap drop_id_vmx(){
    HashMap<String,String> drop3 = new HashMap();
    try{
        cn=new Conexion();
        String query="SELECT MAX(idventa), Max(idVenta)  FROM ventas;";
        cn.abrirConexion();
        ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
        while(consulta.next()){
        drop3.put(consulta.getString("Max(idVenta)"), consulta.getString("Max(idVenta)"));
        
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
        String query="select idProducto, producto from productos;";
        cn.abrirConexion();
        ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
        while(consulta.next()){
        drop03.put(consulta.getString("idProducto"), consulta.getString("producto"));
        
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
    String query="INSERT INTO ventas_detalle(idVenta,idProducto,cantidad,precioUnitario,subtotal) VALUES(?,?,?,?,?);";
    cn.abrirConexion();
    parametro=(PreparedStatement)cn.conexionBD.prepareStatement(query);
    parametro.setInt(1, getId_venta());
     parametro.setInt(2, getId_producto());
      parametro.setInt(3, getCantidad());
       parametro.setFloat(4, getPrecio_unitario());
        parametro.setFloat(5, getSubtotal());
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
               String query = "select  c.idVentaDetalle as id,c.idVenta,p.producto,d.marca,c.cantidad,c.precioUnitario,c.subtotal from ventas_detalle as c inner join productos as p on c.idProducto= p.idProducto  inner join marcas as d on c.idProducto=d.idMarca     where idVenta =(select MAX(idVenta) from ventas_detalle);";
            cn.abrirConexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
String encabezado[] = {"ventaD","Venta","producto","marca","cantidad","precio unitario","subtotal"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] =new String[7];
            while (consulta.next()){
           
            
            datos[0] = consulta.getString("id");
            datos[1] = consulta.getString("idVenta");
            datos[2] = consulta.getString("producto");
            datos[3] = consulta.getString("marca");
            datos[4] = consulta.getString("cantidad");
            datos[5] = consulta.getString("precioUnitario");
            datos[6] = consulta.getString("subtotal");
           
        
            tabla.addRow(datos);
            
            }
            
           
            cn.abrirConexion();
            
        }catch(SQLException ex){
           System.out.println("Error" + ex.getMessage());  
        }
        return tabla;
    
    }
     
          public DefaultTableModel leerventa(){
        DefaultTableModel tabla1 = new DefaultTableModel();
        try{
            cn = new Conexion();
            String query = "select c.idVenta,c.noFactura,c.serie,c.fechaFactura,concat_ws('  ',p.nombres,p.apellidos) as cli,p.NIT,f.nombres,c.fechaIngreso from ventas as c inner join clientes as p on c.idCliente = p.idCliente inner join ventas as m on c.idVenta = m.idVenta inner join empleados as f on c.idEmpleado = f.idEmpleado Where c.idVenta =(select MAX(idVenta) from ventas);";
            cn.abrirConexion();
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
String encabezado[] = {"Venta","No.Factura","Serie","Fecha","Cliente","Nit","Empleado","Fecha ingreso"};
            tabla1.setColumnIdentifiers(encabezado);
            String datos[] =new String[8];
            while (consulta.next()){
            datos[0] = consulta.getString("c.idVenta");
            datos[1] = consulta.getString("c.noFactura");
            datos[2] = consulta.getString("c.serie");
            datos[3] = consulta.getString("c.fechaFactura");
            datos[4] = consulta.getString("cli");
            datos[5] = consulta.getString("p.NIT");
            datos[6] = consulta.getString("f.nombres");
            datos[7] = consulta.getString("c.fechaIngreso");
        
            tabla1.addRow(datos);
            
            }
            cn.cerrarConexion();
            
        }catch(SQLException ex){
           System.out.println("Error" + ex.getMessage());  
        }
        return tabla1;
    
    }
          
    public int modificar(){
      int retorno =0;
    try {
    PreparedStatement parametro;
    cn = new Conexion();
    String query="update ventas_detalle set idProducto=?,cantidad=?,precioUnitario=?,subtotal=?  where idVentaDetalle=? ;";
    cn.abrirConexion();
    parametro=(PreparedStatement)cn.conexionBD.prepareStatement(query);
    parametro.setInt(1, getId_producto());
     parametro.setInt(2, getCantidad());
      parametro.setFloat(3, getPrecio_unitario());
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
    
    
    public int eliminar(){
     int retorno =0;
    try {
    PreparedStatement parametro;
    cn = new Conexion();
    String query="delete from ventas_detalle  where idVentaDetalle=? ;";
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
    
        public int modificarP(){
      int retorno =0;
    try {
    PreparedStatement parametro;
    cn = new Conexion();
    String query="update productos set existencia= existencia-?   where idProducto=? ;";
    cn.abrirConexion();
    parametro=(PreparedStatement)cn.conexionBD.prepareStatement(query);
  
     parametro.setInt(1, getCantidad());
       parametro.setInt(2, getId_producto());
     
          
         retorno = parametro.executeUpdate();
    
    
    cn.cerrarConexion();
        
        
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    retorno =0;
    }
    return retorno;
    
    
    } 
          
    
            
}
