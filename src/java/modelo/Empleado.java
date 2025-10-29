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
public class Empleado extends Persona {
    Conexion cn;
    private String direccion,dpi,fecha_nacimiento,fecha_inicio_labores;
    private int id,id_puesto;

    
    public Empleado(){}
    
    public Empleado(String direccion, String dpi, String fecha_nacimiento, String fecha_inicio_labores, int id, int id_puesto, String nombres, String apellidos, String telefono, String fecha_ingreso, boolean genero) {
        super(nombres, apellidos, telefono, fecha_ingreso, genero);
        this.direccion = direccion;
        this.dpi = dpi;
        this.fecha_nacimiento = fecha_nacimiento;
        this.fecha_inicio_labores = fecha_inicio_labores;
        this.id = id;
        this.id_puesto = id_puesto;
    }
    
      public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getDpi() {
        return dpi;
    }

    public void setDpi(String dpi) {
        this.dpi = dpi;
    }

    public String getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(String fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getFecha_inicio_labores() {
        return fecha_inicio_labores;
    }

    public void setFecha_inicio_labores(String fecha_inicio_labores) {
        this.fecha_inicio_labores = fecha_inicio_labores;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId_puesto() {
        return id_puesto;
    }

    public void setId_puesto(int id_puesto) {
        this.id_puesto = id_puesto;
    }

    public HashMap<String, String> leerCombo() {
    HashMap<String, String> drop = new HashMap<>();
    try {
        cn = new Conexion();
        cn.abrir_conexion();
        String query = "SELECT id_empleado AS id, CONCAT(nombres, ' ', apellidos) AS empleado FROM empleados;";
        ResultSet consulta = cn.conexionBD.createStatement().executeQuery(query);
        while (consulta.next()) {
            drop.put(consulta.getString("id"), consulta.getString("empleado"));
        }
        cn.cerrar_conexion();
    } catch (SQLException ex) {
        System.out.println("Error en leerCombo Empleado: " + ex.getMessage());
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
        String query="SELECT e.id_empleado as id, e.nombres, e.apellidos, e.direccion,e.telefono,e.dpi,e.genero,e.fecha_nacimiento,p.puesto,p.id_puesto,e.fecha_inicio_labores,e.fecha_ingreso FROM empleados as e inner join puestos as p on e.id_puesto=p.id_puesto;";
       ResultSet consulta= cn.conexionBD.createStatement().executeQuery(query);
       String encabezado []={"Id","NOMBRES","APELLIDOS","DIRECCION","TELEFONO","DPI","GENERO","NACIMIENTO","PUESTO","id_puesto","F_labores","F_Ingreso"};
       tabla.setColumnIdentifiers(encabezado);
       String datos [] = new String[12];
       while (consulta.next()){
       datos[0]=consulta.getString("id");
       datos[1]=consulta.getString("nombres");
       datos[2]=consulta.getString("apellidos");
       datos[3]=consulta.getString("direccion");
       datos[4]=consulta.getString("telefono");
       datos[5]=consulta.getString("dpi");
       String generoBD = consulta.getString("genero");
            if (generoBD.equals("1") || generoBD.equalsIgnoreCase("true")) {
                datos[6] = "Hombre";
            } else {
                datos[6] = "Mujer";
            }
       datos[7]=consulta.getString("fecha_nacimiento");
       datos[8]=consulta.getString("puesto");
       datos[9]=consulta.getString("id_puesto");
       datos[10]=consulta.getString("fecha_inicio_labores");
       datos[11]=consulta.getString("fecha_ingreso");
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
        String query = "INSERT INTO empleados(nombres,apellidos,direccion,telefono,dpi,genero,fecha_nacimiento,id_puesto,fecha_inicio_labores,fecha_ingreso)VALUES (?,?,?,?,?,?,?,?,?,?)";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getNombres());
        parametro.setString(2, getApellidos());
        parametro.setString(3, getDireccion());
        parametro.setString(4, getTelefono());
        parametro.setString(5, getDpi());
        parametro.setBoolean(6, getGenero());
        parametro.setString(7, getFecha_nacimiento());
        parametro.setInt(8, getId_puesto());
        parametro.setString(9, getFecha_inicio_labores());
        parametro.setString(10, getFecha_ingreso());
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
        String query = "update empleados set nombres=?,apellidos=?,direccion=?,telefono=?,dpi=?,genero=?,fecha_nacimiento=?,id_puesto=?,fecha_inicio_labores=?, fecha_ingreso=? where id_empleado = ?;";
        parametro=(PreparedStatement) cn.conexionBD.prepareStatement(query);
        parametro.setString(1, getNombres());
        parametro.setString(2, getApellidos());
        parametro.setString(3, getDireccion());
        parametro.setString(4, getTelefono());
        parametro.setString(5, getDpi());
        parametro.setBoolean(6, getGenero());
        parametro.setString(7, getFecha_nacimiento());
        parametro.setInt(8, getId_puesto());
        parametro.setString(9, getFecha_inicio_labores());
        parametro.setString(10, getFecha_ingreso());
        parametro.setInt(11, getId());
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
        String query = "delete from empleados where id_empleado = ?;";
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
