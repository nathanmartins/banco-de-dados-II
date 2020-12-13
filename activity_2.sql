-- ALUNO: Nathan Santos Martins

CREATE
    DATABASE ESCOLAR;

----------------------------------------------------

CREATE TABLE escolar.public.aluno
(
    matricula serial,
    nome      varchar(30)
);

----------------------------------------------------

CREATE TABLE escolar.public.professor
(
    registro varchar(5),
    nome     varchar(20),
    admissao date
);

----------------------------------------------------

CREATE TABLE escolar.public.Disciplina
(
    codigo integer,
    nome     varchar(40),
    registro char(5)
);

----------------------------------------------------

CREATE TABLE escolar.public.Historico
(
    matricula integer,
    codigo integer,
    nota numeric(2,2)
);

----------------------------------------------------

ALTER TABLE  escolar.public.aluno
    ADD PRIMARY KEY (matricula);

ALTER TABLE  escolar.public.professor
    ADD PRIMARY KEY (registro);

ALTER TABLE  escolar.public.disciplina
    ADD PRIMARY KEY (codigo);

ALTER TABLE  escolar.public.historico
    ADD PRIMARY KEY (codigo);

----------------------------------------------------

-- TODO Criar as colunas necessários e as chaves estrangeiras;
-- Não tinha um diagrama de entidade e relacionamento, portanto não sei quais tabelas
-- se relacionam com outas.

----------------------------------------------------

ALTER TABLE escolar.public.aluno
    ADD COLUMN telefone char(8);

----------------------------------------------------

ALTER TABLE escolar.public.historico  RENAME to Boletim;

----------------------------------------------------

ALTER TABLE escolar.public.boletim
    ADD COLUMN media numeric(2,2);

----------------------------------------------------

ALTER TABLE ESCOLAR.public.boletim
    ADD CONSTRAINT nota_check
        CHECK ( nota between 0 and 10);

----------------------------------------------------

ALTER TABLE escolar.public.professor
    ADD COLUMN salario numeric(10,2) not null default 1039;

----------------------------------------------------
