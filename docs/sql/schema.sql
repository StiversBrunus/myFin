-- Database: myfin

-- DROP DATABASE IF EXISTS myfin;

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

CREATE TABLE wallet (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	status BOOLEAN NOT NULL DEFAULT TRUE
);

CONSTRAINT pk_wallet PRIMARY KEY (id),


CREATE TABLE reserve (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	wallet_id BIGINT NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	status BOOLEAN NOT NULL DEFAULT TRUE		
);

CONSTRAINT pk_reserve PRIMARY KEY (id),

CREATE TABLE goal (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	reserve_id BIGINT NOT NULL,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	initial_amount DECIMAL(15,2) NOT NULL,
	target_amount DECIMAL (15,2) NOT NULL,
	target_date DATE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	priority SMALLINT NOT NULL,
	status BOOLEAN NOT NULL DEFAULT TRUE
);

CONSTRAINT pk_goal PRIMARY KEY (id),
CHECK (priority IN (1, 2, 3)),

CREATE TABLE investment_transaction (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	goal_id BIGINT NOT NULL,
	investment_id BIGINT NOT NULL,
	transaction_date TIMESTAMP NOT NULL,
	transaction_type SMALLINT NOT NULL,
	amount DECIMAL(15,2) NOT NULL, 
	description VARCHAR(255),
	note TEXT,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CONSTRAINT pk_investment_transaction  PRIMARY KEY (id),
CHECK (transaction_type IN (1, 2, 3, 4)),
