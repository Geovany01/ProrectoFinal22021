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
public class Ventas {
    
    public int no_factura;
    public String serie;
    public int id_cliente,id_empleado;
    
    private Conexion cn;
    
    
    public Ventas(){}

    public Ventas(int no_factura, String serie, int id_cliente, int id_empleado) {
        this.no_factura = no_factura;
        this.serie = serie;
        this.id_cliente = id_cliente;
        this.id_empleado = id_empleado;
    }


    

    public int getNo_factura() {
        return no_factura;
    }

    public void setNo_factura(int no_factura) {
        this.no_factura = no_factura;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }

   

    public int getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(int id_cliente) {
        this.id_cliente = id_cliente;
    }

    public int getId_empleado() {
        return id_empleado;
    }

    public void setId_empleado(int id_empleado) {
        this.id_empleado = id_empleado;
    }
    
     public HashMap drop_nit(){
    HashMap<String,String> drop = new HashMap();
    try{
        cn=new Conexion();
        String query="select idCliente as id, concat_ws('  ',NIT ,nombres) as nomnit from clientes;";
        cn.abrirConexion();
        ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
        while(consulta.next()){
        drop.put(consulta.getString("id"), consulta.getString("nomnit"));
        
        }
        
        cn.cerrarConexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    
    return drop;
    }
     
     public HashMap drop_empleado(){
    HashMap<String,String> drop1 = new HashMap();
    try{
        cn=new Conexion();
        String query="SELECT idEmpleado as id,nombres FROM empleados;";
        cn.abrirConexion();
        ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
        while(consulta.next()){
        drop1.put(consulta.getString("id"), consulta.getString("nombres"));
        
        }
        
        cn.cerrarConexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    
    return drop1;
    }
     
     public HashMap drop_fecha(){
    HashMap<String,String> drop2 = new HashMap();
    try{
        cn=new Conexion();
        String query=" SELECT  MAX(noFactura)+1 AS ID  , MAX(noFactura)+1 as fac FROM ventas;;";
        cn.abrirConexion();
        ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
        while(consulta.next()){
        drop2.put(consulta.getString("id"), consulta.getString("fac"));
        
        }
        
        cn.cerrarConexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    
    return drop2;
    }
    
    
    public int agregar(){
        int retorno =0;
    try {
    PreparedStatement parametro;
    cn = new Conexion();
    String query="INSERT INTO ventas(noFactura,serie,idCliente,idEmpleado) VALUES(?,?,?,?);";
    cn.abrirConexion();
    parametro=(PreparedStatement)cn.conexionBD.prepareStatement(query);
    parametro.setInt(1, getNo_factura());
     parametro.setString(2, getSerie());
      parametro.setInt(3, getId_cliente());
       parametro.setInt(4, getId_empleado());
        
          
         retorno = parametro.executeUpdate();
    
    
    cn.cerrarConexion();
        
        
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    retorno =0;
    }
    return retorno;
    }
    
    
    
}
