/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connecttodb;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBObject;
import com.mongodb.Mongo;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import java.lang.Object.*;
import org.bson.Document;
import java.net.UnknownHostException;

/**
 *
 * @author Carlos Pereira
 */
public class ConnectToMongoDB {
    
    public static void main(String[] args) {
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
        document.put("name", "Andre"); 
        document.put("age", 34);
        //BasicDBObject document2 = new BasicDBObject();
        Document document2 = new Document();
        document2.put("name", "Beatrix");
        document2.put("age", 19);
        table.insertOne(document); 
        table.insertOne(document2); 
    }
}

