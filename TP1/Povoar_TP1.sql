delimiter $$
CREATE TRIGGER calcPreco
	AFTER INSERT ON bilhete
	FOR EACH ROW	
BEGIN
	UPDATE reserva
		SET Preço = Preço + NEW.Preço
		WHERE ID = NEW.Reserva;
END;$$ 


INSERT INTO cliente
	(id,nome,username,password,email)
	VALUES (1,'Ana Carvalho','anacarvalho','acarvalho2000','anacarvalho@gmail.com'),
		   (2,'João Costa','joaocosta','jcosta2','joaocosta@gmail.com'),
           (3,'Pedro Ferreira','pedroferreira','ferreira','pedroferreira@hotmail.com'),
           (4,'Eva Silva','evasilva','es2016','evasilva@live.com'),
           (5,'Hugo Fernandes','hugofernandes','hugo10f','hugofernandes@gmail.com'),
           (6,'Mário Felgueiras','mariofelgueiras','mfelgueiras','mariofelgueiras@hotmail.com'),
           (7,'Lucas Martins','lucasmartins','lucasm16','lucasmartins@gmail.com'),
           (8,'Mariana Lemos','marianalemos','lemosm','marianalemos@gmail.com'),
           (9,'Joana Abreu','joanaabreu','jabreu7777','joanabreu@gmail.com'),
           (10,'Luciana Sousa','lucianasousa','lucsousa','lucianasousa@hotmail.com'),
           (11,'Helder Silva','heldersilva','h152silva','heldersilva@gmail.com'),
           (12,'Amélia Gonçalves','ameliagonçalves','goncalvesa','ameliagoncalves@gmail.com'),
           (13,'Helena Queirós','hqueiros','4444queiros4444','helenaqs@gmail.com'),
           (14,'Francisco Henriques','fhenriques','fhs2015','franciscoh@gmail.com'),
           (15,'Joel Pereira','joelpereira','jpereira4','joelpereira@gmail.com'),
           (16,'Ana Sofia','anasofia','anasofiana','anasofia@gmail.com'),
           (17,'Maria Ribeiro','mariaribeiro','mr3151321','mariaribeiro@hotmail.com'),
           (18,'Luis Monteiro','luismonteiro','lmonteiro1111','luismonteiro@gmail.com'),
           (19,'António Miranda','antoniomiranda','amiranda','antmiranda@gmail.com'),
           (20,'Luisa Mendes','luisamendes','lmendes','luisamendes@gmail.com'),
           (21,'Rita Fonseca','ritafonseca','ritafs','ritafonseca@gmail.com'),
           (22,'Miguel Coelho','miguelcoelho','m74coelho','miguelcoelho@gmail.com'),
           (23,'Ricardo Nunes','ricnunes','ricardonn','ricardonunes@hotmail.com'),
           (24,'Manuel Araujo','manuAraujo','manelAraujo','manelaraujo@live.com'),
           (25,'Pedro Fraga','pedrofraga','pedro222fraga','pedrofraga@gmail.com'),
           (26,'Teresa Pinto','teresapinto','tpinto','teresapinto@hotmail.com'),
           (27,'Simão Mendes','simaomendes','smendes','simaomendes@gmail.com'),
           (28,'Rafael Miranda','rafaelmiranda','rmiranda','rafaelmiranda@gmail.com'),
           (29,'Tiago Barbosa','tiagobarbosa','tbarbosa','tiagobarbosa@gmail.com');
           
INSERT into estação
	(id,Localidade,País)
    VALUES (1,'Porto','Portugal'),
		   (2,'Coimbra','Portugal'),
           (3,'Aveiro','Portugal'),
           (4,'Madrid','Espanha'),
           (5,'Lisboa','Portugal'),
           (6,'Vigo','Espanha'),
           (7,'Braga','Portugal'),
           (8,'Algarve','Portugal'),
           (9,'Bragança','Portugal'),
           (10,'Setubal','Portugal'),
           (11,'Abrantes','Portugal'),
           (12,'Leiria','Portugal'),
           (13,'Mirandela','Portugal'),
           (14,'Viana do Castelo','Portugal');

