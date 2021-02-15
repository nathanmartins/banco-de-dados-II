--- Aluno: Nathan Martins

-- 1. Crie uma função que receba um número inteiro e imprima a tabuada

CREATE OR REPLACE FUNCTION Tabuada(IN n int)
    RETURNS TABLE
            (
                resultado text
            )
AS
$$
BEGIN
    for i in 1..10 loop

        RETURN QUERY VALUES (n || ' X ' || i || ' = ' || n*i);

    end loop;
END;
$$
    LANGUAGE PLPGSQL;


SELECT * FROM Tabuada(5);


----------------------------------------------------


-- 2. Criar uma função que receba dois números inteiros (representando o intervalo entre dois anos) e retorne os anos
--    bissextos existentes neste período. Um ano será bissexto quando for possível dividi-lo por 4, mas não por 100 ou
--    quando for possível dividi-lo por 400.


CREATE OR REPLACE FUNCTION bissexto(IN y1 int, IN y2 int)
    RETURNS TABLE
            (
                resultado int
            )
AS
$$
BEGIN


    for i in y1..y2
        loop
            IF (i % 4 = 0) AND ((i % 100 <> 0) or (i % 400 = 0)) THEN
                RETURN QUERY VALUES (i);
            END IF;
        end loop;
END;
$$
    LANGUAGE PLPGSQL;


SELECT *
FROM bissexto(2000, 2010);



----------------------------------------------------

--- 3. Criar uma função que receba o nome da Gravadora. Atualize os preços de venda dos CDs da gravador, Ao final
--     retornar a lista contendo os nomes dos CD's e os novos preços de venda.

CREATE TYPE infomusicas AS
(
    nomecd     VARCHAR,
    preco_novo numeric
);

CREATE TYPE infomusicas_iterno AS
(
    id_cd  int,
    nomecd VARCHAR,
    preco  numeric
);



CREATE OR REPLACE FUNCTION Atualizar_precos(IN nome_grav varchar)
    RETURNS SETOF infoMusicas AS
$$

declare
    temprow infomusicas_iterno;
BEGIN

    FOR temprow IN
        select idcd, nome_cd, preco_venda
        from cd
        where idgravadora in (select idgravadora from gravadora where nomegravadora = nome_grav)
        LOOP
            IF (temprow.preco <= 10) THEN
                update cd set preco_venda = ((temprow.preco / 100) * 100) + temprow.preco where idcd = temprow.id_cd;
            ELSEIF (temprow.preco > 10 and temprow.preco <= 12) THEN
                update cd set preco_venda = ((temprow.preco / 100) * 80) + temprow.preco where idcd = temprow.id_cd;
            ELSEIF (temprow.preco > 12) THEN
                update cd set preco_venda = ((temprow.preco / 100) * 65) + temprow.preco where idcd = temprow.id_cd;
            END IF;

        END LOOP;

    return query select nome_cd, preco_venda
                 from cd
                 where idgravadora in (select idgravadora from gravadora where nomegravadora = nome_grav);
END
$$
    LANGUAGE PLPGSQL;


SELECT * FROM Atualizar_precos('BMG');


----------------------------------------------------