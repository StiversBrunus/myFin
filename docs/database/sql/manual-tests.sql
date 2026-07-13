DROP DATABASE IF EXISTS myfin;

-- ===============================================================================================
-- TESTE 001 - CRUD
-- Entidade...........: Banco de Dados
-- Objetivo...........: Execultar todo script SQL em um banco vazio.
-- Resultado Esperado.: Banco, tabelas, constraints e relacionamento devem ser criados sem erros.
-- Status.............: APROVADO ✅
-- ===============================================================================================

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

-- =============================================================================
-- TESTE 002 - CRUD
-- Entidade...........: Wallet
-- Objetivo...........: Inserir uma Wallet.
-- Resultado Esperado.: Registro criado com sucesso.
-- Status.............: APROVADO ✅
-- =============================================================================

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

-- ============================================================================
-- CONSTRAINT: uq_wallet_name
-- Tipo..............: UNIQUE
-- Finalidade........: Impedir Wallets com o mesmo nome.
-- Teste(s)..........: TESTE 021
-- Status.............: APROVADO ✅
-- ============================================================================

INSERT INTO wallet (name, description)
VALUES 
('Patrimônio Pessoal', 'Minha carteira de patrimônio Teste UK no campo Nome.');

-- =============================================================================
-- TESTE 003 - CRUD
-- Entidade...........: Reserve
-- Objetivo...........: Inserir uma Reserve vinculada a uma Wallet.
-- Resultado Esperado.: Registro criado com sucesso.
-- Status.............: APROVADO ✅
-- =============================================================================

INSERT INTO reserve (wallet_id, name, description)
VALUES 
(11, 'Reserva de Emergência','Minha reserva de emergência para o patrimônio pessoal.');

-- ============================================================================
-- CONSTRAINT: uq_wallet_name
-- Tipo..............: UNIQUE
-- Finalidade........: Criar duas Reservas com o mesmo nome na mesma Wallet.
-- Teste(s)..........: TESTE 023
-- Status.............: APROVADO ✅
-- ============================================================================

INSERT INTO reserve (wallet_id, name, description)
VALUES 
(12, 'Reserva de Emergência','Minha reserva de emergência para o patrimônio empresarial.');

INSERT INTO reserve (wallet_id, name, description)
VALUES 
(13, 'Reserva de Emergência','Minha reserva de emergência para o patrimônio familiar.');

-- =============================================================================
-- TESTE 010 - FOREIGN KEY
-- Objetivo...........: Inserir uma Reserve utilizando uma Wallet inexistente.
-- Resultado Esperado.: Erro de FOREIGN KEY.
-- Status.............: APROVADO ✅
-- =============================================================================

INSERT INTO reserve (wallet_id, name, description)
VALUES 
(100, 'Reserva de Emergência Teste Wallet_id Inexistente','Minha reserva de emergência para o Teste Wallet_id Inexistente.');

-- =============================================================================
-- TESTE 004 - CRUD
-- Entidade...........: Goal
-- Objetivo...........: Inserir um Goal vinculado a uma Reserve.
-- Resultado Esperado.: Registro criado com sucesso.
-- Status.............: APROVADO ✅
-- =============================================================================

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

-- ============================================================================
-- CONSTRAINT: uq_wallet_name
-- Tipo..............: UNIQUE
-- Finalidade........: Impedir Criar dois Goals com o mesmo nome na mesma Reserve.
-- Teste(s)..........: TESTE 024
-- Status.............: APROVADO ✅
-- ============================================================================

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

-- =============================================================================
-- TESTE 011 - FOREIGN KEY
-- Objetivo...........: Inserir um Goal utilizando uma Reserve inexistente.
-- Resultado Esperado.: Erro de FOREIGN KEY.
-- Status.............: APROVADO ✅
-- =============================================================================

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

-- ==================================================================================
-- CONSTRAINT: ck_goal_priority
-- Tipo..............: CHECK
-- Finalidade........: Permitir apenas valor inicial positivo.
-- Teste(s)..........: TESTE 019
-- Status.............: APROVADO ✅
-- ==================================================================================

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

