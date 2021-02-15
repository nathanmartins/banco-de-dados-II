--DROP DATABASE if exists loja_cds;
--CREATE DATABASE loja_cds;

-- Tabelas de Relacionamentos
DROP TABLE IF EXISTS cd_gravadora;
DROP TABLE IF EXISTS musica_auditoria;
DROP TABLE IF EXISTS musica_autor;
DROP TABLE IF EXISTS faixa;

--Tabelas Entidades
DROP TABLE IF EXISTS autor;
DROP TABLE IF EXISTS cd;
DROP TABLE IF EXISTS cd_categoria;
DROP TABLE IF EXISTS gravadora;
DROP TABLE IF EXISTS musica;

--Sequences de Chaves Primárias
DROP SEQUENCE IF EXISTS seq_autor;
DROP SEQUENCE IF EXISTS seq_cd;
DROP SEQUENCE IF EXISTS seq_cd_categoria;
DROP SEQUENCE IF EXISTS seq_faixa;
DROP SEQUENCE IF EXISTS seq_gravadora;
DROP SEQUENCE IF EXISTS seq_musica;


CREATE SEQUENCE seq_autor INCREMENT 1 START 1;
CREATE SEQUENCE seq_cd INCREMENT 1 START 1;
CREATE SEQUENCE seq_cd_categoria INCREMENT 1 START 1;
CREATE SEQUENCE seq_faixa INCREMENT 1 START 1;
CREATE SEQUENCE seq_gravadora INCREMENT 1 START 1;
CREATE SEQUENCE seq_musica INCREMENT 1 START 1;

CREATE TABLE IF NOT EXISTS autor (
  idAutor integer DEFAULT nextval('seq_autor'),
  Nome_Autor varchar(60) NOT NULL,
  PRIMARY KEY (idAutor)
);

INSERT INTO autor (idAutor, Nome_Autor) VALUES
	(nextval('seq_autor'), 'Renato Russo');

INSERT INTO autor (idAutor, Nome_Autor) VALUES
	(2, 'Tom Jobim'),
	(3, 'Chico Buarque'),
	(4, 'Dado Villa-Lobos'),
	(5, 'Marcelo Bonfá'),
	(6, 'Ico Ouro-Preto'),
	(7, 'Vinicius de Moraes'),
	(8, 'Baden Powell'),
	(9, 'Paulo Cesar Pinheiro'),
	(10, 'João Bosco'),
	(11, 'Aldir Blanc'),
	(12, 'Joyce'),
	(13, 'Ana Terra'),
	(14, 'Cartola'),
	(15, 'Cláudio Tolomei'),
	(16, 'João Nogueira'),
	(17, 'Suely Costa'),
	(18, 'Guinga'),
	(19, 'Danilo Caymmi'),
	(20, 'Tunai'),
	(21, 'Sérgio Natureza'),
	(22, 'Heitor Villa Lobos'),
	(23, 'Ferreira Gullar'),
	(24, 'Catulo da Paixão Cearense'),
	(25, 'Zezé di Camargo'),
	(26, 'Niltinho Edilberto'),
	(27, 'Marisa Monte'),
	(28, 'Carlinhos Brown'),
	(29, 'Gonzaga Jr'),
	(30, 'Roberto Mendes'),
	(31, 'Ana Basbaum'),
	(32, 'Caetano Veloso'),
	(33, 'José Miguel Wisnik'),
	(34, 'Vevé Calazans'),
	(35, 'Gerônimo'),
	(36, 'Sérgio Natureza'),
	(37, 'Roberto Carlos'),
	(38, 'Erasmo Carlos'),
	(39, 'Renato Teixeira'),
	(40, 'Chico César'),
	(41, 'Vanessa da Mata'),
	(42, 'Jorge Portugal'),
	(43, 'Lilian Knapp'),
	(44, 'Renato Barros'),
	(45, 'Bebel Gilberto'),
	(46, 'Cazuza'),
	(47, 'Dé'),
	(48, 'Adriana Calcanhoto'),
	(49, 'Antonio Cícero'),
	(50, 'Paulo Machado'),
	(51, 'Dorival Caymmi'),
	(52, 'João Donato'),
	(53, 'Ronaldo Bastos'),
	(54, 'Barry Manilow'),
	(55, 'Richard Kerr'),
	(56, 'Chris Arnold'),
	(57, 'David Pomeranz'),
	(58, 'George Michael'),
	(59, 'S. Wonder'),
	(60, 'Elton John'),
	(61, 'Arnaldo Antunes');

