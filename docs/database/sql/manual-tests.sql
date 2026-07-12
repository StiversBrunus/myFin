DROP DATABASE IF EXISTS myfin;

CREATE DATABASE myfin
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

COMMENT ON DATABASE myfin
    IS 'Este banco de dados referece a versão inical do projeto myFinance.
Futuramente irei criar uma versão de produção e homologação.
Repositório do Github atual: investment-manager -> myFin.
';

--------------------------------------------------
-- TABLES
--------------------------------------------------

CREATE TABLE wallet (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	status BOOLEAN NOT NULL DEFAULT TRUE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

	-- UNIQUE --
	CONSTRAINT uq_wallet_name
	UNIQUE (name),
	
	-- PRIMARY KEY -- 
	CONSTRAINT pk_wallet PRIMARY KEY (id)
);

CREATE TABLE reserve (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	wallet_id BIGINT NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	status BOOLEAN NOT NULL DEFAULT TRUE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP

	-- UNIQUE DOBLE --
	CONSTRAINT uq_reserve_wallet_name
	UNIQUE (wallet_id, name),
	
	-- PRIMARY KEY --
	CONSTRAINT pk_reserve PRIMARY KEY (id)
);

CREATE TABLE goal (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	reserve_id BIGINT NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	initial_amount DECIMAL(15,2) NOT NULL,
	target_amount DECIMAL (15,2) NOT NULL,
	target_date DATE NULL,
	priority SMALLINT NOT NULL,
	status BOOLEAN NOT NULL DEFAULT TRUE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	
	-- CHECK --
	CONSTRAINT ck_goal_priority
	CHECK (priority IN (1, 2, 3)),

	CONSTRAINT ck_initial_amount
	CHECK (initial_amount >= 0),

	CONSTRAINT ck_target_amount
	CHECK (target_amount > 0),

	-- UNIQUE DOBLE --
	CONSTRAINT uq_goal_reserve_name
	UNIQUE (reserve_id, name),
	
	-- PRIMARY KEY --
	CONSTRAINT pk_goal PRIMARY KEY (id)
);

CREATE TABLE bank (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	status BOOLEAN NOT NULL DEFAULT TRUE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	-- UNIQUE --
	CONSTRAINT uq_bank_name
	UNIQUE (name),
	
	-- PRIMARY KEY --
	CONSTRAINT pk_bank PRIMARY KEY (id)
);

CREATE TABLE investment_type (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	status BOOLEAN NOT NULL DEFAULT TRUE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	-- UNIQUE --
	CONSTRAINT uq_investment_type_name
	UNIQUE (name),
	
	-- PRIMARY KEY --
	CONSTRAINT pk_investment_type PRIMARY KEY (id)
);

CREATE TABLE investment (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	bank_id BIGINT NOT NULL,
	investment_type_id BIGINT NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	status BOOLEAN NOT NULL DEFAULT TRUE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
	-- PRIMARY KEY --
	CONSTRAINT pk_investment PRIMARY KEY (id)
);

CREATE TABLE investment_transaction (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	goal_id BIGINT NOT NULL,
	investment_id BIGINT NOT NULL,
	transaction_date TIMESTAMP NOT NULL,
	transaction_type SMALLINT NOT NULL,
	amount DECIMAL(15,2) NOT NULL, 
	description VARCHAR(255),
	note TEXT,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	-- CHECK --
	CONSTRAINT ck_investment_transaction_transaction_type
	CHECK (transaction_type IN (1, 2, 3, 4)),

	CONSTRAINT ck_amount
	CHECK (amount > 0),
	
	-- PRIMARY KEY --
	CONSTRAINT pk_investment_transaction  PRIMARY KEY (id)
);

--------------------------------------------------
-- PRIMARY KEYS
-- (São criadas dentro do CREATE TABLE das tabelas)
--------------------------------------------------

--------------------------------------------------
-- FOREIGN KEYS
--------------------------------------------------

ALTER TABLE reserve
ADD CONSTRAINT fk_reserve_wallet
FOREIGN KEY (wallet_id)
REFERENCES wallet(id);

