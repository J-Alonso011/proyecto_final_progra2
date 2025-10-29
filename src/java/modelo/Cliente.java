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
public class Cliente extends Persona {
   
    Conexion cn;
     private String nit,correo_electronico;
     private int id;

        public Cliente(){}
     
        public Cliente(String nit, String correo_electronico, int id, String nombres, String apellidos, String telefono, String fecha_ingreso, boolean genero) {
        super(nombres, apellidos, telefono, fecha_ingreso, genero);
        this.nit = nit;
        this.correo_electronico = correo_electronico;
        this.id = id;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getCorreo_electronico() {
        return correo_electronico;
    }

    public void setCorreo_electronico(String correo_electronico) {
        this.correo_electronico = correo_electronico;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public HashMap<String, String> leerCombo() {
    HashMap<String, String> drop = new HashMap<>();
    try {
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "SELECT id_cliente AS id, CONCAT(nombres, ' ', apellidos, ' - ', nit) AS cliente FROM clientes;";
        ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
        while (consulta.next()) {
            drop.put(consulta.getString("id"), consulta.getString("cliente"));
        }
        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println("Error en leerCombo Cliente: " + ex.getMessage());
    }
    return drop;
}
    
     //---------------------------------Leer-----------------------------------------------------------
    @Override
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
        cn = new Conexion();
        cn.abrir_conexion();
        String query="SELECT id_cliente as id, nombres, apellidos, nit,genero,telefono,correo_electronico,fecha_ingreso FROM clientes;";
       ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
       String encabezado []={"Id","NOMBRES","APELLIDOS","NIT","GENERO","TELEFONO","CORREO","F_Ingreso"};
       tabla.setColumnIdentifiers(encabezado);
       String datos [] = new String[8];
       while (consulta.next()){
       datos[0]=consulta.getString("id");
       datos[1]=consulta.getString("nombres");
       datos[2]=consulta.getString("apellidos");
       datos[3]=consulta.getString("nit");
       String generoBD = consulta.getString("genero");
            if (generoBD.equals("1") || generoBD.equalsIgnoreCase("true")) {
                datos[4] = "Hombre";
            } else {
                datos[4] = "Mujer";
            }
       datos[5]=consulta.getString("telefono");
       datos[6]=consulta.getString("correo_electronico");
       datos[7]=consulta.getString("fecha_ingreso");
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
    @Override
    public int crear(){
        int retorno =0;
    try{
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "INSERT INTO clientes(nombres,apellidos,nit,genero,telefono,correo_electronico,fecha_ingreso)VALUES (?,?,?,?,?,?,?)";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getNombres());
        parametro.setString(2, getApellidos());
        parametro.setString(3, getNit());
        parametro.setBoolean(4, getGenero());
        parametro.setString(5, getTelefono());
        parametro.setString(6, getCorreo_electronico());
        parametro.setString(7, getFecha_ingreso());
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
    @Override
    public int actualizar(){
        int retorno =0;
    try{
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "update clientes set nombres=?,apellidos=?,nit=?,genero=?,telefono=?,correo_electronico=?, fecha_ingreso=? where id_cliente = ?;";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getNombres());
        parametro.setString(2, getApellidos());
        parametro.setString(3, getNit());
        parametro.setBoolean(4, getGenero());
        parametro.setString(5, getTelefono());
        parametro.setString(6, getCorreo_electronico());
        parametro.setString(7, getFecha_ingreso());
        parametro.setInt(8, getId());
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
    @Override
    public int borrar(){
        int retorno =0;
    try{
        PreparedStatement parametro;
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "delete from clientes where id_cliente = ?;";
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
