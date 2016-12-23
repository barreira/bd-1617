/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package migracaomysqltomongodb;

import java.net.UnknownHostException;
import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.Mongo;
import java.util.List;

/**
 *
 * @author Carlos Pereira
 */
public class MigracaoMySQLtoMongoDB {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Mongo mongo = null;
        DB db=null;
        DBCollection table=null;// Connection to the MongoDB-Server
        mongo = new Mongo("localhost", 27017); 

        //get the connections
        db = mongo.getDB("testdb"); 
        table = db.getCollection("testcoll"); //create document and insert
        
        table.drop();
        
        //listar todas as bases de dados
        System.out.println("Bases de Dados");
        List<String> dbs = mongo.getDatabaseNames();
        for (String dbset : dbs) {
            System.out.println(dbset);
        }
        
        //insert data
        /*
        BasicDBObject document = new BasicDBObject();
        document.put("name", "Andre");
        document.put("age", 34);
        
        BasicDBObject document2 = new BasicDBObject();
        document2.put("name", "Beatrix"); 
        document2.put("age", 19); 
        
        table.insert(document); 
        table.insert(document2);
        */
    }
    
}
