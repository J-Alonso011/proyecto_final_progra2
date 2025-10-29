package modelo;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Ventas_detalle {
    Conexion cn;
    private int id, id_venta, id_producto, cantidad;
    private double precio_unitario;

    public Ventas_detalle(){}

    public Ventas_detalle(int id, int id_venta, int id_producto, int cantidad, double precio_unitario) {
        this.id = id;
        this.id_venta = id_venta;
        this.id_producto = id_producto;
        this.cantidad = cantidad;
        this.precio_unitario = precio_unitario;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getId_venta() { return id_venta; }
    public void setId_venta(int id_venta) { this.id_venta = id_venta; }
    public int getId_producto() { return id_producto; }
    public void setId_producto(int id_producto) { this.id_producto = id_producto; }
    public int getCantidad() { return cantidad; }
    public void setCantidad(int cantidad) { this.cantidad = cantidad; }
    public double getPrecio_unitario() { return precio_unitario; }
    public void setPrecio_unitario(double precio_unitario) { this.precio_unitario = precio_unitario; }

    // ---------------------------Crear detalle-----------------------------------
    public int crear(){
        int retorno=0;
        try{
            PreparedStatement ps;
            cn = new Conexion();
            cn.abrir_conexion();
            String q="INSERT INTO ventas_detalle(id_venta, id_producto, cantidad, precio_unitario) VALUES (?,?,?,?)";
            ps = cn.conexionBD.prepareStatement(q);
            ps.setInt(1, getId_venta());
            ps.setInt(2, getId_producto());
            ps.setInt(3, getCantidad());
            ps.setDouble(4, getPrecio_unitario());
            retorno = ps.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error crear detalle venta: " + ex.getMessage());
        }
        return retorno;
    }

    public int actualizar(){
        int retorno=0;
        try{
            PreparedStatement ps;
            cn = new Conexion();
            cn.abrir_conexion();
            String q="UPDATE ventas_detalle SET id_venta=?, id_producto=?, cantidad=?, precio_unitario=? WHERE id_venta_detalle = ?";
            ps = cn.conexionBD.prepareStatement(q);
            ps.setInt(1, getId_venta());
            ps.setInt(2, getId_producto());
            ps.setInt(3, getCantidad());
            ps.setDouble(4, getPrecio_unitario());
            ps.setInt(5, getId());
            retorno = ps.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error actualizar detalle venta: " + ex.getMessage());
        }
        return retorno;
    }

    public int borrar(){
        int retorno=0;
        try{
            PreparedStatement ps;
            cn = new Conexion();
            cn.abrir_conexion();
            String q="DELETE FROM ventas_detalle WHERE id_venta_detalle = ?";
            ps = cn.conexionBD.prepareStatement(q);
            ps.setInt(1, getId());
            retorno = ps.executeUpdate();
            cn.cerrar_conexion();
        }catch(SQLException ex){
            System.out.println("Error borrar detalle venta: " + ex.getMessage());
        }
        return retorno;
    }
}