ALTER TABLE goal
ADD CONSTRAINT fk_goal_reserve
FOREIGN KEY (reserve_id)
REFERENCES reserve(id);

ALTER TABLE investment 
ADD CONSTRAINT fk_investment_bank
FOREIGN KEY (bank_id)
REFERENCES bank(id);

ALTER TABLE investment
ADD CONSTRAINT fk_investment_investment_type
FOREIGN KEY (investment_type_id)
REFERENCES investment_type(id);

ALTER TABLE investment_transaction 
ADD CONSTRAINT fk_investment_transaction_goal
FOREIGN KEY (goal_id)
REFERENCES goal(id);

ALTER TABLE investment_transaction
ADD CONSTRAINT fk_investment_transaction_investment
FOREIGN KEY (investment_id)
REFERENCES investment(id);

--------------------------------------------------
-- FUNCTIONS / TESTS
--------------------------------------------------

--- Teste do Banco de Dados;

-- Drop do Banco: Check.
-- Create do Banco: Check
-- Create das Tabelas: Check
-- Create das PK: Check
-- Create das FK: Check
-- Create das UK: Check
-- Create dos Check: Check


SELECT * FROM wallet;

/* 
Devem ser criados automaticamente:
	ID: Incrementado.
	Created_at: Data e Hora Atual do Servidor.
	Status: True.
Não podem repetir:
	id: Não pode existir uma wallet com o mesmo id;
	Name: Não pode existir uma Wallet com o mesmo nome.
*/

INSERT INTO wallet (name, description)
VALUES 
('Patrimônio Pessoal', 'Minha carteira de patrimônio pessoal.');

INSERT INTO wallet (name, description)
VALUES 
('Patrimônio Empresarial', 'Minha carteira de patrimônio empresarial.');

INSERT INTO wallet (name, description)
VALUES 
('Patrimônio Familiar', 'Minha carteira de patrimônio familiar.');

-- Teste do id
INSERT INTO wallet (id, name, description)
VALUES 
(11,'Patrimônio Teste ID', 'Minha carteira de patrimônio Teste ID.');

-- Teste de Uk
INSERT INTO wallet (name, description)
VALUES 
('Patrimônio Pessoal', 'Minha carteira de patrimônio Teste UK no campo Nome.');

SELECT * FROM reserve;

/* 
	Devem ser criados automaticamente:
		ID: Incrementado.
		Created_at: Data e Hora Atual do Servidor.
		Status: True.
	Não podem repetir:
		id: Não pode existir uma reserve com o mesmo id;
		Name: Não pode existir uma reserve com o mesmo nome que pertença a uma mesma carteira.
		wallet_id: Não pode criar uma reserva em uma carteira inexistente.
		wallet_id: Não pode ser null.
	Deve:
		wallet_id: Na criação de uma reserva, deve indicar o id da carteira que a reserva pertence.
	Pode:
		Name: Pode existir uma reserve com o mesmo nome que pertença a wallet Diferentes.
*/


INSERT INTO reserve (wallet_id, name, description)
VALUES 
(11, 'Reserva de Emergência','Minha reserva de emergência para o patrimônio pessoal.');

INSERT INTO reserve (wallet_id, name, description)
VALUES 
(12, 'Reserva de Emergência','Minha reserva de emergência para o patrimônio empresarial.');

INSERT INTO reserve (wallet_id, name, description)
VALUES 
(13, 'Reserva de Emergência','Minha reserva de emergência para o patrimônio familiar.');

-- wallet_id Nulo
INSERT INTO reserve (name, description)
VALUES 
('Reserva de Emergência Teste Wallet Null','Minha reserva de emergência para o Teste Wallet Null.');

-- wallet_id Inexistente
INSERT INTO reserve (wallet_id, name, description)
VALUES 
(100, 'Reserva de Emergência Teste Wallet_id Inexistente','Minha reserva de emergência para o Teste Wallet_id Inexistente.');


SELECT * FROM goal;

