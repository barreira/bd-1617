CREATE VIEW top5Clientes AS
	SELECT Nome
		FROM cliente
		WHERE ID IN (SELECT aux.Cli
						FROM (SELECT C.ID AS Cli, SUM(R.Preço) AS Pag
								FROM cliente C INNER JOIN reserva R ON C.ID = R.Cliente
								GROUP BY Cli
								ORDER BY Pag DESC
								LIMIT 5) AS aux); 


delimiter $$
CREATE PROCEDURE top5ClientesMes(mes INT, ano INT)
BEGIN
	SELECT Nome
		FROM cliente
		WHERE ID IN (SELECT aux.Cli
						FROM (SELECT C.ID AS Cli, SUM(R.Preço) AS Pag
								FROM cliente C INNER JOIN reserva R ON C.ID = R.Cliente
								WHERE MONTH(Data) = mes AND YEAR(Data) = ano
								GROUP BY Cli
								ORDER BY Pag DESC
								LIMIT 5) AS aux); 
END; $$


delimiter $$ 
CREATE PROCEDURE faturacaoMes(mes INT, ano INT)
BEGIN	
    SELECT SUM(Preço) AS Faturacao
		FROM reserva
		WHERE MONTH(Data) = mes AND YEAR(Data) = ano;
END; $$    


delimiter $$
CREATE PROCEDURE horaChegada(viag INT)
BEGIN
	SELECT ADDTIME(DataHoraPartida, Duração) AS HoraChegada
		FROM viagem
        WHERE ID = viag;
END; $$
   
   
CREATE VIEW viagensInternacionais AS    
	SELECT COUNT(*) AS Internacionais
		FROM viagem v JOIN estação e ON e.ID = v.origem
					  JOIN estação e2 ON e2.ID = v.destino
		WHERE e.País <> e2.País;
    
    
CREATE VIEW comboioMaisUtilizado AS   
	SELECT Comboio
		FROM viagem
		WHERE Comboio IN (SELECT aux.C
							FROM (SELECT Comboio AS C, COUNT(*) AS cont
									FROM viagem
									GROUP BY Comboio
									ORDER BY cont DESC
									LIMIT 1) AS aux)
		GROUP BY Comboio;