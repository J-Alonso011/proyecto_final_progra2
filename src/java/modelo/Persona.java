/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author alons
 */
abstract class Persona {
    private String nombres,apellidos,telefono,fecha_ingreso;
    private boolean genero;
    
    public Persona(){}
    
    public Persona(String nombres, String apellidos, String telefono, String fecha_ingreso, boolean genero) {
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.telefono = telefono;
        this.fecha_ingreso = fecha_ingreso;
        this.genero = genero;
    }
    
    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getFecha_ingreso() {
        return fecha_ingreso;
    }

    public void setFecha_ingreso(String fecha_ingreso) {
        this.fecha_ingreso = fecha_ingreso;
    }

    public boolean getGenero() {
        return genero;
    }

    public void setGenero(boolean genero) {
        this.genero = genero;
    }
    
    protected int crear(){return 0;}
    protected DefaultTableModel leer(){return null;}
    protected int actualizar(){return 0;}       
    protected int borrar(){return 0;}
   
}
