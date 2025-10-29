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
public class Compras_detalle {
    private Conexion cn;
    public int id,id_compra,id_producto,cantidad;
    private double precio_costo_unitario;

    
    public Compras_detalle(){}
    
    public Compras_detalle(int id, int id_compra, int id_producto, int cantidad, double precio_costo_unitario) {
        this.id = id;
        this.id_compra = id_compra;
        this.id_producto = id_producto;
        this.cantidad = cantidad;
        this.precio_costo_unitario = precio_costo_unitario;
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
    
    public double getPrecio_costo_unitario() {
        return precio_costo_unitario;
    }

    public void setPrecio_costo_unitario(double precio_costo_unitario) {
        this.precio_costo_unitario = precio_costo_unitario;
    }
    
  // ---------------------------------Leer-----------------------------------------------------------
public DefaultTableModel leer() {
    Conexion cn = new Conexion();
    DefaultTableModel tabla = new DefaultTableModel();
    try {
        cn.abrir_conexion();
        String query = "SELECT id_compra_detalle, id_compra, id_producto, cantidad, precio_costo_unitario FROM compras_detalle;";
        ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
        String encabezado[] = {"ID Detalle", "ID Compra", "ID Producto", "Cantidad", "Precio Costo Unitario"};
        tabla.setColumnIdentifiers(encabezado);
        String datos[] = new String[5];
        while (consulta.next()) {
            datos[0] = consulta.getString("id_compra_detalle");
            datos[1] = consulta.getString("id_compra");
            datos[2] = consulta.getString("id_producto");
            datos[3] = consulta.getString("cantidad");
            datos[4] = consulta.getString("precio_costo_unitario");
            tabla.addRow(datos);
        }
        cn.cerrar_conexion();
    } catch (Exception e) {
        System.out.println("Error al leer detalle de compras: " + e.getMessage());
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
        String query = "INSERT INTO compras_detalle(id_compra,id_producto,cantidad,precio_costo_unitario)VALUES (?,?,?,?)";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setInt(1, getId_compra());
        parametro.setInt(2, getId_producto());
        parametro.setInt    (3, getCantidad());
        parametro.setDouble(4, getPrecio_costo_unitario());
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
        String query = "update compras_detalle set id_compra=?,id_producto=?,cantidad=?,precio_costo_unitario =? where id_compra_detalle = ?;";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setInt(1, getId_compra());
        parametro.setInt(2, getId_producto());
        parametro.setInt    (3, getCantidad());
        parametro.setDouble(4, getPrecio_costo_unitario());
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
        String query = "delete from compras_detalle where id_compra_detalle = ?;";
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
