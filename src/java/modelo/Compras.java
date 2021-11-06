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
public class Compras {
    private 
	    int no_orden_compra,id_proveedor;

             private Conexion cn;
             
            public  Compras (){}

    public Compras( int no_orden_compra, int id_proveedor) {
     
        this.no_orden_compra = no_orden_compra;
        this.id_proveedor = id_proveedor;
    }

  
            
            
   

    public int getNo_orden_compra() {
        return no_orden_compra;
    }

    public void setNo_orden_compra(int no_orden_compra) {
        this.no_orden_compra = no_orden_compra;
    }

    public int getId_proveedor() {
        return id_proveedor;
    }

    public void setId_proveedor(int id_proveedor) {
        this.id_proveedor = id_proveedor;
    }
            
    
     public int agregar(){
        int retorno =0;
    try {
    PreparedStatement parametro;
    cn = new Conexion();
    String query="INSERT INTO compras(noOrdenCompra,idProveedor) VALUES(?,?);";
    cn.abrirConexion();
    parametro=(PreparedStatement)cn.conexionBD.prepareStatement(query);
    parametro.setInt(1, getNo_orden_compra());
     parametro.setInt(2, getId_proveedor());
     
        
          
         retorno = parametro.executeUpdate();
    
    
    cn.cerrarConexion();
        
        
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    retorno =0;
    }
    return retorno;
    }
            
    public HashMap drop_orden(){
    HashMap<String,String> drop2 = new HashMap();
    try{
        cn=new Conexion();
        String query=" SELECT  MAX(noOrdenCompra)+1 AS id  , MAX(noOrdenCompra)+1 as ord FROM compras;";
        cn.abrirConexion();
        ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
        while(consulta.next()){
        drop2.put(consulta.getString("id"), consulta.getString("ord"));
        
        }
        
        cn.cerrarConexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    
    return drop2;
    }
    
     public HashMap drop_proveedor(){
    HashMap<String,String> drop1 = new HashMap();
    try{
        cn=new Conexion();
        String query="SELECT idProveedor as id,proveedor FROM proveedores;";
        cn.abrirConexion();
        ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
        while(consulta.next()){
        drop1.put(consulta.getString("id"), consulta.getString("proveedor"));
        
        }
        
        cn.cerrarConexion();
    }catch(SQLException ex){
    System.out.println(ex.getMessage());
    }
    
    return drop1;
    } 
    
    
}
