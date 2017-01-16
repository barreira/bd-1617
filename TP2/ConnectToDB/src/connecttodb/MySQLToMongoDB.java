/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connecttodb;

import com.mongodb.Mongo;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.bson.Document;

/**
 *
 * @author Carlos Pereira
 */
public class MySQLToMongoDB {
    public static void main(String[] args) {
        Connection conn = null;
        try {
            
            conn = Connect.connect();
            String query = "SELECT * FROM cliente c LEFT JOIN reserva r ON c.id = r.cliente";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                int idReserva = rs.getInt(4);
                String query2 = "SELECT * FROM bilhete b INNER JOIN viagem v ON b.viagem = v.id\n" +
                                "INNER JOIN comboio c ON c.id = v.comboio\n" +
                                "INNER JOIN lugar l ON c.id = l.comboio\n" +
                                "INNER JOIN estação e1 ON v.origem = e1.id\n" +
                                "INNER JOIN estação e2 ON v.destino = e2.id\n" +
                                "WHERE b.reserva = " + idReserva;
                
                ps = conn.prepareStatement(query2);
                ResultSet rs2 = ps.executeQuery();
                
                while(rs2.next()) {
                   //System.out.println(rs2.getString(4));
                   toMongo(rs2.getString(4));
                }
            }
            
        } catch (Exception e) {
            
        } finally {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    
    
    private static void toMongo(String str) {
        Mongo mongo = null;
        MongoDatabase db=null;
        MongoCollection<Document> table=null;
        MongoClient client = new MongoClient();

        //insert data 
        db = client.getDatabase("test");
        table = db.getCollection("test"); 

        //create document and insert
        Document document = new Document();
        
        //BasicDBObject document = new BasicDBObject();
        document.put("tipo", str); 
        //document.put("age", 34);
        //BasicDBObject document2 = new BasicDBObject();
        //Document document2 = new Document();
        //document2.put("name", "Beatrix");
        //document2.put("age", 19);
        table.insertOne(document); 
        //table.insertOne(document2); 
    }
}