CREATE TABLE IF NOT EXISTS gravadora (
  idGravadora integer,
  NomeGravadora varchar(50) NOT NULL,
  Endereco varchar(50) DEFAULT NULL,
  Telefone varchar(20) DEFAULT NULL,
  Contato varchar(20) DEFAULT NULL,
  URL varchar(80) DEFAULT NULL,
  PRIMARY KEY (idGravadora)
);

INSERT INTO gravadora (idGravadora, NomeGravadora, Endereco, Telefone, Contato, URL) VALUES
	(nextval('seq_gravadora'), 'EMI', 'Rod. Pres. Dutra, s/n – km 229,8', '+55 62 3723 5555', 'JOÃO', 'www.emi-music.com.br');
	
INSERT INTO gravadora (idGravadora, NomeGravadora, Endereco, Telefone, Contato, URL) VALUES
	(2, 'BMG', 'Av. Piramboia, 2898 - Parte 7', NULL, 'MARIA', 'www.bmg.com.br'),
	(3, 'SOM LIVRE', NULL, NULL, 'MARTA', 'www.somlivre.com.br'),
	(4, 'EPIC', NULL, NULL, 'PAULO', 'www.epic.com.br');

CREATE TABLE IF NOT EXISTS cd_categoria (
  idCategoria integer,
  Menor_Preco decimal(14,2) DEFAULT NULL,
  Maior_Preco decimal(14,2) DEFAULT NULL,
  PRIMARY KEY (idCategoria)
);

INSERT INTO cd_categoria (idCategoria, Menor_Preco, Maior_Preco) VALUES
	(nextval('seq_cd_categoria'), 5.00, 10.00);

INSERT INTO cd_categoria (idCategoria, Menor_Preco, Maior_Preco) VALUES
	(2, 10.01, 12.00),
	(3, 12.01, 15.00),
	(4, 15.01, 20.00);

