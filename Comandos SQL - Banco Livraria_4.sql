DROP TABLE IF EXISTS genero CASCADE;

CREATE TABLE genero (
  idgenero serial,
  descricao varchar(100) NOT NULL,
  PRIMARY KEY (idgenero)
);

insert  into genero(idgenero,descricao) values (nextval('genero_idgenero_seq'),'Espiritualismo'),
					       (2,'Infanto-Juvenil'),
					       (3,'Economia'),
					       (4,'Medicina'),
					       (5,'Romance'),
					       (6,'Historia'),
					       (7,'Fantasia'),
					       (8,'Auto-Ajuda'),
					       (9,'Informática'),
					       (10,'Humor');

DROP TABLE IF EXISTS editora CASCADE;

CREATE TABLE editora (
  ideditora serial,
  nome varchar(100) NOT NULL,
  fone varchar(30) DEFAULT NULL,
  PRIMARY KEY (ideditora)
);

insert  into editora(ideditora,nome,fone) values (nextval('editora_ideditora_seq'),'Casa dos Espiritos',NULL),
					       (2,'Id Editora',NULL),
					       (3,'Objetiva',NULL),
					       (4,'Manole',NULL),
					       (5,'Novo Conceito',NULL),
					       (6,'Record',NULL),
					       (7,'Benvirá',NULL),
					       (8,'Scipione',NULL),
					       (9,'Atica',NULL),
					       (10,'Campus',NULL);																									
																 
DROP TABLE IF EXISTS livro CASCADE;

CREATE TABLE livro (
  idlivro serial,
  titulo varchar(100) NOT NULL,
  preco float DEFAULT NULL,
  estoque int DEFAULT '0',
  idgenero int NOT NULL,
  ideditora int NOT NULL,
  PRIMARY KEY (idlivro),
  CONSTRAINT fk_livro_genero FOREIGN KEY (idgenero) REFERENCES genero (idgenero) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_livro_editora FOREIGN KEY (ideditora) REFERENCES editora (ideditora) ON DELETE NO ACTION ON UPDATE NO ACTION
);

insert  into livro(idlivro,titulo,preco,estoque,idgenero,ideditora) values (nextval('livro_idlivro_seq'),'Pelas Ruas de Calcutá',36.1,5,1,1),
					       (2,'Devoted - Devoção',27.2,4,2,2),
					       (3,'Rápido e Devagar - Duas Formas de Pensar',43.9,8,3,3),
					       (4,'Xô, Bactéria! Tire Suas Dúvidas Com Dr. Bactéria',32.7,6,4,4),
					       (5,'P.s. - Eu Te Amo ',23.5,10,5,5),
					       (6,'O Que Esperar Quando Você Está Esperando',37.8,20,4,6),
					       (7,'As Melhores Frases Em Veja',23.9,0,6,7),
					       (8,'Bichos Monstruosos',24.9,12,2,6),
					       (9,'Casas Mal Assombradas',27.9,0,2,6);
																								
DROP TABLE IF EXISTS autor CASCADE;

CREATE TABLE autor (
  idautor serial,
  nome varchar(100) DEFAULT NULL,
  email varchar(100) DEFAULT NULL,
  PRIMARY KEY (idautor)	
);

insert  into autor(idautor,nome,email) values (nextval('autor_idautor_seq'),'Roberto Martins Figueiredo',NULL),
					       (2,'Daniel Kahneman',NULL),
					       (3,'Hilary Duff',NULL),
					       (4,'Robson Pinheiro',NULL),
					       (5,'Cecelia Ahern',NULL),
					       (6,'Arlene Einsenberg',NULL),
					       (7,'Sandee Hathaway',NULL),
					       (8,'Heidi Murkoff',NULL),
					       (9,'Julio Cesar de Barros',NULL),
					       (10,'Maria José Valero',NULL);
															 
DROP TABLE IF EXISTS escreve CASCADE;

CREATE TABLE escreve (
  idlivro int NOT NULL,
  idautor int NOT NULL,
  PRIMARY KEY (idlivro,idautor),
  CONSTRAINT fk_escr_livro FOREIGN KEY (idlivro) REFERENCES livro (idlivro) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_escr_autor FOREIGN KEY (idautor) REFERENCES autor (idautor) ON DELETE NO ACTION ON UPDATE NO ACTION
);