INSERT INTO viagem
	(ID,DataPartida,Duração,PreçoBase,Comboio,Origem,Destino)
    VALUES (1,'2016-11-19 21:00:00','00:22:00',25,2,7,9), -- dia 1
           (2,'2016-11-19 18:00:00','02:30:00',30,1,7,8),
           (3,'2016-11-19 08:00:00','00:10:00',13,3,3,5),
           (4,'2016-11-19 13:00:00','01:25:00',23,4,10,13),
		   (5,'2016-11-19 16:00:00','00:32:00',25,2,5,2),
           (6,'2016-11-19 09:00:00','00:50:00',30,1,12,13),
           (7,'2016-11-19 14:00:00','00:40:00',13,5,1,5),
           (8,'2016-11-19 12:00:00','00:45:00',17,4,3,8),
           (9,'2016-11-19 10:00:00','00:18:00',19,5,14,6),
           (10,'2016-11-19 16:00:00','00:08:00',22,2,13,9),
           (11,'2016-11-19 22:00:00','02:10:00',35,1,14,5),
           (12,'2016-11-19 17:00:00','00:36:00',25,2,9,7), -- dia 2
           (13,'2016-11-20 16:00:00','01:55:00',30,1,8,7),
           (14,'2016-11-20 17:00:00','01:10:00',13,3,5,3),
           (15,'2016-11-20 19:00:00','01:25:00',23,4,13,10),
		   (16,'2016-11-20 18:00:00','00:22:00',25,2,2,5),
           (17,'2016-11-21 20:00:00','00:30:00',30,1,11,12),
           (18,'2016-11-21 07:00:00','00:40:00',13,5,5,12),-- dia 3
           (19,'2016-11-21 06:00:00','00:45:00',17,4,8,3),
           (20,'2016-11-21 09:00:00','01:18:00',19,5,6,14),
           (21,'2016-11-21 07:00:00','00:08:00',22,2,9,13),
           (22,'2016-11-22 23:00:00','00:58:00',35,1,7,9),
           (23,'2016-11-22 10:00:00','00:12:00',25,2,1,3), -- dia 4
           (24,'2016-11-22 11:00:00','02:30:00',30,1,3,4),
           (25,'2016-11-22 04:00:00','04:10:00',13,3,4,8),
           (26,'2016-11-22 19:00:00','01:25:00',23,4,6,9),
		   (27,'2016-11-22 11:00:00','03:32:00',25,2,4,5),
           (28,'2016-11-22 15:00:00','01:50:00',30,1,8,7),
           (29,'2016-11-22 21:00:00','00:20:00',13,5,2,5),
           (30,'2016-11-22 12:00:00','01:45:00',17,4,8,7),
           (31,'2016-11-23 22:00:00','02:18:00',19,5,6,12),-- dia 5
           (32,'2016-11-23 13:00:00','00:48:00',22,2,10,3),
           (33,'2016-11-23 14:00:00','02:10:00',35,1,5,4),
           (34,'2016-11-23 09:00:00','01:18:00',19,5,6,14),
           (35,'2016-11-23 07:00:00','00:08:00',22,2,9,13),
           (36,'2016-11-23 23:00:00','00:58:00',35,1,7,9),
           (37,'2016-11-23 10:00:00','00:12:00',25,2,1,3), 
           (38,'2016-11-23 11:00:00','02:30:00',30,1,3,4),
           (39,'2016-11-23 04:00:00','04:10:00',13,3,4,8),-- dia 6
           (40,'2016-11-24 06:00:00','00:45:00',17,4,8,3),
           (41,'2016-11-24 09:00:00','01:18:00',19,5,6,14),
           (42,'2016-11-24 07:00:00','00:08:00',22,2,9,13),
           (43,'2016-11-24 23:00:00','00:58:00',35,1,7,9),
           (44,'2016-11-25 08:00:00','00:10:00',13,3,3,5),-- dia 7
           (45,'2016-11-25 13:00:00','01:25:00',23,4,10,13),
		   (46,'2016-11-25 16:00:00','00:32:00',25,2,5,2),
           (47,'2016-11-25 09:00:00','00:50:00',30,1,12,13),
           (48,'2016-11-25 14:00:00','00:40:00',13,5,1,5),
           (49,'2016-11-25 12:00:00','00:45:00',17,4,3,8),
           (50,'2016-11-25 10:00:00','00:18:00',19,5,14,6);        
 
