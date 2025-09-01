drop table if exists movimento;
drop table if exists cartao;
drop table if exists conta;
drop table if exists associado;

create table associado
(
	id_associado integer generated always as identity primary key,
	nome varchar(4000),
	sobrenome varchar(4000),
	idade integer,
	email varchar(4000)
);

create table conta
(
	id_conta integer generated always as identity primary key,
	tipo varchar(1),
	data_criacao timestamp,
	id_associado integer references associado(id_associado)
);

create table cartao
(
	id_cartao integer generated always as identity primary key,
	num_cartao bigint,
	nom_impresso varchar(100),
	id_conta integer,
	id_associado integer references associado(id_associado),
	data_criacao timestamp
);

create table movimento
(
	id_movimento integer generated always as identity primary key,
	vlr_transacao decimal(10,2),
	des_tranacao varchar(4000),
	data_movimento TIMESTAMP,
	id_cartao integer references cartao(id_cartao)
);