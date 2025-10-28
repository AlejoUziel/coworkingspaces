/*
 * --------------------------------------------------------------------------
 * Autor: Uziel Alejandro Garcia
 * Fecha de Creación: 20-10-2025
 * Proyecto/Módulo: co-working
 * --------------------------------------------------------------------------
 * ADVERTENCIA DE DERECHOS DE AUTOR:
 * Este código es propiedad intelectual de Uziel Alejandro Garcia.
 * Queda estrictamente prohibida su reproducción, distribución, modificación
 * o reclamación de autoría por terceros sin permiso expreso.
 * Todos los derechos reservados.
 * --------------------------------------------------------------------------
 */
package com.mycompany.coworkingspaces;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    private static final String URL = "jdbc:mysql://mysql.us.cloudlogin.co:3306/roatan_202310070132";
    private static final String USER = "roatan_202310070132"; // Verifica si el usuario es este exacto
    private static final String PASSWORD = "4pRv3M9zL-";

    public static Connection getConexion() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("La conexion funciono...");
        } catch (SQLException e) {
            System.out.println("La conexion valio..." + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }

    public static void main(String[] args) {
        getConexion(); // Ejecuta esa prueba
    }
}

