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
public class Proveedores {
    Conexion cn;
    public String proveedor, nit,direccion,telefono;
    private int id;

    public Proveedores(){}
    
    public Proveedores(String proveedor, String nit, String direccion, String telefono, int id) {
        this.proveedor = proveedor;
        this.nit = nit;
        this.direccion = direccion;
        this.telefono = telefono;
        this.id = id;
    }

    public String getProveedor() {
        return proveedor;
    }

    public void setProveedor(String proveedor) {
        this.proveedor = proveedor;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
    public HashMap leer(){
    HashMap<String, String> drop = new HashMap();
    try{
    cn = new Conexion();
    cn.abrir_conexion();
    String query = "select id_proveedor as id,proveedor from proveedores;";
     ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
     
     while (consulta.next()){
         drop.put(consulta.getString("id"), consulta.getString("proveedor"));
     }
    
    
    }catch(SQLException ex){
        System.out.println("error"+ex.getMessage());
    }
    return drop;
    
    }
    
    //---------------------------------Leer-----------------------------------------------------------

    public DefaultTableModel leerProv(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
        cn = new Conexion();
        cn.abrir_conexion();
        String query="SELECT id_proveedor as id, proveedor, nit, direccion,telefono FROM proveedores;";
       ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
       String encabezado []={"Id","PROVEEDOR","NIT","DIRECCION","TELEFONO"};
       tabla.setColumnIdentifiers(encabezado);
       String datos [] = new String[5];
       while (consulta.next()){
       datos[0]=consulta.getString("id");
       datos[1]=consulta.getString("proveedor");
       datos[2]=consulta.getString("nit");
       datos[3]=consulta.getString("direccion");
       datos[4]=consulta.getString("telefono");
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
        String query = "INSERT INTO proveedores(proveedor,nit,direccion,telefono)VALUES (?,?,?,?)";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getProveedor());
        parametro.setString(2, getNit());
        parametro.setString(3, getDireccion());
        parametro.setString(4, getTelefono());
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
        String query = "update proveedores set proveedor=?,nit=?,direccion=?,telefono=? where id_proveedor = ?;";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getProveedor());
        parametro.setString(2, getNit());
        parametro.setString(3, getDireccion());
        parametro.setString(4, getTelefono());
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
        String query = "delete from proveedores where id_proveedor = ?;";
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