-- ==================================================================================
-- CONSTRAINT: ck_goal_priority
-- Tipo..............: CHECK
-- Finalidade........: Permitir apenas valor da meta maior do que zero.
-- Teste(s)..........: TESTE 018
-- Status.............: APROVADO ✅
-- ==================================================================================

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

-- ==================================================================================
-- CONSTRAINT: ck_goal_priority
-- Tipo..............: CHECK
-- Finalidade........: Permitir apenas prioridades 1 (Baixa), 2 (Média) ou 3 (Alta).
-- Teste(s)..........: TESTE 016
-- Status.............: APROVADO ✅
-- ==================================================================================

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

-- ============================================================================
-- CONSTRAINT: uq_goal_name
-- Tipo..............: UNIQUE
-- Finalidade........: Permitir Criar dois Goals com o mesmo nome em Reservas diferentes.
-- Observação........: Data de Vencimento pode ser nula
-- Teste(s)..........: TESTE 025
-- Status.............: APROVADO ✅
-- ============================================================================

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

-- =============================================================================
-- TESTE 005 - CRUD
-- Entidade...........: Bank
-- Objetivo...........: Inserir um bank.
-- Resultado Esperado.: Registro criado com sucesso.
-- Status.............: APROVADO ✅
-- =============================================================================

INSERT INTO bank (name, description)
VALUES 
('BTG Pactual Banking', 'Banco do BTG Pactual focado em conta corrente.');

INSERT INTO bank (name, description)
VALUES 
('BTG Pactual Investimentos', 'Banco do BTG Pactual focado em Investimentos.');

INSERT INTO bank (name, description)
VALUES 
('Mercado Pago', 'Instituição de Pagamento Mercado Pago.');

-- ============================================================================
-- CONSTRAINT: uq_bank_name
-- Tipo..............: UNIQUE
-- Finalidade........: Impedir Criar dois Banks com o mesmo nome. 
-- Teste(s)..........: TESTE 026
-- Status.............: APROVADO ✅
-- ============================================================================

INSERT INTO bank (name, description)
VALUES 
('BTG Pactual Banking', 'Minha carteira de patrimônio Teste UK no campo Nome.');

-- =============================================================================
-- TESTE 006 - CRUD
-- Entidade...........: Investment Type
-- Objetivo...........: Inserir um Investment Type.
-- Resultado Esperado.: Registro criado com sucesso.
-- Status.............: APROVADO ✅
-- =============================================================================

INSERT INTO investment_type (name, description)
VALUES 
('CDB', 'Certificado de Depósito Bancário.');

INSERT INTO investment_type (name, description)
VALUES 
('LCI', 'Letra de Crédito Imobiliário.');

INSERT INTO investment_type (name, description)
VALUES 
('LCA', 'Letra de Crédito do Agronegócio.');

-- ============================================================================
-- CONSTRAINT: uq_investment_type_name
-- Tipo..............: UNIQUE
-- Finalidade........: Impedir Criar dois Investment Types com o mesmo nome.
-- Teste(s)..........: TESTE 027
-- Status.............: APROVADO ✅
-- ============================================================================

INSERT INTO investment_type (name, description)
VALUES 
('CDB', 'Minha carteira de patrimônio Teste UK no campo Nome.');

-- =============================================================================
-- TESTE 007 - CRUD
-- Entidade...........: Investment 
-- Objetivo...........: Inserir um Investment.
-- Resultado Esperado.: Registro criado com sucesso.
-- Status.............: APROVADO ✅
-- =============================================================================

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

-- =============================================================================
-- TESTE 012 - FOREIGN KEY
-- Objetivo...........: Inserir um Investment utilizando uma Bank inexistente.
-- Resultado Esperado.: Erro de FOREIGN KEY.
-- Status.............: APROVADO ✅
-- =============================================================================

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

-- =============================================================================
-- TESTE 013 - FOREIGN KEY
-- Objetivo...........: Inserir um Investment utilizando uma Investment Type inexistente.
-- Resultado Esperado.: Erro de FOREIGN KEY.
-- Status.............: APROVADO ✅
-- =============================================================================

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

