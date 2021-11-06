/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;


public class InicioSesion {

    public String usuario, contraseña;
    private Conexion cn;

    public InicioSesion() {
    }

    public InicioSesion(String usuario, String contraseña) {
        this.usuario = usuario;
        this.contraseña = contraseña;
    }

    public String getusuario() {
        return usuario;
    }

    public void setusuario(String usuario) {
        this.usuario = usuario;
    }

    public String getIdpuesto() {
        return contraseña;
    }

    public void setIdpuesto(String contraseña) {
        this.contraseña = contraseña;
    }

    public int VerificarCredenciales() {
        int resultado = 0;

        try {

            cn = new Conexion();
            cn.abrirConexion();

            String query = "SELECT COUNT(*) resultado FROM users WHERE user='" + usuario + "' AND pass='" + contraseña + "'";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);

            while (consulta.next()) {
                resultado = consulta.getInt("resultado");
            }
            cn.cerrarConexion();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            resultado = -1;
        }
        return resultado;
    }

    public int SolicitarRol() {
        int resultado = 0;

        try {

            cn = new Conexion();
            cn.abrirConexion();

            String query = "SELECT rol resultado FROM users WHERE user='" + usuario + "' AND pass='" + contraseña + "'";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);

            while (consulta.next()) {
                resultado = consulta.getInt("resultado");
            }
            cn.cerrarConexion();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            resultado = -1;
        }
        return resultado;
    }

    public DefaultTableModel GenerarMenu(String codigo) {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrirConexion();
            String query = "SELECT menu_id  id,menu_nombre nombre,link FROM menu where id_padre=0;";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"id", "nombre", "link"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[12];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("nombre");
                datos[2] = consulta.getString("link");
                tabla.addRow(datos);
            }
            cn.cerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }
    public DefaultTableModel GenerarSubMenu(String codigo) {
        DefaultTableModel tabla = new DefaultTableModel();
        try {
            cn = new Conexion();
            cn.abrirConexion();
            String query = "SELECT menu_id  id,menu_nombre nombre,link FROM menu where id_padre="+codigo+"";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"id", "nombre", "link"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[12];
            while (consulta.next()) {
                datos[0] = consulta.getString("id");
                datos[1] = consulta.getString("nombre");
                datos[2] = consulta.getString("link");
                tabla.addRow(datos);
            }
            cn.cerrarConexion();
        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
        return tabla;
    }
    public String LinkImage() {
        String resultado = "";

        try {

            cn = new Conexion();
            cn.abrirConexion();

            String query = "SELECT LinkImage resultado FROM users WHERE Usuario='" + usuario + "'";
            ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);

            while (consulta.next()) {
                resultado = consulta.getString("resultado");
            }
            cn.cerrarConexion();
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            resultado = "";
        }
        return resultado;
    }

}
