CREATE
DATABASE ELEICAO;

----------------------------------------------------

CREATE TABLE eleicao.public.CARGO
(
    Cod_Cargo  serial,
    Nome_Cargo varchar(30),
    Qtde_Vagas integer default 0
);

----------------------------------------------------

CREATE TABLE eleicao.public.Partido
(
    Num_Partido integer,
    Sigla       varchar(4),
    Nome        varchar(50),
    Dt_Criacao  date
);

----------------------------------------------------

CREATE TYPE sexo AS ENUM ('Masculino', 'Feminino');

CREATE TABLE eleicao.public.Candidato
(
    Num_Cand integer,
    Nome     varchar(40),
    Dt_Nasc  date,
    Sexo     sexo default 'Feminino'
);

----------------------------------------------------

CREATE TABLE eleicao.public.Voto
(
    Cod_Cargo integer,
    Num_Cand  integer
);

----------------------------------------------------

CREATE TABLE eleicao.public.Pessoa
(
    titulo         varchar(12),
    Nome           varchar(50),
    Comparecimento varchar(3)
);

----------------------------------------------------

ALTER TABLE eleicao.public.cargo
    ADD PRIMARY KEY (cod_cargo);

----------------------------------------------------

ALTER TABLE eleicao.public.cargo
    ADD CONSTRAINT unique_nome UNIQUE (nome_cargo);

ALTER TABLE eleicao.public.cargo
    ALTER COLUMN nome_cargo SET NOT NULL;

ALTER TABLE eleicao.public.cargo
    ADD CONSTRAINT nome_cargo_check
        CHECK (
            nome_cargo IN ('Prefeito', 'Vereador')
            );

----------------------------------------------------

ALTER TABLE eleicao.public.cargo
    ALTER COLUMN qtde_vagas SET NOT NULL;

ALTER TABLE eleicao.public.cargo
    ALTER COLUMN qtde_vagas SET DEFAULT 9;

----------------------------------------------------

ALTER TABLE eleicao.public.partido
    ADD PRIMARY KEY (num_partido);

----------------------------------------------------

ALTER TABLE eleicao.public.partido
    ADD CONSTRAINT unique_sigla UNIQUE (sigla);

ALTER TABLE eleicao.public.partido
    ALTER COLUMN sigla SET NOT NULL;

----------------------------------------------------

ALTER TABLE eleicao.public.partido
    ADD CONSTRAINT unique_nome_partido UNIQUE (nome);

ALTER TABLE eleicao.public.partido
    ALTER COLUMN nome SET NOT NULL;

----------------------------------------------------

ALTER TABLE eleicao.public.partido
    ALTER COLUMN dt_criacao SET NOT NULL;

ALTER TABLE eleicao.public.partido
    RENAME COLUMN dt_criacao TO Dt_Constituicao;

----------------------------------------------------

ALTER TABLE eleicao.public.candidato
    ADD PRIMARY KEY (num_cand);

----------------------------------------------------

ALTER TABLE eleicao.public.candidato
    ALTER COLUMN nome SET NOT NULL;

----------------------------------------------------

ALTER TABLE eleicao.public.candidato
    ADD CONSTRAINT candidato_idade_check
        CHECK ( dt_nasc < (current_date - interval '18' year ));

----------------------------------------------------

ALTER TABLE eleicao.public.candidato
    ALTER COLUMN sexo SET default 'Masculino';

----------------------------------------------------

ALTER TABLE eleicao.public.voto
    ALTER COLUMN cod_cargo SET NOT NULL;

----------------------------------------------------

ALTER TABLE eleicao.public.voto
    ALTER COLUMN num_cand SET NOT NULL;

----------------------------------------------------

ALTER TABLE eleicao.public.voto
    RENAME COLUMN cod_cargo TO Codigo_Cargo;

----------------------------------------------------

ALTER TABLE eleicao.public.pessoa
    ADD CONSTRAINT unique_titulo UNIQUE (titulo);

----------------------------------------------------

ALTER TABLE eleicao.public.pessoa
    alter column nome set not null;

----------------------------------------------------

ALTER TABLE eleicao.public.pessoa
ALTER COLUMN comparecimento TYPE bool USING comparecimento::boolean;

ALTER TABLE eleicao.public.pessoa
    ALTER COLUMN comparecimento set default false;

----------------------------------------------------

ALTER TABLE eleicao.public.pessoa  RENAME to Eleitor

----------------------------------------------------