CREATE TABLE IF NOT EXISTS cd (
  idCD integer,
  CD_Indicado integer DEFAULT NULL,
  idGravadora integer NOT NULL,
  Nome_CD varchar(60) NOT NULL,
  Preco_Venda decimal(14,2) DEFAULT NULL,
  Dt_Lancamento date DEFAULT NULL,
  PRIMARY KEY (idCD),
  CONSTRAINT cd_ibfk_1 FOREIGN KEY (idGravadora) REFERENCES gravadora (idGravadora) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO cd (idCD, CD_Indicado, idGravadora, Nome_CD, Preco_Venda, Dt_Lancamento) VALUES
	(nextval('seq_cd'), 5, 1, 'Mais do Mesmo', 15.00, '1998-10-01');
	
INSERT INTO cd (idCD, CD_Indicado, idGravadora, Nome_CD, Preco_Venda, Dt_Lancamento) VALUES
	(2, 3, 2, 'Bate-Boca', 12.00, '1999-07-01'),
	(3, 1, 3, 'Elis Regina - Essa Mulher', 13.00, '1989-05-01'),
	(4, 1, 2, 'A Força que nunca Seca', 13.50, '1998-12-01'),
	(5, 2, 3, 'Perfil', 10.50, '2001-05-01'),
	(6, 7, 2, 'Barry Manilow Greatest Hits Vol I', 9.50, '1991-11-01'),
	(7, NULL, 2, 'Listen Without Prejudice', 9.00, '1991-10-01');

CREATE TABLE IF NOT EXISTS musica (
  idMusica integer,
  NomeMusica varchar(60) NOT NULL,
  Duracao time DEFAULT NULL,
  PRIMARY KEY (idMusica)
);

INSERT INTO musica (idMusica, NomeMusica, Duracao) VALUES
	(nextval('seq_musica'), 'Quero ver a musica', '00:02:28');

INSERT INTO musica (idMusica, NomeMusica, Duracao) VALUES
	(2, 'Ainda é Cedo', '00:03:55'),
	(3, 'Geração Coca-Cola', '00:02:20'),
	(4, 'Eduardo e Monica', '00:04:32'),
	(5, 'Tempo Perdido', '00:05:00'),
	(6, 'Índios', '00:04:23'),
	(7, 'Que País é Este', '00:03:04'),
	(8, 'Faroeste Caboclo', '00:09:03'),
	(9, 'Há Tempos', '00:03:16'),
	(10, 'Pais e Filhos', '00:05:06'),
	(11, 'Meninos e Meninas', '00:03:22'),
	(12, 'Vento no Litoral', '00:06:05'),
	(13, 'Perfeição', '00:04:35'),
	(14, 'Giz', '00:03:20'),
	(15, 'Dezesseis', '00:05:28'),
	(16, 'Antes das Seis', '00:03:09'),
	(17, 'Meninos, Eu Vi', '00:03:25'),
	(18, 'Eu Te Amo', '00:03:06'),
	(19, 'Piano na Mangueira', '00:02:23'),
	(20, 'A Violeira', '00:02:54'),
	(21, 'Anos Dourados', '00:02:56'),
	(22, 'Olha, Maria', '00:03:55'),
	(23, 'Biscate', '00:03:20'),
	(24, 'Retrato em Preto e Branco', '00:03:03'),
	(25, 'Falando de Amor', '00:03:20'),
	(26, 'Pois É', '00:02:48'),
	(27, 'Noite dos Mascarados', '00:02:42'),
	(28, 'Sabiá', '00:03:20'),
	(29, 'Imagina', '00:02:52'),
	(30, 'Bate-Boca', '00:04:41'),
	(31, 'Cai Dentro', '00:02:41'),
	(32, 'O Bêbado e o Equilibrista', '00:03:47'),
	(33, 'Essa Mulher', '00:03:47'),
	(34, 'Basta de Clamares Inocência', '00:03:38'),
	(35, 'Beguine Dodói', '00:02:14'),
	(36, 'Eu hein Rosa', '00:03:36'),
	(37, 'Altos e Baixos', '00:03:29'),
	(38, 'Bolero de Satã', '00:03:32'),
	(39, 'Pé Sem Cabeça', '00:02:57'),
	(40, 'As Aparências Enganam', '00:04:18'),
	(41, 'É o Amor', '00:04:19'),
	(42, 'Trenzinho Caipira', '00:03:32'),
	(43, 'Luar do Sertão', '00:03:23'),
	(44, 'Não tenha Medo', '00:03:27'),
	(45, 'Eu queria que você viesse', '00:02:57'),
	(46, 'Espere por mim Morena', '00:03:04'),
	(47, 'Resto de mim', '00:02:59'),
	(48, 'Gema', '00:02:51'),
	(49, 'Cacilda', '00:02:22'),
	(50, 'Agradecer e abraçar', '00:03:30'),
	(51, 'As flores do jardim da nossa casa', '00:03:26'),
	(52, 'Romaria', '00:03:16'),
	(53, 'A força que nunca seca', '00:02:17'),
	(54, 'Vila do Adeus', '00:03:06'),
	(55, 'Devolva-me', '00:03:58'),
	(56, 'Mais Feliz', '00:02:50'),
	(57, 'Inverno', '00:04:40'),
	(58, 'Mentiras', '00:02:58'),
	(59, 'Esquadros', '00:03:10'),
	(60, 'Cariocas', '00:03:14'),
	(61, 'Vambora', '00:04:16'),
	(62, 'Por isso eu Corro Demais', '00:02:58'),
	(63, 'Maresia', '00:04:09'),
	(64, 'Metade', '00:03:25'),
	(65, 'Senhas', '00:03:37'),
	(66, 'Marina', '00:02:55'),
	(67, 'Naquela Estação', '00:04:46'),
	(68, 'Mandy', '00:03:18'),
	(69, 'New York City Rhythm', '00:04:41'),
	(70, 'Looks Like We Made It', '00:03:32'),
	(71, 'Daybreak', '00:03:05'),
	(72, 'Cant Smile Without you', '00:03:13'),
	(73, 'Its a Miracle', '00:03:53'),
	(74, 'Even Now', '00:03:29'),
	(75, 'Bandstand Boogie', '00:02:50'),
	(76, 'Trying to get the feeling again', '00:03:50'),
	(77, 'Some Kind of Friend', '00:04:02'),
	(78, 'Praying for Time', '00:03:52'),
	(79, 'Freedom 90', '00:03:52'),
	(80, 'They Wont Go When I Go', '00:03:22'),
	(81, 'Something to Save', '00:04:10'),
	(82, 'Cowboys and Angels', '00:04:12'),
	(83, 'Dont Let the Sun Go Down on Me', '00:03:45'),
	(84, 'Waiting for That Day', '00:02:58'),
	(85, 'Mothers Pride', '00:02:12'),
	(86, 'Heal the Pain', '00:03:02'),
	(87, 'Soul Free', '00:02:42'),
	(88, 'Waiting', '00:03:32');

CREATE TABLE IF NOT EXISTS faixa (
  Numero_Faixa integer,
  idMusica integer NOT NULL,
  idCD integer NOT NULL,
  PRIMARY KEY (Numero_Faixa,idCD,idMusica),
  CONSTRAINT faixa_ibfk_1 FOREIGN KEY (idCD) REFERENCES cd (idCD) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT faixa_ibfk_2 FOREIGN KEY (idMusica) REFERENCES musica (idMusica) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO faixa (Numero_Faixa, idMusica, idCD) VALUES
	(nextval('seq_faixa'), 1, 1);

INSERT INTO faixa (Numero_Faixa, idMusica, idCD) VALUES
	(2, 2, 1),
	(3, 3, 1),
	(4, 4, 1),
	(5, 5, 1),
	(6, 6, 1),
	(7, 7, 1),
	(8, 8, 1),
	(9, 9, 1),
	(10, 10, 1),
	(11, 11, 1),
	(12, 12, 1),
	(13, 13, 1),
	(14, 14, 1),
	(15, 15, 1),
	(16, 16, 1),
	(1, 17, 2),
	(2, 18, 2),
	(3, 19, 2),
	(4, 20, 2),
	(5, 21, 2),
	(6, 22, 2),
	(7, 23, 2),
	(8, 24, 2),
	(9, 25, 2),
	(10, 26, 2),
	(11, 27, 2),
	(12, 28, 2),
	(13, 29, 2),
	(14, 30, 2),
	(1, 31, 3),
	(2, 32, 3),
	(3, 33, 3),
	(4, 34, 3),
	(5, 35, 3),
	(6, 36, 3),
	(7, 37, 3),
	(8, 38, 3),
	(9, 39, 3),
	(10, 40, 3),
	(1, 41, 4),
	(2, 42, 4),
	(3, 43, 4),
	(4, 44, 4),
	(5, 45, 4),
	(6, 46, 4),
	(7, 47, 4),
	(8, 48, 4),
	(9, 49, 4),
	(10, 50, 4),
	(11, 51, 4),
	(12, 52, 4),
	(13, 53, 4),
	(14, 54, 4),
	(1, 55, 5),
	(2, 56, 5),
	(3, 57, 5),
	(4, 58, 5),
	(5, 59, 5),
	(6, 60, 5),
	(7, 61, 5),
	(8, 62, 5),
	(9, 63, 5),
	(10, 64, 5),
	(11, 65, 5),
	(12, 66, 5),
	(13, 67, 5),
	(1, 68, 6),
	(2, 69, 6),
	(3, 70, 6),
	(4, 71, 6),
	(5, 72, 6),
	(6, 73, 6),
	(7, 74, 6),
	(8, 75, 6),
	(9, 76, 6),
	(10, 77, 6),
	(1, 78, 7),
	(2, 79, 7),
	(3, 80, 7),
	(4, 81, 7),
	(5, 82, 7),
	(6, 83, 7),
	(7, 84, 7),
	(8, 85, 7),
	(9, 86, 7),
	(10, 87, 7),
	(11, 88, 7);

CREATE TABLE IF NOT EXISTS musica_autor (
  idAutor integer NOT NULL,
  idMusica integer NOT NULL,
  PRIMARY KEY (idAutor,idMusica),
  CONSTRAINT musica_autor_ibfk_1 FOREIGN KEY (idMusica) REFERENCES musica (idMusica) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT musica_autor_ibfk_2 FOREIGN KEY (idAutor) REFERENCES autor (idAutor) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO musica_autor (idAutor, idMusica) VALUES
	(1, 1),
	(5, 2),
	(6, 2),
	(1, 3),
	(4, 3),
	(5, 3),
	(1, 4),
	(4, 4),
	(1, 5),
	(1, 6),
	(1, 7),
	(1, 8),
	(1, 9),
	(4, 9),
	(5, 9),
	(1, 10),
	(4, 10),
	(5, 10),
	(1, 11),
	(4, 11),
	(5, 11),
	(1, 12),
	(4, 12),
	(5, 12),
	(1, 13),
	(4, 13),
	(5, 13),
	(1, 14),
	(4, 14),
	(5, 14),
	(1, 15),
	(4, 15),
	(5, 15),
	(1, 16),
	(4, 16),
	(5, 16),
	(2, 17),
	(3, 17),
	(2, 18),
	(3, 18),
	(2, 19),
	(3, 19),
	(2, 20),
	(3, 20),
	(2, 21),
	(3, 21),
	(2, 22),
	(3, 22),
	(7, 22),
	(3, 23),
	(2, 24),
	(3, 24),
	(2, 25),
	(2, 26),
	(3, 26),
	(3, 27),
	(2, 28),
	(3, 28),
	(2, 29),
	(3, 29),
	(3, 30),
	(8, 31),
	(9, 31),
	(10, 32),
	(11, 32),
	(12, 33),
	(13, 33),
	(14, 34),
	(10, 35),
	(11, 35),
	(15, 35),
	(9, 36),
	(16, 36),
	(11, 37),
	(17, 37),
	(9, 38),
	(18, 38),
	(13, 39),
	(19, 39),
	(20, 40),
	(21, 40),
	(25, 41),
	(26, 44),
	(27, 45),
	(28, 45),
	(29, 46),
	(30, 47),
	(31, 47),
	(32, 48),
	(33, 49),
	(35, 50),
	(36, 50),
	(37, 51),
	(38, 51),
	(39, 52),
	(40, 53),
	(41, 53),
	(30, 54),
	(42, 54),
	(43, 55),
	(44, 55),
	(45, 56),
	(46, 56),
	(47, 56),
	(48, 57),
	(49, 57),
	(48, 58),
	(48, 59),
	(48, 60),
	(48, 61),
	(37, 62),
	(49, 63),
	(50, 63),
	(48, 64),
	(48, 65),
	(51, 66),
	(32, 67),
	(52, 67),
	(53, 67),
	(55, 68),
	(54, 69),
	(55, 70),
	(54, 71),
	(56, 72),
	(54, 73),
	(54, 74),
	(54, 75),
	(57, 76),
	(54, 77),
	(58, 78),
	(58, 79),
	(59, 80),
	(58, 81),
	(58, 82),
	(60, 83),
	(58, 84),
	(58, 85),
	(58, 86),
	(58, 87),
	(58, 88);

SELECT setval('seq_autor', max(idAutor)) FROM autor;
SELECT setval('seq_cd', max(idCd)) FROM cd;
SELECT setval('seq_cd_categoria', max(idcategoria)) FROM cd_categoria;
SELECT setval('seq_faixa', max(numero_faixa)) FROM faixa;
SELECT setval('seq_gravadora', max(idGravadora)) FROM gravadora;
SELECT setval('seq_musica', max(idMusica)) FROM musica;