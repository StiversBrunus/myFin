--------------------------------------------------
-- CARTEIRAS
--------------------------------------------------

INSERT INTO wallet (name, description)
VALUES 
('Patrimônio Pessoal', 'Minha carteira de patrimônio pessoal.');

INSERT INTO wallet (name, description)
VALUES 
('Patrimônio Empresarial', 'Minha carteira de patrimônio empresarial.');

INSERT INTO wallet (name, description)
VALUES 
('Patrimônio Familiar', 'Minha carteira de patrimônio familiar.');

--------------------------------------------------
-- RESERVAS
--------------------------------------------------
--------------------------------------------------
-- RESERVAS PESSOAL
--------------------------------------------------
INSERT INTO reserve (wallet_id,name,
	description)
	VALUES 
	(1,'Reserva de Emergência',
	'Garantir segurança financeira diante de imprevistos pessoais e perda de renda. Exemplos: Desemprego, problemas de saúde, despesas inesperadas, manutenção de casa ou veículo.');

INSERT INTO reserve (wallet_id, name,
	description)
	VALUES 
	(1,'Reserva de Oportunidade',
	'Manter recursos disponíveis para aproveitar oportunidades financeiras ou pessoais. Exemplos: Comprar investimentos em momentos favoráveis, aproveitar promoções, cursos, negócios.');

INSERT INTO reserve (wallet_id, name,
	description)
	VALUES 
	(1,'Reserva de Patrimônio',
	'Construir patrimônio e realizar objetivos pessoais de médio e longo prazo. Exemplos: Compra de imóvel, carro, viagens, casamento, estudos, aquisição de bens.');

INSERT INTO reserve (wallet_id, name,
	description)
	VALUES 
	(1,'Reserva de Aposentadoria',
	'Construir independência financeira e segurança para o futuro. Exemplo: Previdência privada, investimentos de longo prazo, renda passiva.');

--------------------------------------------------
-- RESERVAS EMPRESARIAL
--------------------------------------------------
INSERT INTO reserve (wallet_id, name, 
	description)
	VALUES 
	(2, 'Reserva Operacional',
	'Garantir o funcionamento da empresa durante períodos de baixa receita. Exemplos: Folha de pagamento, fornecedores, aluguel, impostos, despesas fixas.');

INSERT INTO reserve (wallet_id, name, 
	description)
	VALUES 
	(2, 'Reserva de Expansão','Financiar crescimento e novas oportunidades do negócio. Exemplos: Compra de equipamentos, abertura de filial, contratação de funcionários, novos projetos.');

INSERT INTO reserve (wallet_id, name, 
	description)
	VALUES 
	(2, 'Reserva de Investimento','Aplicar recursos para aumentar a capacidade e competitividade da empresa. Exemplos: Tecnologia, marketing, máquinas, melhorias estruturais.');

INSERT INTO reserve (wallet_id, name, 
	description)
	VALUES 
	(2, 'Reserva Tributária','Separar recursos para obrigações fiscais e financeiras futuras. Exemplos: Impostos, taxas, encargos trabalhistas, obrigações legais.');

--------------------------------------------------
-- RESERVAS FAMILIAR
--------------------------------------------------

INSERT INTO reserve (wallet_id, name, 
	description)
	VALUES 
	(3, 'Reserva Familiar de Emergência',
	'Proteger a família contra eventos inesperados e manter o padrão de vida. Exemplos: Desemprego de um membro da família, despesas médicas, reformas urgentes, manutenção de veículos.');

INSERT INTO reserve (wallet_id, name, 
	description)
	VALUES 
	(3, 'Reserva de Projetos Familiares','Planejar grandes objetivos compartilhados pela família. Exemplos: Viagens em família, casamento dos filhos, compra de imóvel, mudança de residência.');

INSERT INTO reserve (wallet_id, name, 
	description)
	VALUES 
	(3, 'Reserva Patrimonial Familiar','Construir e preservar patrimônio para as próximas gerações. Exemplos: Imóveis, investimentos, aquisição de bens, herança familiar.');

