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
public class Compras {
   Conexion cn;
    private String fecha_orden,fecha_ingreso;
    private int id,no_orden_compra,id_proveedor;

    public Compras(){}
    
    public Compras(String fecha_orden, String fecha_ingreso, int id, int no_orden_compra, int id_proveedor) {
        this.fecha_orden = fecha_orden;
        this.fecha_ingreso = fecha_ingreso;
        this.id = id;
        this.no_orden_compra = no_orden_compra;
        this.id_proveedor = id_proveedor;
    }
    
    public String getFecha_orden() {
        return fecha_orden;
    }

    public void setFecha_orden(String fecha_orden) {
        this.fecha_orden = fecha_orden;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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
    
   // ---------------------------------Leer-----------------------------------------------------------
public DefaultTableModel leer() {
    Conexion cn = new Conexion();
    DefaultTableModel tabla = new DefaultTableModel();
    try {
        cn.abrir_conexion();
        String query = "SELECT id_compra, no_orden_compra, id_proveedor, fecha_orden, fecha_ingreso FROM compras;";
        ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
        String encabezado[] = {"ID", "No. Orden", "Proveedor", "Fecha Orden", "Fecha Ingreso"};
        tabla.setColumnIdentifiers(encabezado);
        String datos[] = new String[5];
        while (consulta.next()) {
            datos[0] = consulta.getString("id_compra");
            datos[1] = consulta.getString("no_orden_compra");
            datos[2] = consulta.getString("id_proveedor");
            datos[3] = consulta.getString("fecha_orden");
            datos[4] = consulta.getString("fecha_ingreso");
            tabla.addRow(datos);
        }
        cn.cerrar_conexion();
    } catch (Exception e) {
        System.out.println("Error al leer compras: " + e.getMessage());
    }
    return tabla;
}
  //---------------------------------Leer-----------------------------------------------------------
   
 //---------------------------------Crear-----------------------------------------------------------
    public int crear(){
        int retorno =0;
    try{
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "INSERT INTO compras(no_orden_compra,id_proveedor,fecha_orden,fecha_ingreso)VALUES (?,?,?,?)";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setInt(1, getNo_orden_compra());
        parametro.setInt(2, getId_proveedor());
        parametro.setString(3, getFecha_orden());
        parametro.setString(4, getFecha_ingreso());
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
        String query = "update compras set no_orden_compra=?,id_proveedor=?,fecha_orden=?,fecha_ingreso =? where id_compra = ?;";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setInt(1, getNo_orden_compra());
        parametro.setInt(2, getId_proveedor());
        parametro.setString(3, getFecha_orden());
        parametro.setString(4, getFecha_ingreso());
        parametro.setInt(5, getId());
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
        String query = "delete from compras where id_compra = ?;";
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