/* 
	Devem ser criados automaticamente:
		ID: Incrementado.
		Created_at: Data e Hora Atual do Servidor.
		Status: True.
	Não podem repetir:
		id: Não pode existir uma goal com o mesmo id;
		Name: Não pode existir uma objetivo com o mesmo nome que pertença a uma mesma reserva.
		reserve_id: Não pode criar um objetivo em uma reserva inexistente.
		reserve_id: Não pode ser null.
		initial_amount: Não pode ser Negativo.
		target_amount: Não pode ser negativo.
		priority: Não pode ser maior que três, nem menor que um.
	Deve:
		reserve_id: Na criação de um objetivo, deve indicar o id da reserve que o objetetivo pertence.
	Pode:
		Name: Pode existir um Objetivo com o mesmo nome que pertença a uma reserva Diferente.
		target_date: Pode ser Nulo.
*/

-- Goal, reserva e carteira Pessoal
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (1, 
	'Construção Reserva de Emergência',
	'Construção da Reserva de Emergência, equivalente à 6 meses da minha renda mensal.',
	1.00,
	15000.00,
	'2028-01-01',
	3);

-- Goal, reserve e carteira empresarial
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (2, 
	'Construção Reserva de Emergência Empresarial',
	'Construção da Reserva de Emergência da empresa, equivalente à 6 meses do faturamento.',
	1.00,
	18000.00, 
	'2028-07-01',
	2);

-- Goal, reserve e carteira familiar
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (3, 
	'Construção Reserva de Emergência Familiar',
	'Construção da Reserva de Emergência da familia, equivalente à 6 meses da renda mensal familiar.',
	1.00,
	15000.00, 
	'2028-01-01',
	1);

-- Objetivo com o mesmo nome. (UK)
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (1, 
	'Construção Reserva de Emergência',
	'Construção do Objetivo com o mesmo nome, deve dar erro.',
	2.00,
	19000.00,
	'2028-01-06',
	3);

-- Reserve Inexistente (erro de fk)
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (100, 
	'Objetivo: Tentar criar um Objetivo numa reserva que não existe.',
	'Construção da Reserva de Emergência da familia, equivalente à 6 meses da renda mensal familiar.',
	1.00,
	15000.00, 
	'2028-01-01',
	1);

-- Reserve_id null
INSERT INTO goal (
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (
	'Objetivo: Tentar criar um Objetivo numa reserve_id null.',
	'Construção da Reserva de Emergência da familia, equivalente à 6 meses da renda mensal familiar.',
	1.00,
	15000.00, 
	'2028-01-01',
	1);

-- Goal: Initial_amount não pode ser negativo.
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (1, 
	'Construção Reserva de Emergência: Initial_amount > 0 ',
	'Construção da Reserva de Emergência, valor inicial não pode ser negativo.',
	-100.00,
	15000.00,
	'2028-01-01',
	3);

-- Goal: target_amount não pode ser negativo.
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (1, 
	'Construção Reserva de Emergência: target_amount > 0 ',
	'Construção da Reserva de Emergência, valor meta não pode ser negativo.',
	1.00,
	-15000.00,
	'2028-01-01',
	3);

-- Goal: target_amount não pode ser igual a zero.
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (1, 
	'Construção Reserva de Emergência: target_amount = 0 ',
	'Construção da Reserva de Emergência, valor meta não pode ser zero.',
	1.00,
	0.00,
	'2028-01-01',
	3);

-- Goal: Check não pode ser maior que 3.
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (1, 
	'Construção Reserva de Emergência: priority > 3 ',
	'Construção da Reserva de Emergência, valor prioridade não pode ser maior 3.',
	1.00,
	15000.00,
	'2028-01-01',
	5);
	
-- Goal: Check não pode ser menor que 1.
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	target_date,
	priority)
VALUES (1, 
	'Construção Reserva de Emergência: priority < 1 ',
	'Construção da Reserva de Emergência, valor prioridade não pode ser menor 1.',
	1.00,
	15000.00,
	'2028-01-01',
	0);

-- Goal com o mesmo nome, porém reservas diferentes.
-- target_date: Pode ser nulo
INSERT INTO goal (reserve_id,
	name,
	description,
	initial_amount,
	target_amount,
	priority)
VALUES (3, 
	'Construção Reserva de Emergência',
	'Construção da Reserva de Emergência, equivalente à 6 meses da renda mensal da minha renda mensal Teste.',
	1.00,
	1000.00,
	3);

