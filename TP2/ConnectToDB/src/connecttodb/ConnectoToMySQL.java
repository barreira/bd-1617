/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connecttodb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Carlos Pereira
 */
public class ConnectoToMySQL {
    
    public static void main(String[] args) {

        Connection conn = null;
    
        try {
            conn = Connect.connect();
            
            PreparedStatement ps = conn.prepareStatement("SELECT * from estação");
            
            
            
            /*PreparedStatement ps = conn.prepareStatement("INSERT into estação " + 
                                                         "(id,Localidade,País) " + 
                                                         "VALUES (71,'A tua prima','BemBoa');");


            ps.executeUpdate();
            ps.execute();
             
             
            PreparedStatement ps2 = conn.prepareStatement("SELECT * from estação");
 
            ResultSet rs = ps2.executeQuery();
            while(rs.next())  
                System.out.println(rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3));  
            */
                
        }catch(SQLException | ClassNotFoundException e){ 
                e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
/*
class Connect {
    public static Connection connect() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/reservas_comboio?" +
                                   "user=root&password=qweqwe");
        return conn;   
    }
}
*/