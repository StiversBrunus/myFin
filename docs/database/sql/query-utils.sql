--------------------------------------------------
-- QUERY UTILS
--------------------------------------------------

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';

-- LISTANDO TODAS AS CARTEIRAS + RESERVAS
SELECT wt.name, rv.name, rv.description FROM reserve AS rv 
	INNER JOIN wallet AS wt ON (rv.wallet_id = wt.id) 
	WHERE rv.status = true
	ORDER BY rv.id ASC;

-- LISTANDO TODAS AS CARTEIRAS + RESERVAS + OBJETIVOS
SELECT wt.name, rv.name, gl.name, gl.target_amount FROM goal AS gl
	INNER JOIN reserve AS rv ON (gl.reserve_id = rv.id)
	INNER JOIN wallet AS wt ON (rv.wallet_id = wt.id)
	WHERE gl.status = true AND rv.status = true AND wt.status = true
	ORDER BY rv.id ASC;

-- LISTANDO TODOS OS INVESTIMENTOS + TIPOS DE INVESTIMENTOS + BANCOS
SELECT bk.name, vst.description, vst_tp.name FROM investment AS vst
	INNER JOIN investment_type AS vst_tp ON (vst.investment_type_id = vst_tp.id)
	INNER JOIN bank AS bk ON (vst.bank_id = bk.id)
	WHERE vst.status = true AND vst_tp.status = true AND bk.status = true;

--- LISTAR: TODAS AS TRANSAÇÕES:
---								 INVESTIMENTOS + TIPOS DE INVESTIMENTOS + BANCOS
---								 OBJETIVOS + RESERVAS + CARTEIRAS

SELECT * FROM investment_transaction;