SELECT * FROM bank;

/* 
Devem ser criados automaticamente:
	ID: Incrementado.
	Created_at: Data e Hora Atual do Servidor.
	Status: True.
Não podem repetir:
	id: Não pode existir um banco com o mesmo id;
	Name: Não pode existir um banco com o mesmo nome.
*/

INSERT INTO bank (name, description)
VALUES 
('BTG Pactual Banking', 'Banco do BTG Pactual focado em conta corrente.');

INSERT INTO bank (name, description)
VALUES 
('BTG Pactual Investimentos', 'Banco do BTG Pactual focado em Investimentos.');

INSERT INTO bank (name, description)
VALUES 
('Mercado Pago', 'Instituição de Pagamento Mercado Pago.');

-- Teste do id
INSERT INTO bank (id, name, description)
VALUES 
(1,'Patrimônio Teste ID', 'Minha carteira de patrimônio Teste ID.');

-- Teste de Uk
INSERT INTO bank (name, description)
VALUES 
('BTG Pactual Banking', 'Minha carteira de patrimônio Teste UK no campo Nome.');


SELECT * FROM investment_type;

/* 
Devem ser criados automaticamente:
	ID: Incrementado.
	Created_at: Data e Hora Atual do Servidor.
	Status: True.
Não podem repetir:
	id: Não pode existir um tipo de investimento com o mesmo id;
	Name: Não pode existir um tipo de investimento com o mesmo nome.
*/

INSERT INTO investment_type (name, description)
VALUES 
('CDB', 'Certificado de Depósito Bancário.');

INSERT INTO investment_type (name, description)
VALUES 
('LCI', 'Letra de Crédito Imobiliário.');

INSERT INTO investment_type (name, description)
VALUES 
('LCA', 'Letra de Crédito do Agronegócio.');

-- Teste do id
INSERT INTO investment_type (id, name, description)
VALUES 
(1,'Patrimônio Teste ID', 'Minha carteira de patrimônio Teste ID.');

-- Teste de Uk
INSERT INTO investment_type (name, description)
VALUES 
('CDB', 'Minha carteira de patrimônio Teste UK no campo Nome.');

SELECT * FROM investment_type;

SELECT * FROM investment;
/* 
Devem ser criados automaticamente:
	ID: Incrementado.
	Created_at: Data e Hora Atual do Servidor.
	Status: True.
Não podem repetir:
	id: Não pode existir um tipo de investimento com o mesmo id;
	bank_id: Um investimento precisa pertencer a um banco.
	investment_type_id: Um investimento precisa pertencer a um tipo de investimento.
*/

SELECT * FROM bank
SELECT * FROM investment_type;
SELECT * FROM investment;

INSERT INTO investment (
	bank_id,
	investment_type_id,
	name,
	description)
VALUES (
	3,
	1,
	'CDB do Mercado Pago',
	'Certificado de Depósito Bancário do Mercado Pago.');

INSERT INTO investment (
	bank_id,
	investment_type_id,
	name,
	description)
VALUES (
	2,
	3,
	'LCA do BTG Pactual Investments',
	'Letras de Crédito do Agronegócio do BTG Pactual Investments.');


-- Banco Null
INSERT INTO investment (
	investment_type_id,
	name,
	description)
VALUES (
	1,
	'CDB do Mercado Pago',
	'Certificado de Depósito Bancário do Mercado Pago.');

-- Banco inexistente
INSERT INTO investment (
	bank_id,
	investment_type_id,
	name,
	description)
VALUES (
	100,
	1,
	'CDB do Banco inexistente',
	'Certificado de Depósito Bancário do Banco inexistente.');

-- Investimento sem tipo de investimento
INSERT INTO investment (
	bank_id,
	name,
	description)
VALUES (
	3,
	'Null do Mercado Pago',
	'Null do Mercado Pago.');

-- Investimento tipo de investimento inexistente
INSERT INTO investment (
	bank_id,
	investment_type_id,
	name,
	description)
VALUES (
	3,
	100,
	'Inexistente do Mercado Pago',
	'Inexistente do Mercado Pago.');


