--------------------------------------------------
-- INITIAL DATA (dados fixos)
--------------------------------------------------

--------------------------------------------------
-- BANCOS
--------------------------------------------------

INSERT INTO bank (name, description) 
	VALUES ('Banco do Brasil', 'Banco do Brasil S.A');

INSERT INTO bank (name, description) 
	VALUES ('Caixa Econômica Federal', 'Caixa Econômica Federal');

INSERT INTO bank (name, description) 
	VALUES ('Bradesco', 'Banco Bradesco S.A');

INSERT INTO bank (name, description) 
	VALUES ('Itaú Unibanco', 'Itaú Unibanco S.A');

INSERT INTO bank (name, description) 
	VALUES ('Santander', 'Banco Santander (Brasil) S.A');

INSERT INTO bank (name, description) 
	VALUES ('Nubank', 'Nu Pagamentos S.A. (Nubank)');

INSERT INTO bank (name, description) 
	VALUES ('Inter', 'Banco Inter S.A');

INSERT INTO bank (name, description) 
	VALUES ('C6 Bank', 'Banco C6 S.A. (C6 Bank)');

INSERT INTO bank (name, description) 
	VALUES ('BTG Pactual', 'Banco BTG Pactual S.A');

INSERT INTO bank (name, description) 
	VALUES ('XP Investimentos', 'XP Investimentos Corretora de Câmbio, Títulos e Valores Mobiliários S.A');

INSERT INTO bank (name, description) 
	VALUES ('Mercado Pago', 'Mercado Pago Instituição de Pagamento Ltda');

INSERT INTO bank (name, description) 
	VALUES ('PicPay', 'PicPay Instituição de Pagamento S.A');

--------------------------------------------------
-- TIPOS DE INVESTIMENTOS
--------------------------------------------------

INSERT INTO investment_type (name, description) 
	VALUES ('Conta de Investimento', 'Conta de Investimento');

INSERT INTO investment_type (name, description) 
	VALUES ('Poupança', 'Caderneta de Poupança');

INSERT INTO investment_type (name, description) 
	VALUES ('CDB', 'Certificado de Depósito Bancário');

INSERT INTO investment_type (name, description) 
	VALUES ('Tesouro Direto', 'Programa Tesouro Direto - Programa de Negociação de Títulos Públicos Federais');

INSERT INTO investment_type (name, description) 
	VALUES ('LCI', 'Letra de Crédito Imobiliário');

INSERT INTO investment_type (name, description) 
	VALUES ('LCA', 'Letra de Crédito do Agronegócio');

INSERT INTO investment_type (name, description) 
	VALUES ('Fundo de Investimento', 'Fundo de Investimento');

INSERT INTO investment_type (name, description) 
	VALUES ('FII', 'Fundo de Investimento Imobiliário');

INSERT INTO investment_type (name, description) 
	VALUES ('Ações', 'Ações de Empresas - Valores Mobiliários de Renda Variável');

INSERT INTO investment_type (name, description) 
	VALUES ('Criptomoedas', 'Ativos Digitais / Criptoativos');

INSERT INTO investment_type (name, description) 
	VALUES ('Previdência Privada', 'Plano de Previdência Complementar Privada');
