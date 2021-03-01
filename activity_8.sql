-- Aluno: Nathan S. Martins

-- 1) Utilizando o banco de dados Loja CDs, crie uma única função com gatilhos que
-- registrem as ações de auditoria, na tabela Gravadora_Auditoria, para as operações
-- de INSERT, UPDATE e DELETE ocorridas na tabela Gravadora. Deve ser registradas as
-- seguintes informações na tabela de auditoria:
-- - Os valores de todos os campos da tabela Gravadora;
-- - A data e hora da operação;
-- - O usuário que realizou a operação;
-- - O tipo da operação;

create table public.gravadora_Auditoria
(
    user_name     text,
    action_tstamp timestamp with time zone not null default current_timestamp,
    action        TEXT                     NOT NULL check (action in ('I', 'D', 'U')),
    original_data text,
    new_data      text,
    query         text
);

CREATE OR REPLACE FUNCTION public.audit_func() RETURNS trigger AS
$body$
DECLARE
    v_old_data TEXT;
    v_new_data TEXT;
BEGIN

    if (TG_OP = 'UPDATE') then
        v_old_data := ROW (OLD.*);
        v_new_data := ROW (NEW.*);
        insert into public.gravadora_auditoria (user_name, action, original_data, new_data, query)
        values (session_user::TEXT, substring(TG_OP, 1, 1), v_old_data, v_new_data, current_query());
        RETURN NEW;
    elsif (TG_OP = 'DELETE') then
        v_old_data := ROW (OLD.*);
        insert into public.gravadora_auditoria (user_name, action, original_data, query)
        values (session_user::TEXT, substring(TG_OP, 1, 1), v_old_data, current_query());
        RETURN OLD;
    elsif (TG_OP = 'INSERT') then
        v_new_data := ROW (NEW.*);
        insert into public.gravadora_auditoria (user_name, action, new_data, query)
        values (session_user::TEXT, substring(TG_OP, 1, 1), v_new_data, current_query());
        RETURN NEW;
    else
        RAISE WARNING '[PUBLIC.AUDIT_FUNC] - Other action occurred: %, at %',TG_OP,now();
        RETURN NULL;
    end if;

EXCEPTION
    WHEN data_exception THEN
        RAISE WARNING '[PUBLIC.AUDIT_FUNC] - UDF ERROR [DATA EXCEPTION] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN unique_violation THEN
        RAISE WARNING '[PUBLIC.AUDIT_FUNC] - UDF ERROR [UNIQUE] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
    WHEN others THEN
        RAISE WARNING '[PUBLIC.AUDIT_FUNC] - UDF ERROR [OTHER] - SQLSTATE: %, SQLERRM: %',SQLSTATE,SQLERRM;
        RETURN NULL;
END;
$body$
    LANGUAGE plpgsql
    SECURITY DEFINER
    SET search_path = pg_catalog, audit;


CREATE TRIGGER gravadora_audit
    AFTER INSERT OR UPDATE OR DELETE
    ON gravadora
    FOR EACH ROW
EXECUTE PROCEDURE public.audit_func();

------------------------------------------------------------------------------------------------------------------------

-- 2) Criar um procedimento que atualize o quantitativo do produto em estoque e o
-- valor unitário do estoque quando ocorrer uma operação de inserção de produtos na
-- tabela entrada ou na tabela saída de produto.
-- Observe que deve ser tratada as situações onde podemos ter a inserção de um novo
-- produto ou apenas a atualização do quantitativo e do valor unitário em estoque para
-- produtos já cadastrados.

-- No próximo slide você encontra os comandos SQL para a construção das tabelas
-- “estoque”, “entrada_produto” e “saida_produto”


