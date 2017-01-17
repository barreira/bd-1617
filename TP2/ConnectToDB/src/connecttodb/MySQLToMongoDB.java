/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connecttodb;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import org.bson.Document;

/**
 *
 * @author Carlos Pereira
 */
public class MySQLToMongoDB {
    
    private static ArrayList<Document> docs;
    
    public static void main(String[] args) {
        docs = new ArrayList<>();
        
        MongoDatabase db = null;
        MongoCollection<Document> table = null;
        MongoClient client = new MongoClient();

        db = client.getDatabase("reservas_Comboio");
        table = db.getCollection("reservas_Comboio"); 
        
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
                                "INNER JOIN estação e1 ON v.origem = e1.id\n" +
                                "INNER JOIN estação e2 ON v.destino = e2.id\n" +
                                "WHERE b.reserva = " + idReserva;
                
                ps = conn.prepareStatement(query2);
                ResultSet rs2 = ps.executeQuery();
                
                while(rs2.next()) {
                   String lugar = "SELECT * FROM lugar WHERE Comboio = " + rs2.getInt(11);
                   ps = conn.prepareStatement(lugar);
                   ResultSet numLugares = ps.executeQuery();
                   ArrayList<Document> lugares = new ArrayList<>();
                    
                   while(numLugares.next()) {
                       Document doc = new Document();
                       doc.append("Lugar", numLugares.getInt(1));
                       lugares.add(doc);
                   }
                   
                   
                   toMongo(rs2.getInt(1), rs2.getInt(2), rs2.getInt(3),
                           rs2.getString(4), rs2.getFloat(5), rs2.getInt(6),
                           rs2.getTimestamp(8), rs2.getTime(9), rs2.getInt(11),
                           rs2.getInt(12), rs2.getInt(13), rs2.getInt(15),
                           rs2.getString(17), rs2.getString(18),
                           rs2.getString(20), rs2.getString(21), lugares,
                           rs.getInt(1), rs.getString(2), rs.getString(3),
                           rs.getFloat(5), rs.getDate(7));
                }
            }
            
        } catch (Exception e) {
            
        } finally {
            try {
                table.insertMany(docs);
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
                                String paisDestino, ArrayList lugares,
                                int idCliente, String nomeCliente, String email,
                                float precoReserva, Date dataReserva) {
        
        Document document = new Document();
        Document cliente = new Document();
        Document reserva = new Document();
        Document bilhete = new Document();
        Document viagem = new Document();
        Document comboio = new Document();
        Document origem = new Document();
        Document destino = new Document();
        
        cliente.put("ID", idCliente);
        cliente.put("Nome", nomeCliente);
        cliente.put("E-Mail", email);
        
        reserva.put("ID", idReserva);
        reserva.put("Preço", precoReserva);
        reserva.put("Data", dataReserva.toString());
        
        bilhete.put("ID", idBilhete);
        bilhete.put("Lugar", lugar);
        bilhete.put("Classe", classe);
        bilhete.put("Preço", preco);
        
        origem.put("ID", idOrigem);
        origem.put("Localidade", localidadeOrigem);
        origem.put("País", paisOrigem);
        
        destino.put("ID", idDestino);
        destino.put("Localidade", localidadeDestino);
        destino.put("País", paisDestino);
        
        viagem.put("ID", idViagem);
        viagem.put("Partida", dataHoraPartida.toString());
        viagem.put("Duração", duracao.toString());
        viagem.put("Origem", origem);
        viagem.put("Destino", destino);
        
        comboio.put("ID", idComboio);
        comboio.put("Capacidade", capacidade);
        comboio.put("Lugares", lugares);

        
        document.put("Cliente", cliente);
        document.put("Reserva", reserva);
        document.put("Bilhete", bilhete);
        document.put("Viagem", viagem);
        document.put("Comboio", comboio);
        
        docs.add(document);
    }
}

class Connect {
    public static Connection connect() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/reservas_comboio?" +
                                   "user=root&password=qweqwe");
        return conn;   
    }
}