--------------------------------------------------
-- Project: Investment Manager - MyFin
-- GitHub: investment-manager -> myFin
-- Author: @StiversBrunus (Bruno Oliveira)
-- DBMS: PostgreSQL 17
-- Database: myfin 
--------------------------------------------------

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
-- INDEX
--------------------------------------------------

--------------------------------------------------
-- VIEWS
--------------------------------------------------

--------------------------------------------------
-- TRIGGER
--------------------------------------------------

--------------------------------------------------
-- FUNCTIONS / PROCEDURES
--------------------------------------------------