CREATE TABLE entrada_produto
(
    id         SERIAL,
    idcd       INTEGER        NOT NULL,
    qtde       INTEGER        NOT NULL,
    v_unitario NUMERIC(14, 2) NULL DEFAULT '0.00',
    dt_entrada DATE           NULL DEFAULT NULL
);
CREATE TABLE saida_produto
(
    id         SERIAL,
    idcd       INTEGER        NOT NULL,
    qtde       INTEGER        NOT NULL,
    v_unitario NUMERIC(14, 2) NULL DEFAULT '0.00',
    dt_saida   DATE           NULL DEFAULT NULL
);
CREATE TABLE estoque
(
    id      SERIAL,
    idcd    INTEGER        NOT NULL,
    qtde    INTEGER        NOT NULL,
    v_venda NUMERIC(14, 2) NULL DEFAULT '0.00'
);



CREATE OR REPLACE FUNCTION stock_manager()
    RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        IF (TG_TABLE_NAME = 'entrada_produto') THEN
            IF (NEW.idcd IN (SELECT DISTINCT idcd FROM estoque)) THEN
                UPDATE estoque SET qtde = qtde + NEW.qtde, v_venda = NEW.v_unitario WHERE NEW.idcd = idcd;
                RETURN NEW;

            ELSE
                INSERT INTO estoque (id, idcd, qtde, v_venda)
                VALUES (nextval('estoque_id_seq'), NEW.idcd, NEW.qtde, NEW.v_unitario);
                RETURN NEW;

            END IF;

        ELSEIF (TG_TABLE_NAME = 'saida_produto') THEN
            IF (NEW.idcd IN (SELECT DISTINCT idcd FROM estoque)) THEN
                IF (NEW.qtde <= (SELECT qtde FROM estoque WHERE NEW.idcd = idcd)) THEN
                    UPDATE estoque
                    SET qtde = qtde - NEW.qtde
                    WHERE idcd = NEW.idcd;
                    RETURN NEW;

                ELSE
                    RETURN OLD;

                END IF;
            END IF;
        END IF;
    ELSEIF (TG_OP = 'UPDATE') THEN
        IF (TG_TABLE_NAME = 'entrada_produto') THEN
            IF (NEW.id IN (SELECT id FROM entrada_produto)) THEN
                IF (NEW.qtde < OLD.qtde) THEN
                    UPDATE estoque
                    SET idcd    = NEW.idcd,
                        qtde    = qtde - (OLD.qtde - NEW.qtde),
                        v_venda = NEW.v_unitario
                    WHERE idcd = NEW.idcd;

                    RETURN NEW;

                ELSE
                    UPDATE estoque
                    SET idcd    = NEW.idcd,
                        qtde    = qtde + (NEW.qtde - OLD.qtde),
                        v_venda = NEW.v_unitario
                    WHERE idcd = NEW.idcd;

                    RETURN NEW;

                END IF;
            END IF;
        ELSEIF (TG_TABLE_NAME = 'saida_produto') THEN
            IF (NEW.id IN (SELECT id FROM saida_produto)) THEN
                IF (NEW.qtde < OLD.qtde) THEN
                    UPDATE estoque
                    SET idcd    = NEW.idcd,
                        qtde    = qtde + (OLD.qtde - NEW.qtde),
                        v_venda = NEW.v_unitario
                    WHERE idcd = NEW.idcd;

                    RETURN NEW;

                ELSE
                    UPDATE estoque
                    SET idcd    = NEW.idcd,
                        qtde    = qtde - (NEW.qtde - OLD.qtde),
                        v_venda = NEW.v_unitario
                    WHERE idcd = NEW.idcd;

                    RETURN NEW;

                END IF;

            END IF;
        END IF;
        RETURN OLD;

    END IF;
END;
$BODY$
    LANGUAGE PLPGSQL;

CREATE TRIGGER product_buy
    BEFORE UPDATE OR INSERT
    ON entrada_produto
    FOR EACH ROW
EXECUTE PROCEDURE stock_manager();

CREATE TRIGGER product_sell
    BEFORE UPDATE OR INSERT
    ON saida_produto
    FOR EACH ROW
EXECUTE PROCEDURE stock_manager();