insert  into escreve(idlivro,idautor) values (1,1),(2,3),(3,2),(5,3),(6,2),(6,6),(6,7),(7,9),(8,10),(9,10);


DROP TABLE IF EXISTS cliente CASCADE;

CREATE TABLE cliente (
  idcliente serial,
  nome varchar(100) NOT NULL,
  telefone varchar(45) DEFAULT NULL,
  PRIMARY KEY (idcliente)
);

insert  into cliente(idcliente,nome,telefone) values (nextval('cliente_idcliente_seq'),'Joao Silva ','1111'),
					       (2,'Maria Cunha','2222'),
					       (3,'Pedro Aguiar','8888'),
					       (4,'Elaine Luciana','9374'),
					       (5,'Antonio Pereira','3764'),
					       (6,'Catarina Dias','999'),
					       (7,'Felipe Escolar','8787'),
					       (8,'Nando Caixinha','5478'),
					       (9,'Pelé Golias','7811'),
					       (10,'Tito Vardones','7489');
																		
DROP TABLE IF EXISTS itens_da_venda CASCADE;

CREATE TABLE itens_da_venda (
  idvenda int NOT NULL,
  idlivro int NOT NULL,
  qtd int DEFAULT NULL,
  subtotal varchar(45) DEFAULT NULL,
  PRIMARY KEY (idvenda,idlivro),
  CONSTRAINT fk_venda_livro FOREIGN KEY (idlivro) REFERENCES livro (idlivro) ON DELETE NO ACTION ON UPDATE NO ACTION
);

insert  into itens_da_venda(idvenda,idlivro,qtd,subtotal) values (1,1,1,NULL),
					       (1,2,1,NULL),
					       (2,2,2,NULL),
					       (2,3,1,NULL),
					       (3,4,1,NULL),
					       (4,5,1,NULL),
					       (5,5,1,NULL),
					       (6,5,1,NULL),
					       (7,6,1,NULL),
					       (8,7,2,NULL),
					       (9,8,3,NULL),
					       (10,9,1,NULL),
					       (11,6,1,NULL),
					       (12,1,1,NULL),
					       (13,4,1,NULL),
					       (14,7,2,NULL),
					       (15,9,1,NULL),
					       (16,3,1,NULL),
					       (17,8,4,NULL),
					       (18,2,1,NULL),
					       (19,4,1,NULL),
					       (20,6,1,NULL);

DROP TABLE IF EXISTS venda;

CREATE TABLE venda (
  idvenda serial,
  data date DEFAULT NULL,
  total float DEFAULT '0',
  idcliente int NOT NULL,
  PRIMARY KEY (idvenda,idcliente),
  CONSTRAINT fk_venda_cliente FOREIGN KEY (idcliente) REFERENCES cliente (idcliente) ON DELETE NO ACTION ON UPDATE NO ACTION
);

insert  into venda(idvenda,data,total,idcliente) values (nextval('venda_idvenda_seq'),'2012-01-01',30,1),
					       (2,'2012-02-02',60,2),
					       (3,'2012-03-03',90,3),
					       (4,'2012-04-04',120,4),
					       (5,'2012-05-05',50,5),
					       (6,'2012-06-06',600,6),
					       (7,'2012-07-07',70,7),
					       (8,'2012-08-08',85,8),
					       (9,'2012-09-09',100,9),
					       (10,'2012-10-10',35,10),
					       (11,'2012-11-11',99,1),
					       (12,'2012-12-12',59,2),
					       (13,'2011-01-02',46,3),
					       (14,'2011-02-01',399,4),
					       (15,'2011-03-04',42,5),
					       (16,'2011-04-03',79,6),
					       (17,'2011-05-06',130,7),
					       (18,'2011-06-05',245,8),
					       (19,'2011-07-06',19,9),
					       (20,'2011-08-09',14,10);
SELECT setval('autor_idautor_seq', max(idAutor)) FROM autor;
SELECT setval('cliente_idcliente_seq', max(idcliente)) FROM cliente;
SELECT setval('editora_ideditora_seq', max(ideditora)) FROM editora;
SELECT setval('genero_idgenero_seq', max(idgenero)) FROM genero;
SELECT setval('livro_idlivro_seq', max(idlivro)) FROM livro;
SELECT setval('venda_idvenda_seq', max(idvenda)) FROM venda;																			