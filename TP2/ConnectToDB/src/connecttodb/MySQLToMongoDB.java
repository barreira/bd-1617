/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connecttodb;

import com.mongodb.BasicDBList;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import org.bson.Document;

/**
 *
 * @author Carlos Pereira
 */
public class MySQLToMongoDB {
    
    private static ArrayList<Document> docs;
    
    public static void main(String[] args) {
        docs = new ArrayList<>();
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
                   toMongo(rs2.getInt(1), rs2.getInt(2), rs2.getInt(3),
                           rs2.getString(4), rs2.getFloat(5), rs2.getInt(6),
                           rs2.getTimestamp(8), rs2.getTime(9), rs2.getInt(11),
                           rs2.getInt(12), rs2.getInt(13), rs2.getInt(15),
                           rs2.getString(19), rs2.getString(20),
                           rs2.getString(22), rs2.getString(23));
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
    
    
    
    private static void toMongo(int idBilhete, int lugar, int idViagem,
                                String classe, float preco, int idReserva,
                                Timestamp dataHoraPartida, Time duracao,
                                int idComboio, int idOrigem, int idDestino,
                                int capacidade, String localidadeOrigem,
                                String paisOrigem, String localidadeDestino,
                                String paisDestino) {
        Mongo mongo = null;
        MongoDatabase db=null;
        MongoCollection<Document> table=null;
        MongoClient client = new MongoClient();

        db = client.getDatabase("reservas_Comboio");
        table = db.getCollection("reservas_Comboio"); 

        Document document = new Document();
        
        document.put("ID Bilhete", idBilhete);
        document.put("Número lugar", lugar);
        document.put("ID Viagem", idViagem);
        document.put("Classe", classe);
        document.put("Preço", preco);
        document.put("ID Reserva", idReserva);
        document.put("Partida", dataHoraPartida.toString());
        document.put("Duração", duracao.toString());
        document.put("ID Comboio", idComboio);
        document.put("ID Origem", idOrigem);
        document.put("ID Destino", idDestino);
        document.put("Capacidade", capacidade);
        document.put("Localidade Origem", localidadeOrigem);
        document.put("País Origem", paisOrigem);
        document.put("Localidade Destino", localidadeDestino);
        document.put("País Destino", paisDestino);
        
        docs.add(document);
        
        //table.insertOne(document); 

    }
}

/* //create document and insert
        Document document = new Document();
        //document.append(str, table);
        //document.p
        HashMap<String, String> map = new HashMap<>();
        map.put("campo1", "valor1");
        map.put("campo1", "valor2");
        map.put("campo1", "valor3");
        document.putAll(map);
        document.append("campo2", "valor2");
        document.append("campo3", "valor3");
        Document document2 = new Document();
        Document document3 = new Document();
        //document2.append("campo", document);
        document2.put("teste", document);
        
        int [] array =  {1, 2, 3};
        // BasicDBList b = new BasicDBList();
        ArrayList<Integer> a = new ArrayList<>();
        a.add(1);
        a.add(2);
        a.add(3);
        document3.put("comboios", a);
        //document3.put("key", document2);
        //BasicDBObject document = new BasicDBObject();
        //document.put("tipo", str); 
        //document.put("age", 34);
        //BasicDBObject document2 = new BasicDBObject();
        //Document document2 = new Document();
        //document2.put("name", "Beatrix");
        //document2.put("age", 19);
        table.insertOne(document3); 
        //table.insertOne(document2); */