INSERT INTO bilhete
	(id,classe,preço,lugar,reserva,viagem)
    VALUES (1,'Normal',25,5,1,1),
		   (2,'Estudante',20,6,1,1),
           (3,'Sénior',22.5,4,1,1),
           (4,'Normal',23,4,2,4),
           (5,'Jovem',27,4,3,2),
           (6,'Normal',25,12,4,1),
		   (7,'Estudante',20,15,4,1),
           (8,'Sénior',31.5,4,5,11),
           (9,'Normal',17,4,6,8),
           (10,'Jovem',22.5,4,7,5),
           (11,'Normal',25,3,8,1),
           (12,'Estudante',24,6,9,47),
           (13,'Sénior',17.1,4,10,50),
           (14,'Normal',22,5,11,21),
           (15,'Normal',35,6,12,22),
           (16,'Normal',35,7,12,22),
           (17,'Normal',35,8,12,22),
		   (18,'Sénior',22.5,12,13,23),
           (19,'Normal',25,15,14,23),
           (20,'Jovem',27,4,15,24),
           (21,'Normal',30,3,15,24),
           (22,'Normal',13,5,16,25),
		   (23,'Estudante',10.4,6,16,25),
           (24,'Sénior',11.7,4,16,25),
           (25,'Normal',13,14,16,25),
           (26,'Jovem',20.7,4,17,26),
           (27,'Sénior',22.5,4,18,27),
           (28,'Normal',30,1,19,28),
           (29,'Jovem',27,2,19,28),
           (30,'Normal',13,3,20,29),
           (31,'Estudante',16.3,6,21,30),
           (32,'Sénior',17.1,12,21,31),
           (33,'Sénior',17.1,9,21,31),
           (34,'Normal',19,10,21,31),
           (35,'Jovem',17.1,11,21,31),
           (36,'Normal',22,3,22,32),
           (37,'Estudante',28,6,23,33),
           (38,'Sénior',17.1,4,24,34),
           (39,'Normal',22,4,25,35),
           (40,'Jovem',19.8,5,25,35),
           (41,'Normal',35,3,26,36),
           (42,'Estudante',28,6,26,36),
           (43,'Sénior',31.5,4,26,36),
           (44,'Normal',25,5,27,37),
           (45,'Normal',30,6,28,38),
           (46,'Normal',13,5,29,39),
		   (47,'Estudante',10.4,6,29,39),
           (48,'Sénior',15.3,4,30,40),
           (49,'Normal',19,4,31,41),
           (50,'Jovem',17.1,5,31,41),
           (51,'Normal',19,12,31,41),
		   (52,'Estudante',17.6,15,32,42),
           (53,'Normal',35,3,33,43),
           (54,'Estudante',28,6,33,43),
           (55,'Sénior',31.5,4,33,43),
           (56,'Normal',13,3,34,44),
           (57,'Estudante',18.4,6,35,45),
           (58,'Sénior',22.5,4,37,46),
           (59,'Estudante',10.4,12,38,39),
           (60,'Sénior',15.3,9,39,40),
           (61,'Normal',19,10,40,41),
           (62,'Normal',13,3,41,48),
           (63,'Estudante',16.3,3,42,30),
           (64,'Sénior',17.1,3,43,31),
           (65,'Sénior',17.1,8,43,31),
           (66,'Normal',25,5,16,12),
		   (67,'Estudante',20,13,44,12),
           (68,'Sénior',22.5,17,44,12),
           (69,'Normal',25,15,44,12),
           (70,'Jovem',27,13,45,13),
           (71,'Sénior',11.7,13,46,14),
           (72,'Normal',23,13,47,15),
           (73,'Jovem',20.7,14,47,15),
           (74,'Normal',25,1,48,16),
           (75,'Estudante',20,8,48,16),
           (76,'Normal',30,12,49,17),
		   (77,'Estudante',10.4,15,50,18);
           
           

