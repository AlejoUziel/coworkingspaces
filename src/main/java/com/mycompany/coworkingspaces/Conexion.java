package com.mycompany.coworkingspaces;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion {
    private static final String URL = "jdbc:mysql://mysql.us.cloudlogin.co:3306/roatan_202310070132";
    private static final String USER = "roatan_202310070132"; // tu usuario MySQL
    private static final String PASSWORD = "4pRv3M9zL-"; // tu contraseña si tienes

    public static Connection conectar() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conexion exitosa a la base de datos");
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error al conectar a la base de datos" + e.getMessage());
        }
        return conn;
    }
}
