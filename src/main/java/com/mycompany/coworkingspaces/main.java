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

import javax.swing.JFrame;

public class main {
    public static void main(String[] args) {
        // Crear la ventana de login
        login ventana = new login();
        ventana.setTitle("Co-Working | Inicio de Sesión");
        ventana.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        ventana.setLocationRelativeTo(null); // Centra la ventana
        ventana.setVisible(true);
    }
}