INSERT INTO reserva
	(id,preço,cliente)
    VALUES (1,0,5),
		   (2,0,11),
           (3,0,5),
           (4,0,14),
           (5,0,15),
           (6,0,21),
           (7,0,28),
           (8,0,1),
		   (9,0,2),
           (10,0,7),
           (11,0,6),
           (12,0,19),
           (13,0,29),
           (14,0,26),
           (15,0,21),
		   (16,0,23),
           (17,0,24),
           (18,0,17),
           (19,0,16),
           (20,0,13),
           (21,0,12),
           (22,0,10),
		   (23,0,9),
           (24,0,8),
           (25,0,18),
           (26,0,19),
           (27,0,24),
           (28,0,25),
           (29,0,5),
		   (30,0,11),
           (31,0,5),
           (32,0,14),
           (33,0,15),
           (34,0,21),
           (35,0,28),
           (36,0,1),
		   (37,0,2),
           (38,0,7),
           (39,0,6),
           (40,0,19),
           (41,0,29),
           (42,0,26),
           (43,0,5),
		   (44,0,23),
           (45,0,24),
           (46,0,17),
           (47,0,16),
           (48,0,13),
           (49,0,12),
           (50,0,10);

INSERT INTO comboio
	(Id)
    VALUES (1),(2),(3),(4),(5);
           
INSERT INTO lugar
	(Nr,Comboio)
    VALUES (1,1),
		   (2,1),
           (3,1),
           (4,1),
           (5,1),
           (6,1),
           (7,1),
           (8,1),
           (9,1),
           (10,1),
           (11,1),
           (12,1),
           (13,1),
           (14,1),
           (15,1),
           (16,1),
           (17,1),
           (18,1),
           (19,1),
           (20,1),
           (1,2),
		   (2,2),
           (3,2),
           (4,2),
           (5,2),
           (6,2),
           (7,2),
           (8,2),
           (9,2),
           (10,2),
           (11,2),
           (12,2),
           (13,2),
           (14,2),
           (15,2),
           (16,2),
           (17,2),
           (1,3),
		   (2,3),
           (3,3),
           (4,3),
           (5,3),
           (6,3),
           (7,3),
           (8,3),
           (9,3),
           (10,3),
           (11,3),
           (12,3),
           (13,3),
           (14,3),
           (15,3),
           (16,3),
           (17,3),
           (1,4),
		   (2,4),
           (3,4),
           (4,4),
           (5,4),
           (6,4),
           (7,4),
           (8,4),
           (9,4),
           (10,4),
           (11,4),
           (12,4),
           (13,4),
           (14,4),
           (15,4),
           (16,4),
           (17,4),
           (18,4),
           (19,4),
           (20,4),
           (21,4),
           (22,4),
           (23,4),
           (24,4),
		   (1,5),
		   (2,5),
           (3,5),
           (4,5),
           (5,5),
           (6,5),
           (7,5),
           (8,5),
           (9,5),
           (10,5),
           (11,5),
           (12,5),
           (13,5),
           (14,5),
           (15,5);
           
      