INSERT INTO reserve (wallet_id, name, 
	description)
	VALUES 
	(3, 'Reserva Educacional','Garantir recursos para formação e desenvolvimento dos membros da família. Exemplos: Faculdade dos filhos, cursos, especializações, intercâmbios.');

-- =====================================================
-- OBJETIVO PESSOAL
-- =====================================================

INSERT INTO goal (reserve_id, name,
    description,
    initial_amount, target_amount, target_date, priority
)
	VALUES
	(1, 'Fundo de Emergência',
	'Formar uma reserva equivalente a 6 meses das despesas mensais.',
	0.00, 30000.00, '2026-01-01', 1),

	(1, 'Manutenção da Casa',
	'Reservar recursos para reparos e manutenções inesperadas da residência.',
	0.00, 5000.00, '2026-01-01', 2),

	(1, 'Manutenção do Veículo',
	'Reservar recursos para manutenção preventiva e corretiva do veículo.',
	0.00, 3000.00, '2026-01-01', 2),

	(2, 'Comprar Ações',
	'Aproveitar oportunidades de compra no mercado de ações.',
	0.00, 10000.00, '2026-01-01', 2),

	(2, 'Novo Negócio',
	'Ter capital disponível para iniciar ou participar de um novo negócio.',
	0.00, 50000.00, '2026-01-01', 3),

	(2, 'Promoções Estratégicas',
	'Aproveitar promoções ou compras planejadas de alto valor.',
	0.00, 5000.00, '2026-01-01', 3),

	(3, 'Entrada do Imóvel',
	'Acumular recursos para a entrada da casa própria.',
	0.00, 100000.00, '2026-01-01', 1),

	(3, 'Compra do Veículo',
	'Juntar recursos para aquisição de um veículo.',
	0.00, 60000.00, '2026-01-01', 2),

	(3, 'Viagem Internacional',
	'Financiar uma viagem internacional.',
	0.00, 20000.00, '2026-01-01', 3),

	(4, 'Independência Financeira',
	'Construir patrimônio para gerar renda passiva.',
	0.00, 1500000.00, '2026-01-01', 1),

	(4, 'Previdência Complementar',
	'Complementar a aposentadoria oficial.',
	0.00, 500000.00, '2026-01-01', 2),

	(4, 'Patrimônio de Longo Prazo',
	'Acumular patrimônio para o futuro.',
	0.00, 1000000.00, '2026-01-01', 2);

-- =====================================================
-- OBJETIVO EMPRESARIAL
-- =====================================================

INSERT INTO goal (reserve_id, name,
    description,
    initial_amount, target_amount, target_date, priority
)
	VALUES
	(5, 'Capital de Giro',
	'Garantir recursos para manter as operações da empresa.',
	0.00, 100000.00, '2026-01-01', 1),

	(5, 'Folha Salarial',
	'Reservar recursos para pagamento da folha de pagamento.',
	0.00, 50000.00, '2026-01-01', 1),

	(5, 'Pagamento de Fornecedores',
	'Garantir recursos para pagamento de fornecedores.',
	0.00, 40000.00, '2026-01-01', 2),

	(6, 'Abrir Nova Unidade',
	'Expandir a empresa com uma nova filial.',
	0.00, 500000.00, '2026-01-01', 2),

	(6, 'Contratação de Colaboradores',
	'Reservar recursos para ampliação da equipe.',
	0.00, 80000.00, '2026-01-01', 2),

	(6, 'Expansão Regional',
	'Expandir a atuação da empresa para uma nova região.',
	0.00, 300000.00, '2026-01-01', 3),

	(7, 'Compra de Equipamentos',
	'Modernizar a empresa com novos equipamentos.',
	0.00, 150000.00, '2026-01-01', 2),

	(7, 'Implantação de ERP',
	'Implantar um novo sistema de gestão empresarial.',
	0.00, 100000.00, '2026-01-01', 2),

	(7, 'Modernização da Infraestrutura',
	'Atualizar a infraestrutura física e tecnológica da empresa.',
	0.00, 200000.00, '2026-01-01', 3),

	(8, 'Pagamento de Impostos',
	'Reservar recursos para pagamento de tributos.',
	0.00, 80000.00, '2026-01-01', 1),

	(8, 'Encargos Trabalhistas',
	'Garantir recursos para encargos e obrigações trabalhistas.',
	0.00, 50000.00, '2026-01-01', 1),

	(8, 'Licenças e Taxas',
	'Reservar recursos para renovações e taxas obrigatórias.',
	0.00, 10000.00, '2026-01-01', 2);

