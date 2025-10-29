package modelo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.table.DefaultTableModel;

public class Ventas {
    Conexion cn;
    private String fecha_factura, fecha_ingreso, serie;
    private int id, no_factura, id_cliente, id_empleado;

    public Ventas(){}

    public Ventas(String fecha_factura, String fecha_ingreso, int id, int no_factura,
                  int id_cliente, int id_empleado, String serie) {
        this.fecha_factura = fecha_factura;
        this.fecha_ingreso = fecha_ingreso;
        this.id = id;
        this.no_factura = no_factura;
        this.id_cliente = id_cliente;
        this.id_empleado = id_empleado;
        this.serie = serie;
    }

    public String getFecha_factura() { return fecha_factura; }
    public void setFecha_factura(String fecha_factura) { this.fecha_factura = fecha_factura; }
    public String getFecha_ingreso() { return fecha_ingreso; }
    public void setFecha_ingreso(String fecha_ingreso) { this.fecha_ingreso = fecha_ingreso; }
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getNo_factura() { return no_factura; }
    public void setNo_factura(int no_factura) { this.no_factura = no_factura; }
    public int getId_cliente() { return id_cliente; }
    public void setId_cliente(int id_cliente) { this.id_cliente = id_cliente; }
    public int getId_empleado() { return id_empleado; }
    public void setId_empleado(int id_empleado) { this.id_empleado = id_empleado; }
    public String getSerie() { return serie; }
    public void setSerie(String serie) { this.serie = serie; }

    //------ -----------------------------LEER-----------------------------------------------------------
    public DefaultTableModel leer(){
        DefaultTableModel tabla = new DefaultTableModel();
        try{
            cn = new Conexion();
            cn.abrir_conexion();
            String query = "SELECT id_venta, no_factura, serie, id_cliente, id_empleado, fecha_factura, fecha_ingreso FROM ventas;";
            ResultSet rs = cn.conexionBD.createStatement().executeQuery(query);
            String encabezado[] = {"ID","NO_FACTURA","SERIE","ID_CLIENTE","ID_EMPLEADO","FECHA_FACTURA","FECHA_INGRESO"};
            tabla.setColumnIdentifiers(encabezado);
            String datos[] = new String[7];
            while(rs.next()){
                datos[0]=rs.getString("id_venta");
                datos[1]=rs.getString("no_factura");
                datos[2]=rs.getString("serie");
                datos[3]=rs.getString("id_cliente");
                datos[4]=rs.getString("id_empleado");
                datos[5]=rs.getString("fecha_factura");
                datos[6]=rs.getString("fecha_ingreso");
                tabla.addRow(datos);
            }
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error leer ventas: " + ex.getMessage());
        }
        return tabla;
    }

    //------------------------------ CREAR ----------------------------------------------------------
    public int crear(){
        int retorno=0;
        try{
            PreparedStatement ps;
            cn = new Conexion();
            cn.abrir_conexion();
            String q = "INSERT INTO ventas(no_factura, serie, fecha_factura, id_cliente, id_empleado, fecha_ingreso) VALUES (?,?,?,?,?,?)";
            ps = cn.conexionBD.prepareStatement(q);
            ps.setInt(1, getNo_factura());
            ps.setString(2, getSerie());
            ps.setString(3, getFecha_factura());
            ps.setInt(4, getId_cliente());
            ps.setInt(5, getId_empleado());
            ps.setString(6, getFecha_ingreso());
            retorno = ps.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error crear venta: " + ex.getMessage());
        }
        return retorno;
    }

    //----------------------------- ACTUALIZAR -----------------------------------------------------
    public int actualizar(){
        int retorno=0;
        try{
            PreparedStatement ps;
            cn = new Conexion();
            cn.abrir_conexion();
            String q = "UPDATE ventas SET no_factura=?, serie=?, fecha_factura=?, id_cliente=?, id_empleado=?, fecha_ingreso=? WHERE id_venta = ?";
            ps = cn.conexionBD.prepareStatement(q);
            ps.setInt(1, getNo_factura());
            ps.setString(2, getSerie());
            ps.setString(3, getFecha_factura());
            ps.setInt(4, getId_cliente());
            ps.setInt(5, getId_empleado());
            ps.setString(6, getFecha_ingreso());
            ps.setInt(7, getId());
            retorno = ps.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error actualizar venta: " + ex.getMessage());
        }
        return retorno;
    }

    //--------------------------------------- BORRAR ---------------------------------------------
    public int borrar(){
        int retorno=0;
        try{
            PreparedStatement ps;
            cn = new Conexion();
            cn.abrir_conexion();
            ps = cn.conexionBD.prepareStatement("DELETE FROM ventas WHERE id_venta = ?");
            ps.setInt(1, getId());
            retorno = ps.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error borrar venta: " + ex.getMessage());
        }
        return retorno;
    }
}