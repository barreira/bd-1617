-- Queries


-- Consultar lista de clientes
 SELECT * FROM cliente;
 
 -- Consultar estações
 SELECT * FROM estação;
 
 -- Todos os bilhetes comprados
SELECT *
	FROM bilhete
    ORDER BY Viagem;

-- Comboio e respetiva capacidade
SELECT comboio,count(*)
	FROM lugar
    GROUP BY comboio;
 
-- Clientes que efetuaram compras
SELECT DISTINCT Cli.Nome
	FROM cliente Cli
    WHERE Cli.Id in (SELECT R.Cliente FROM reserva R)
    ORDER BY Cli.Nome; 
    
-- Clientes registados que não efetuaram reservas
SELECT Cli.Nome
	FROM cliente Cli
    WHERE Cli.Id not in (SELECT R.Cliente FROM reserva R);
    
-- Número de viagens realizadas/a realizar numa data
call viagens_Dia('2016-11-19');

delimiter $$
CREATE PROCEDURE viagens_Dia(IN data_x VARCHAR(10))
BEGIN
	SELECT count(*)
		FROM viagem
		WHERE DataPartida > CONCAT(data_x,' 00:00:00') AND DataPartida < CONCAT(data_x,' 23:59:00');
END; $$   
 
-- Número de reservas que um cliente fez
call reservas_Cliente(1);

delimiter $$
CREATE PROCEDURE reservas_Cliente(IN cliente_x INT)
BEGIN
	SELECT count(*)
		FROM cliente C INNER JOIN reserva R ON C.Id = R.Cliente
		WHERE R.Cliente = cliente_x;
END; $$    

-- Viagens que o comboio x realiza
call numViagens_Comboio(1);

delimiter $$
CREATE PROCEDURE numViagens_Comboio(IN comb_x INT)
BEGIN
	SELECT count(*)
		FROM viagem V
		WHERE V.Comboio = comb_x;
END; $$

-- Quantas viagens chegam à estação X 
call terminarEst_x('Lisboa');

delimiter $$
CREATE PROCEDURE terminarEst_x (IN est_x VARCHAR(20))
BEGIN
	SELECT count(*)
		FROM viagem V INNER JOIN estação E ON V.Destino = E.Id
		WHERE E.Localidade = est_x;
END; $$
    
-- Quantas viagens iniciam na estação X 
call iniciarEst_x('Lisboa');

delimiter $$
CREATE PROCEDURE iniciarEst_x (IN est_x VARCHAR(20))
BEGIN
SELECT count(*)
	FROM viagem V INNER JOIN estação E ON V.Origem = E.Id
    WHERE E.Localidade = est_x;
END; $$
   
-- Lugares ocupados para uma viagem X
call lugares_Ocupados(23);

delimiter $$
CREATE PROCEDURE lugares_Ocupados(IN viagem_x INT)
BEGIN
	SELECT lugar
		FROM bilhete
		WHERE viagem = viagem_x
		ORDER BY lugar;
END; $$
    
-- Lugares livres para a viagem X
call lugares_Livres(2);

delimiter $$
CREATE PROCEDURE lugares_Livres(IN viagem_x INT)
BEGIN 
	SELECT Nr
		FROM lugar L
		WHERE L.Nr not in (SELECT L.Nr 
								FROM bilhete B JOIN Lugar L ON B.Lugar = L.Nr 
								WHERE B.Viagem = viagem_x)
			 AND L.Comboio IN (SELECT V.Comboio
								FROM bilhete B JOIN viagem V ON B.Viagem = V.ID 
								WHERE B.Viagem = viagem_x)
		ORDER BY L.Nr ASC;
END;$$

-- Reservas com preço superior a X 
call preco_Superior(50);

delimiter $$
CREATE PROCEDURE preco_Superior(IN preco_x decimal)
BEGIN 
	SELECT count(*)
		FROM reserva R
        WHERE R.Preço > preco_x;
END; $$

-- Viagens Internacionais
call viagens_Internacionais('2016-11-21');

delimiter $$
CREATE PROCEDURE viagens_Internacionais(IN data_x VARCHAR(10))
BEGIN 
	SELECT *
		FROM viagem V JOIN estação Eo ON V.Origem = Eo.ID
					  JOIN estação Ed ON V.Destino = Ed.ID
		WHERE Eo.País != Ed.País AND  DataPartida > CONCAT(data_x,' 00:00:00') AND DataPartida < CONCAT(data_x,' 23:59:00');
END; $$

-- Número de viagens internacionais
SELECT count(*)
		FROM viagem V JOIN estação E ON V.Origem = E.ID
					  JOIN estação E2 ON V.Destino = E2.ID
		WHERE E.País != E2.País;



     