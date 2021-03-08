--CRIAÇÃO DAS TABELAS DO SISTEMA "EMPRESA X"
  begin transaction;
   
  create table CLIENTE (
       id bigint not null,
       nome varchar(50) not null,
       sobrenome varchar(50)  not null,
       telefone varchar(20) not null,
       data_nascimento date not null,
       endereco varchar(300) not null,
       ativo boolean not null default 't',
       cpf varchar(15) not null,
       constraint pk_cliente primary key(id)
  );
  create sequence seq_cliente_id;
   
  create table ESTOQUE(
       id bigint not null,
       descricao varchar(50) not null,
       ativo boolean not null default 't',
       constraint pk_estoque primary key(id)
  );
  create sequence seq_estoque_id;
   
  create table PRODUTO(
    id bigint not null,
    descricao varchar(100) not null,
    valor_venda numeric(22,2) not null,
    custo_medio numeric(22,2) not null,
    ativo boolean not null default 't',
    constraint pk_produto primary key(id)
  );
   
  create sequence seq_produto_id;
   
  create table PRODUTOS_ESTOQUE(
   id_produto integer not null,
   id_estoque integer not null,
   quantidade numeric(25,5) not null,
   constraint pk_produtos_estoque primary key(id_produto,id_estoque),
   constraint fk_pe_produto foreign key(id_produto) references produto(id), 
   constraint fk_pe_estoque foreign key(id_estoque) references estoque(id) 
  );
   
  create table CABECALHO_NOTA_FISCAL(
   id bigint not null,
   data_emissao date not null,
   valor_total numeric(22,2) not null,
   total_impostos numeric(22,2) not null,
   tipo_operacao char(1) not null,
   id_cliente integer not null,
   desconto numeric(22,2) not null,
   cancelada boolean not null default 'f',
   constraint pk_cabecalho_nota_fiscal primary key(id),
   constraint fk_cnf_cliente foreign key(id_cliente)references cliente(id),
   constraint ck_tipo_operacao check(tipo_operacao = 'V' or tipo_operacao = 'C')
   
   );
  create sequence seq_cabecalho_nf_id;
   
  create table ITEM_NOTA_FISCAL(
    id bigint not null,
    id_produto integer not null,
    valor_item numeric(22,2) not null,
    quantidade numeric(22,5) not null,
    id_cabecalho_nota_fiscal integer,
    desconto numeric(20,2) not null,
    constraint pk_item_nota_fiscal primary key(id),
    constraint fk_inf_nota_fiscal foreign key(id_cabecalho_nota_fiscal) 
    references cabecalho_nota_fiscal(id)
  );
  create sequence seq_item_nf_id;
   
  commit; 