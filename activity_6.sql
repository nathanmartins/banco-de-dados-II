--- Aluno: Nathan Martins

-- 1) Faça uma função que retorne a idade de uma pessoa. Deve-se passar com parâmetro a data de nascimento.

CREATE OR REPLACE FUNCTION Idade(IN dt_nasc date, OUT idade int)
	AS
	$$ BEGIN

		idade = date_part('year' , age(dt_nasc));
		
	END; $$
LANGUAGE PLPGSQL;


-- 2) Faça uma função que retorne a média de preço de venda dos CDs de uma determinada gravadora. Deve-se passar como parâmetro o código da gravadora.

CREATE OR REPLACE FUNCTION mediaCDs(IN grav int, OUT media float)
	AS
	$$ BEGIN
		SELECT INTO media AVG(c.preco_venda)
		FROM cd c
		WHERE grav = c.idgravadora;
	END; $$
LANGUAGE PLPGSQL;


-- 3) Faça uma função que retorne o nome do CD e o nome da Música. Deve-se passar como parâmetro o código do CD e o número da faixa do CD.

CREATE OR REPLACE FUNCTION dadosCDs (IN codcd INT, IN nfaixa INT)
	RETURNS TABLE (nome_cd character varying, nomemusica character varying) AS $$
	BEGIN
		
		RETURN QUERY 
			SELECT c.nome_cd, m.nomemusica 
			FROM cd c 
			INNER JOIN faixa USING (idcd)
			INNER JOIN musica m USING (idmusica)
			WHERE idcd = codcd 
			AND numero_faixa = nfaixa;
		
	END; $$
LANGUAGE PLPGSQL;


-- 4) Faça uma função que retorne o nome da gravadora a quantidade de faixas e o tempo total de músicas de um CD. Deve-se passar como parâmetro o código do CD.

CREATE OR REPLACE FUNCTION cdtempo(IN codcd INT)
	RETURNS TABLE (nome_cd character varying, TRACKS BIGINT, TOTAL INTERVAL) AS $$
	BEGIN
	
		RETURN QUERY
			SELECT c.nome_cd, COUNT(f.idcd) as TRACKS, SUM(m.duracao) as TOTAL
			FROM CD c
			INNER JOIN GRAVADORA g USING (idgravadora)
			INNER JOIN FAIXA f USING (idcd)
			INNER JOIN MUSICA m USING (idmusica)
			WHERE idcd = codcd
			AND c.idcd = f.idcd
			GROUP BY c.nome_cd;
		
		
	END; $$
LANGUAGE PLPGSQL;


-- 5) Faça uma função que retorne os nomes das músicas de um CD. Deve-se passar como parâmetro o código do CD.

CREATE OR REPLACE FUNCTION nomesmusicas(IN idvem INT)
	RETURNS TABLE (musicas varchar) AS
	$$ BEGIN
		RETURN QUERY
			SELECT m.nomemusica as musica
			FROM CD c
			INNER JOIN faixa f USING (idcd)
			INNER JOIN musica m USING (idmusica)
			WHERE idcd = idvem;
				
		
	END; $$
LANGUAGE PLPGSQL;