SELECT * FROM investment;

SELECT * FROM investment_transaction;

/* 
Devem ser criados automaticamente:
	ID: Incrementado.
	Created_at: Data e Hora Atual do Servidor.
Não podem repetir:
	goal_id: Uma transação precisa indicar para qual objetivo está sendo esta transação.
	investment_id: Uma transação precisa pertencer a um investimento, donde indica tipo e banco que está o dinheiro.
	transaction_date: não pode ser nulo.
	amount: não pode ser zero ou negativo.
	transaction_type: Menor que 1 e maior que 4
	
*/

INSERT INTO investment_transaction (
	goal_id,
	investment_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	1,
	NOW(),
	1,
	100.00,
	'Depósito de 100 reais com Objetivo da Construção da Minha Reserva de Emergência.',
	'Depósito de 1000 reais no CDB do Mercado Pago para Construção da Minha Reserva de emergência');


INSERT INTO investment_transaction (
	goal_id,
	investment_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	1,
	NOW(),
	2,
	100.00,
	'Regaste de 100 reais com Objetivo da Construção da Minha Reserva de Emergência.',
	'Resgate de 100 reais no CDB do Mercado Pago para Construção da Minha Reserva de emergência');


-- goal_id: nulo
INSERT INTO investment_transaction (
	investment_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	NOW(),
	1,
	100.00,
	'Depósito de 100 reais com Objetivo Null.',
	'Depósito de 1000 reais no CDB do Mercado Pago para Null');

-- goal_id: inexistente
INSERT INTO investment_transaction (
	goal_id,
	investment_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	75,
	1,
	NOW(),
	1,
	100.00,
	'Depósito de 100 reais com Inexistente',
	'Depósito de 1000 reais no CDB do Mercado Pago para Inexistencia.');

-- Investimento Null
INSERT INTO investment_transaction (
	goal_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	NOW(),
	1,
	100.00,
	'Depósito de 100 reais com Investimento nulo.',
	'Depósito de 1000 reais com investimento nulo.');
	
--- Investment_id: Inexistente
INSERT INTO investment_transaction (
	goal_id,
	investment_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	75,
	NOW(),
	1,
	100.00,
	'Depósito de 100 reais para investimento inexistente',
	'Depósito de 1000 reais para investimento inexistente');

-- data transação: nulo
INSERT INTO investment_transaction (
	goal_id,
	investment_id,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	1,
	1,
	100.00,
	'Depósito de 100 reais com Data de Transacao Nula',
	'Depósito de 1000 reais no Data de Transação Nula');

-- Valor da Transação ZERO:
INSERT INTO investment_transaction (
	goal_id,
	investment_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	1,
	NOW(),
	1,
	0.00,
	'Depósito de 0 reais com Objetivo da Construção da Minha Reserva de Emergência.',
	'Depósito de 0 reais no CDB do Mercado Pago para Construção da Minha Reserva de emergência');

-- Valor da Transação negativo:
INSERT INTO investment_transaction (
	goal_id,
	investment_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	1,
	NOW(),
	1,
	-100.00,
	'Depósito de -100 reais com Objetivo da Construção da Minha Reserva de Emergência.',
	'Depósito de -1000 reais no CDB do Mercado Pago para Construção da Minha Reserva de emergência');

-- transaction_type: menor que 1
INSERT INTO investment_transaction (
	goal_id,
	investment_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	1,
	NOW(),
	0,
	100.00,
	'Inexistente menor que 1 de 100 reais com Objetivo da Construção da Minha Reserva de Emergência.',
	'Inexistente menor que 1 de 1000 reais no CDB do Mercado Pago para Construção da Minha Reserva de emergência');

-- transaction_type maior do que 4
INSERT INTO investment_transaction (
	goal_id,
	investment_id,
	transaction_date,
	transaction_type,
	amount,
	description,
	note) 
VALUES (
	1,
	1,
	NOW(),
	10,
	100.00,
	'Inexistente maior que 4 de 100 reais com Objetivo da Construção da Minha Reserva de Emergência.',
	'Inexistente maior que 4 de 1000 reais no CDB do Mercado Pago para Construção da Minha Reserva de emergência');
