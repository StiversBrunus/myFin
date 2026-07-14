--------------------------------------------------
-- TABLES
--------------------------------------------------

CREATE TABLE wallet (
	id BIGINT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(255),
	status BOOLEAN NOT NULL DEFAULT TRUE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

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
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

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
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	
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

