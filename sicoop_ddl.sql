
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
	id_associado integer references associado(id_associado)
);

create table movimento
(
	id_movimento integer generated always as identity primary key,
	vlr_transacao decimal(10,2),
	des_tranacao varchar(4000),
	data_movimento TIMESTAMP,
	id_cartao integer references cartao(id_cartao)
);


-- 100 associados
INSERT INTO associado (nome, sobrenome, idade, email)
SELECT 
    'Nome'||i 					as nome, 
    'Sobrenome'||i 				as sobrenome,
    18 + (i % 50)				as idade,
    'usuario'||i||'@email.com'	as email
FROM generate_series(1,100) AS s(i);

-- 120 contas
INSERT INTO conta (tipo, data_criacao, id_associado)
SELECT
    CASE 
		WHEN i % 2 = 0 
		THEN 'F' 
		ELSE 'J' 
	end 								as tipo,
    NOW() - (i || ' days')::interval 	as data_criacao,
    ((i-1) % 100) + 1 					as id_associado
FROM generate_series(1,120) AS s(i);

-- Cartões (1-2 por conta)
INSERT INTO cartao (num_cartao, nom_impresso, id_conta, id_associado)
SELECT
    4000000000000000 + i*10 + j 	as num_cartao,
    'Nome'||(((i-1) % 100)+1) 		as nom_impresso,
    i 								as id_conta,
    ((i-1) % 100) + 1 				as id_associado
FROM generate_series(1,120) AS s(i)
JOIN LATERAL generate_series(1,2) AS g(j) ON TRUE;

-- Movimentos (1000 registros)
INSERT INTO movimento (vlr_transacao, des_tranacao, data_movimento, id_cartao)
select
	(i % 5000 + 10)::decimal(10,2)  	as vlr_transacao,
    CASE 
		WHEN i % 4 = 0 THEN 'Supermercado'
        WHEN i % 4 = 1 THEN 'Restaurante'
        WHEN i % 4 = 2 THEN 'Pagamento Aluguel'
        ELSE 'Compra Online' 
    end 								as des_tranacao,
    NOW() - (i || ' days')::interval 	as data_movimento,
    ((i-1) % 150) + 1					as id_cartao
FROM generate_series(1,1000) AS s(i);