-- =============================================================================
-- TESTE 008 - CRUD
-- Entidade...........: Investment Transaction
-- Objetivo...........: Inserir um Investment Transaction.
-- Resultado Esperado.: Registro criado com sucesso.
-- Status.............: APROVADO ✅
-- =============================================================================

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

-- =============================================================================
-- TESTE 014 - FOREIGN KEY
-- Objetivo...........: Inserir um Investment Transaction utilizando uma Goal inexistente.
-- Resultado Esperado.: Erro de FOREIGN KEY.
-- Status.............: APROVADO ✅
-- =============================================================================

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

-- =============================================================================
-- TESTE 015 - FOREIGN KEY
-- Objetivo...........: Inserir um Investment Transaction utilizando uma Investment inexistente.
-- Resultado Esperado.: Erro de FOREIGN KEY.
-- Status.............: APROVADO ✅
-- =============================================================================

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

-- ==================================================================================
-- CONSTRAINT: ck_goal_priority
-- Tipo..............: CHECK
-- Finalidade........: Impedir valor da transação igual a zero.
-- Teste(s)..........: TESTE 020
-- Status.............: APROVADO ✅
-- ==================================================================================

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

-- ==================================================================================
-- CONSTRAINT: ck_goal_priority
-- Tipo..............: CHECK
-- Finalidade........: Impedir valor de transação negativo.
-- Teste(s)..........: TESTE 02x
-- Status.............: APROVADO ✅
-- ==================================================================================

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

-- ==================================================================================
-- CONSTRAINT: ck_goal_priority
-- Tipo..............: CHECK
-- Finalidade........: Permitir apenas tipo de transação 1 (Depósitos), 2 (Resgates),
--					  3 (Rendimentos), 4 (Ajustes).
-- Teste(s)..........: TESTE 017
-- Status.............: APROVADO ✅
-- ==================================================================================

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

-- =============================================================================
-- TESTE 028 - RELACIONAMENTOS
--
-- Objetivo:
-- Validar o relacionamento entre as tabelas Wallet → Reserve → Goal →
-- Investment Transaction.
--
-- Resultado esperado:
-- A consulta deve retornar corretamente os registros relacionados entre
-- as quatro tabelas, preservando a integridade referencial.
--
--  |Patrimônio Pessoal|Reserva de Emergência|Construção Reserva de Emergência|100.00|Depósito de 100 reais...|
--
-- Status:
-- APROVADO ✅
-- =============================================================================


SELECT goal.id, wallet.name, reserve.name, goal.name,
	investment_transaction.amount, investment_transaction.description 
	FROM investment_transaction
	INNER JOIN goal ON investment_transaction.goal_id = goal.id 
	INNER JOIN reserve ON goal.reserve_id = reserve.id
	INNER JOIN wallet ON reserve.wallet_id = wallet.id
	WHERE investment_transaction.transaction_type = 1;

-- =============================================================================
-- TESTE 029 - RELACIONAMENTOS
--
-- Objetivo:
-- Validar o relacionamento entre as tabelas Bank → Investment Type →
-- Investment → Investment Transaction.
--
-- Resultado esperado:
-- A consulta deve retornar corretamente os registros relacionados entre
-- as quatro tabelas, preservando a integridade referencial.
--
-- |Mercado Pago|CDB|C... do Mercado Pago |100.00|Depósito de 100 reais...|
--
-- Status:
-- APROVADO ✅
-- =============================================================================

SELECT bank.name, investment_type.name, investment.description, investment_transaction.amount, investment_transaction.description
	FROM investment_transaction
	INNER JOIN investment ON investment_transaction.investment_id = investment.id
	INNER JOIN bank ON investment.bank_id = bank.id
	INNER JOIN 	investment_type ON investment_type_id = investment_type.id
	WHERE investment_transaction.transaction_type = 1; 

-- =============================================================================
-- TESTE 030 - RELACIONAMENTOS
--
-- Objetivo:
-- Validar os relacionamentos utilizando JOIN entre todas as tabelas do
-- modelo de dados.
--
-- Resultado esperado:
-- A consulta deve retornar corretamente os registros relacionados entre
-- Wallet, Reserve, Goal, Investment, Investment Type, Bank e
-- Investment Transaction.
--
-- |Patrimônio Pessoal|Reserva de Emergência|Construção Reserva de Em...|100.00|Mercad...|CDB|Certificado de Depósito...|
--
-- Status:
-- APROVADO ✅
-- =============================================================================

