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
public class Producto {
    Conexion cn;
    private String producto,descripcion,imagen,fecha_ingreso;
    private int id,id_marca,existencia;
    private double precio_costo,precio_venta;

    public Producto(){}
    
    public Producto(String producto, String descripcion, String imagen, String fecha_ingreso, int id, int id_marca, int existencia, double precio_costo, double precio_venta) {
        this.producto = producto;
        this.descripcion = descripcion;
        this.imagen = imagen;
        this.fecha_ingreso = fecha_ingreso;
        this.id = id;
        this.id_marca = id_marca;
        this.existencia = existencia;
        this.precio_costo = precio_costo;
        this.precio_venta = precio_venta;
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

    public int getId_marca() {
        return id_marca;
    }

    public void setId_marca(int id_marca) {
        this.id_marca = id_marca;
    }

    public int getExistencia() {
        return existencia;
    }

    public void setExistencia(int existencia) {
        this.existencia = existencia;
    }

    public double getPrecio_costo() {
        return precio_costo;
    }

    public void setPrecio_costo(double precio_costo) {
        this.precio_costo = precio_costo;
    }

    public double getPrecio_venta() {
        return precio_venta;
    }

    public void setPrecio_venta(double precio_venta) {
        this.precio_venta = precio_venta;
    }
    
    public HashMap leer(){
    HashMap<String, String> drop = new HashMap();
    try{
    cn = new Conexion();
    cn.abrir_conexion();
    String query = "select id_producto as id,producto from productos;";
     ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
     
     while (consulta.next()){
         drop.put(consulta.getString("id"), consulta.getString("producto"));
     }
    
    
    }catch(SQLException ex){
        System.out.println("error"+ex.getMessage());
    }
    return drop;
    
    }
    
    //---------------------------------Leer-----------------------------------------------------------
    public DefaultTableModel leerpr(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
        cn = new Conexion();
        cn.abrir_conexion();
        String query="SELECT e.id_producto as id, e.producto,m.marca,m.id_marca, e.descripcion, e.imagen,e.precio_costo,e.precio_venta,e.existencia,e.fecha_ingreso FROM productos as e inner join marcas as m on e.id_marca=m.id_marca;";
       ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
       String encabezado []={"Id","PRODUCTO","MARCA","id_marca","DESCRIPCION","IMAGEN","PRECIO_COSTO","PRECIO_VENTA","EXISTENCIA","F_Ingreso"};
       tabla.setColumnIdentifiers(encabezado);
       String datos [] = new String[10];
       while (consulta.next()){
       datos[0]=consulta.getString("id");
       datos[1]=consulta.getString("producto");
       datos[2]=consulta.getString("marca");
       datos[3]=consulta.getString("id_marca");
       datos[4]=consulta.getString("descripcion");
       datos[5]=consulta.getString("imagen");
       datos[6]=consulta.getString("precio_costo");
       datos[7]=consulta.getString("precio_venta");
       datos[8]=consulta.getString("existencia");
       datos[9]=consulta.getString("fecha_ingreso");
       tabla.addRow(datos);
       }
       
        cn.cerrar_conexion();
        }catch(SQLException ex){
        System.out.println("Error"+ex.getMessage());
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
        String query = "INSERT INTO productos(producto,id_marca,descripcion,imagen,precio_costo,precio_venta,existencia,fecha_ingreso)VALUES (?,?,?,?,?,?,?,?)";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getProducto());
        parametro.setInt(2, getId_marca());
        parametro.setString(3, getDescripcion());
        parametro.setString(4, getImagen());
        parametro.setDouble(5, getPrecio_costo());
        parametro.setDouble(6, getPrecio_venta());
        parametro.setInt(7, getExistencia());
        parametro.setString(8, getFecha_ingreso());
        retorno = parametro.executeUpdate();
        System.out.println("se ingreso"+Integer.toString(retorno)+"Registro");
        cn.cerrar_conexion();
    }catch(SQLException ex){ 
        System.out.println("Error: "+ex.getMessage());
      
         
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
        String query = "update productos set producto=?,id_marca=?,descripcion=?,imagen=?,precio_costo=?,precio_venta=?,existencia=?,fecha_ingreso=? where id_producto = ?;";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getProducto());
        parametro.setInt(2, getId_marca());
        parametro.setString(3, getDescripcion());
        parametro.setString(4, getImagen());
        parametro.setDouble(5, getPrecio_costo());
        parametro.setDouble(6, getPrecio_venta());
        parametro.setInt(7, getExistencia());
        parametro.setString(8, getFecha_ingreso());
        parametro.setInt(9, getId());
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
        String query = "delete from productos where id_producto = ?;";
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
    
   // ------------------actualizarStockYPrecio ------------------
    public void actualizarStockYPrecio(int id_producto, int cantidad, double nuevoCosto) {
        try {
            Conexion cn = new Conexion();
            cn.abrir_conexion();
            String query = "UPDATE productos SET existencia = existencia + ?, precio_costo = ?, precio_venta = ? * 1.25 WHERE id_producto = ?";
            PreparedStatement ps = cn.conexionBD.prepareStatement(query);
            ps.setInt(1, cantidad);
            ps.setDouble(2, nuevoCosto);
            ps.setDouble(3, nuevoCosto);
            ps.setInt(4, id_producto);
            ps.executeUpdate();
            cn.cerrar_conexion();
            System.out.println("Stock y precios actualizados para el producto ID: " + id_producto);
        } catch (SQLException e) {
            System.out.println("Error al actualizar stock y precio: " + e.getMessage());
        }
    }

    //--------------------Disminuye existencia cuando se registra una venta-------------------------------
public void disminuirStock(int id_producto, int cantidad){
    try{
        Conexion cn = new Conexion();
        cn.abrir_conexion();
        String q = "UPDATE productos SET existencia = GREATEST(existencia - ?, 0) WHERE id_producto = ?";
        PreparedStatement ps = cn.conexionBD.prepareStatement(q);
        ps.setInt(1, cantidad);
        ps.setInt(2, id_producto);
        ps.executeUpdate();
        cn.cerrar_conexion();
    }catch(Exception e){
        System.out.println("Error al disminuir stock: " + e.getMessage());
    }
  
    }
}
