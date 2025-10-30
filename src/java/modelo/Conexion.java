/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author alons
 */
public class Conexion {
    public Connection conexionBD;
    private final String puerto = "3306";
    private final String bd = "db_progra2";
    private final String urlConexion = String.format("jdbc:mysql://localhost:%s/%s?serverTimezone=UTC", puerto, bd);
    private final String usuario = "root";
    private final String contra = "01346795";
    private final String jdbc = "com.mysql.cj.jdbc.Driver";

    // 🔹 CAMBIO AQUÍ: ahora devuelve la conexión
    public Connection abrir_conexion() {
        try {
            Class.forName(jdbc);
            conexionBD = DriverManager.getConnection(urlConexion, usuario, contra);
            System.out.println("✅ Conexión Exitosa a " + bd);
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("❌ Error al conectar: " + ex.getMessage());
        }
        return conexionBD; // 🔹 ESTA LÍNEA es la clave
    }

    public void cerrar_conexion() {
        try {
            if (conexionBD != null && !conexionBD.isClosed()) {
                conexionBD.close();
                System.out.println("🔒 Conexión cerrada correctamente");
            }
        } catch (SQLException ex) {
            System.out.println("❌ Error al cerrar conexión: " + ex.getMessage());
        }
    }
}