SELECT wallet.name, reserve.name, goal.name,
	investment_transaction.amount, bank.name,
	investment_type.name, investment.description
FROM investment_transaction
INNER JOIN goal ON  investment_transaction.goal_id = goal.id
INNER JOIN reserve ON goal.reserve_id = reserve.id
INNER JOIN wallet ON reserve.wallet_id = wallet.id
INNER JOIN investment ON investment_transaction.investment_id = investment.id
INNER JOIN investment_type ON investment.investment_type_id = investment_type.id
INNER JOIN bank ON investment.bank_id = bank.id
WHERE investment_transaction.transaction_type = 1;

SELECT wallet.name, reserve.name, goal.name,
	investment_transaction.amount, bank.name,
	investment_type.name, investment.description
FROM investment_transaction
INNER JOIN goal ON  investment_transaction.goal_id = goal.id
INNER JOIN reserve ON goal.reserve_id = reserve.id
INNER JOIN wallet ON reserve.wallet_id = wallet.id
INNER JOIN investment ON investment_transaction.investment_id = investment.id
INNER JOIN investment_type ON investment.investment_type_id = investment_type.id
INNER JOIN bank ON investment.bank_id = bank.id;

-- =============================================================================
-- TESTES 031 A 036 - EXCLUSÕES
--
-- Objetivo:
-- Validar que o banco de dados impede a exclusão de registros que possuem
-- relacionamentos ativos, preservando a integridade referencial.
--
-- Resultado esperado:
-- As operações de exclusão devem ser bloqueadas pelas Foreign Keys.
--
-- Status:
-- APROVADO ✅
-- =============================================================================

-- =============================================================================
-- TESTE 031 - EXCLUSÃO
-- Objetivo...........: Excluir uma Wallet com Reservas associadas.
-- Resultado esperado.: Exclusão bloqueada pela Foreign Key.
-- Status.............: APROVADO ✅
-- =============================================================================
DELETE FROM wallet;

-- =============================================================================
-- TESTE 032 - EXCLUSÃO
-- Objetivo...........: Excluir uma Reserve com Goals associados.
-- Resultado esperado.: Exclusão bloqueada pela Foreign Key.
-- Status.............: APROVADO ✅
-- =============================================================================
DELETE FROM reserve;

-- =============================================================================
-- TESTE 033 - EXCLUSÃO
-- Objetivo...........: Excluir um Goal com Investment Transactions associadas.
-- Resultado esperado.: Exclusão bloqueada pela Foreign Key.
-- Status.............: APROVADO ✅
-- =============================================================================
DELETE FROM goal;

-- =============================================================================
-- TESTE 034 - EXCLUSÃO
-- Objetivo...........: Excluir um Bank com Investments associados.
-- Resultado esperado.: Exclusão bloqueada pela Foreign Key.
-- Status.............: APROVADO ✅
-- =============================================================================
DELETE FROM bank;

-- =============================================================================
-- TESTE 035 - EXCLUSÃO
-- Objetivo...........: Excluir um Investment Type com Investments associados.
-- Resultado esperado.: Exclusão bloqueada pela Foreign Key.
-- Status.............: APROVADO ✅
-- =============================================================================
DELETE FROM investment_type;

-- =============================================================================
-- TESTE 036 - EXCLUSÃO
-- Objetivo...........: Excluir um Investment com Investment Transactions
--                      associadas.
-- Resultado esperado.: Exclusão bloqueada pela Foreign Key.
-- Status.............: APROVADO ✅
-- =============================================================================
DELETE FROM investment;

-- =============================================================================
-- LIMPEZA DO AMBIENTE DE TESTES
--
-- Objetivo:
-- Remover todos os registros respeitando a ordem dos relacionamentos,
-- preparando o banco para uma nova execução dos testes.
-- =============================================================================

DELETE FROM investment_transaction;
DELETE FROM investment;
DELETE FROM investment_type;
DELETE FROM bank;
DELETE FROM goal;
DELETE FROM reserve;
DELETE FROM wallet;