-- =====================================================
-- OBJETIVO FAMILIAR 
-- =====================================================

INSERT INTO goal (reserve_id, name,
    description,
    initial_amount, target_amount, target_date, priority
)
	VALUES
	(9, 'Fundo de Emergência Familiar',
	'Proteger a família contra imprevistos financeiros.',
	0.00, 50000.00, '2026-01-01', 1),

	(9, 'Despesas Médicas',
	'Cobrir despesas médicas inesperadas da família.',
	0.00, 20000.00, '2026-01-01', 1),

	(9, 'Reforma da Residência',
	'Reservar recursos para reparos urgentes na residência.',
	0.00, 30000.00, '2026-01-01', 2),

	(10, 'Viagem em Família',
	'Planejar uma viagem para toda a família.',
	0.00, 25000.00, '2026-01-01', 3),

	(10, 'Compra da Casa Própria',
	'Juntar recursos para aquisição da residência da família.',
	0.00, 200000.00, '2026-01-01', 1),

	(10, 'Casamento de um Filho',
	'Planejar financeiramente o casamento de um filho.',
	0.00, 50000.00, '2026-01-01', 3),

	(11, 'Imóvel para Investimento',
	'Adquirir um imóvel para aumentar o patrimônio familiar.',
	0.00, 300000.00, '2026-01-01', 2),

	(11, 'Compra de Chácara',
	'Adquirir uma chácara para lazer e patrimônio.',
	0.00, 250000.00, '2026-01-01', 3),

	(11, 'Patrimônio para Herança',
	'Construir patrimônio para as próximas gerações.',
	0.00, 1000000.00, '2026-01-01', 2),

	(12, 'Faculdade dos Filhos',
	'Garantir recursos para o ensino superior dos filhos.',
	0.00, 150000.00, '2026-01-01', 1),

	(12, 'Curso de Idiomas',
	'Financiar cursos de idiomas para a família.',
	0.00, 30000.00, '2026-01-01', 2),

	(12, 'Intercâmbio Internacional',
	'Planejar um intercâmbio educacional.',
	0.00, 100000.00, '2026-01-01', 3);

--------------------------------------------------
-- INVESTIMENTOS
--------------------------------------------------

INSERT INTO investment (
	bank_id,
	investment_type_id,
	name,
	description)
VALUES (
	1,
	1,
	'Cofrinho BB',
	'Cofrinho - Banco do Brasil - Fundo de Investimentos.');

INSERT INTO investment (
	bank_id,
	investment_type_id,
	name,
	description)
VALUES (
	6,
	3,
	'Caixinha',
	'Caixinha - Nubank - [Colocar o Nome]');
	
INSERT INTO investment (
	bank_id,
	investment_type_id,
	name,
	description)
VALUES (
	7,
	3,
	'Meu Porquinho',
	'Meu Porquinho - Inter');

INSERT INTO investment (
	bank_id,
	investment_type_id,
	name,
	description)
VALUES (
	11,
	3,
	'Cofrinho',
	'Cofrinho - Mercado Pago');

--------------------------------------------------
-- TRANSAÇÕES
--------------------------------------------------

