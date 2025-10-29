/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import javax.swing.table.DefaultTableModel;
/**
 *
 * @author alons
 */
public class Puesto {
        Conexion cn;
        private int id;
        private String puesto;

    public Puesto(){}
    public Puesto(int id,String puesto) {
        this.puesto = puesto;
        this.id=id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPuesto() {
        return puesto;
    }

    public void setPuesto(String puesto) {
        this.puesto = puesto;
    }
    
    public HashMap leer(){
    HashMap<String, String> drop = new HashMap();
    try{
    cn = new Conexion();
    cn.abrir_conexion();
    String query = "select id_puesto as id, puesto from puestos;";
     ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
     
     while (consulta.next()){
         drop.put(consulta.getString("id"), consulta.getString("puesto"));
     }
    
    
    }catch(SQLException ex){
        System.out.println("error"+ex.getMessage());
    }
    return drop;
    
    }
    
   
    //---------------------------------Leer-----------------------------------------------------------
    public DefaultTableModel leerp(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
        cn = new Conexion();
        cn.abrir_conexion();
        String query="SELECT id_puesto as id,puesto FROM puestos;";
       ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
       String encabezado []={"Id","PUESTO"};
       tabla.setColumnIdentifiers(encabezado);
       String datos [] = new String[2];
       while (consulta.next()){
       datos[0]=consulta.getString("id");
       datos[1]=consulta.getString("puesto");
       tabla.addRow(datos);
       }
       
        cn.cerrar_conexion();
        }catch(SQLException ex){
        System.out.println("Error"+ex.getMessage());
        }
        return tabla;
    //---------------------------------Leer-----------------------------------------------------------
    //---------------------------------Crear-----------------------------------------------------------
    }

    public int crear(){
        int retorno =0;
    try{
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "INSERT INTO puestos(puesto)VALUES (?)";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getPuesto());
        retorno = parametro.executeUpdate();
        System.out.println("se ingreso"+Integer.toString(retorno)+"Registro");
        cn.cerrar_conexion();
    }catch(SQLException ex){
        System.out.println("Error"+ex.getMessage());
    }
    return retorno;
    }
    //---------------------------------Crear-----------------------------------------------------------
    //---------------------------------actualizar-----------------------------------------------------------
    public int actualizar(){
        int retorno =0;
    try{
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "update puestos set puesto=? where id_puesto = ?;";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getPuesto());
        parametro.setInt(2, getId());
        retorno = parametro.executeUpdate();
        System.out.println("se actualizo"+Integer.toString(retorno)+"Registro");
        cn.cerrar_conexion();
    }catch(SQLException ex){
        System.out.println("Error"+ex.getMessage());
    }
     return retorno;
    }
    //---------------------------------actualizar-----------------------------------------------------------
    //---------------------------------borrar-----------------------------------------------------------
    public int borrar(){
        int retorno =0;
    try{
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "delete from puestos where id_puesto = ?;";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setInt(1, getId());
        retorno = parametro.executeUpdate();
        System.out.println("se elimino" + Integer.toString(retorno)+"Registro");
        cn.cerrar_conexion();
    }catch(SQLException ex){
        System.out.println("Error"+ex.getMessage());
    }
    return retorno;
    }
    //---------------------------------borrar-----------------------------------------------------------
   
}
