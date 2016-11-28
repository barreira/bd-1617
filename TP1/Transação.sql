delimiter $$
CREATE PROCEDURE inserirBilhete(IN res INT, lug INT, viag INT, clas VARCHAR(10))
BEGIN
	-- Declaração de Variáveis Auxiliares
    DECLARE pv INT;
	DECLARE pb INT;
    DECLARE i INT;
    DECLARE dsc DECIMAL(4,2);
	-- Declaraçãoo de um handler para tratamento de erros.
    DECLARE ErroTransacao BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;
	-- Início da transação
	START TRANSACTION;
    -- Inserção do bilhete 
    INSERT 
		INTO bilhete (ID, Classe, Preço, Lugar, Viagem, Reserva)
		VALUES (i, clas, 0, lug, viag, res);
	-- Preço Base da Viagem
    SET pv = (SELECT PreçoBase FROM viagem WHERE ID = viag);
    -- Desconto
    CASE (clas)
		WHEN 'Júnior' THEN SET dsc = 0.9 ;
        WHEN 'Sénior' THEN SET dsc = 0.9 ;
        WHEN 'Estudante' THEN SET dsc = 0.8 ;
        ELSE
			BEGIN
				SET dsc = 1;
			END;
		END CASE;
    -- ID Bilhete
    SET i = (SELECT ID
				FROM bilhete
                WHERE Lugar = lug AND Viagem = viag);
	-- Actualização do Preço do Bilhete
	UPDATE bilhete
		SET Preço = pv * dsc
		WHERE ID = i;
    -- Preço Bilhete
    SET pb = (SELECT Preço FROM bilhete WHERE ID = i);
    -- Acutlização do Preço da Reserva
    UPDATE reserva
		SET Preço = Preço + pb
		WHERE ID = res;
	-- Verificação da ocorrência de um erro.
    IF ErroTransacao THEN
		-- Desfazer as operações realizadas.
        ROLLBACK;
    ELSE
		-- Confirmar as operações realizadas.
        COMMIT;
	END IF;
END; $$



delimiter $$
CREATE PROCEDURE novoCliente(IN nm VARCHAR(50), em VARCHAR(40))
BEGIN
	-- Declaraçãoo de um handler para tratamento de erros.
    DECLARE ErroTransacao BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;
	-- Início da transação
	START TRANSACTION;
    -- Inserção do Cliente
		INSERT 
			INTO cliente (Nome, Email)
            VALUES (nm, em);
	-- Verificação da ocorrência de um erro.
    IF ErroTransacao THEN
		-- Desfazer as operações realizadas.
        ROLLBACK;
    ELSE
		-- Confirmar as operações realizadas.
        COMMIT;
	END IF;
END; $$


delimiter $$
CREATE PROCEDURE abreReserva(IN cli INT)
BEGIN
	-- Declaraçãoo de um handler para tratamento de erros.
    DECLARE ErroTransacao BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;
	-- Início da transação
	START TRANSACTION;
    -- Inserção do Cliente
		INSERT 
			INTO reserva (Cliente, Preço, Data)
            VALUES (cli, 0, CURDATE());
	-- Verificação da ocorrência de um erro.
    IF ErroTransacao THEN
		-- Desfazer as operações realizadas.
        ROLLBACK;
    ELSE
		-- Confirmar as operações realizadas.
        COMMIT;
	END IF;
END; $$