# data-dictionary

# Dicionário de Dados

# WALLET

| Field       | Description                             |
| ----------- | --------------------------------------- |
| id          | Identificador único da Wallet           |
| name        | Nome da Wallet                          |
| description | Descrição da Wallet                     |
| created_at  | Data de criação do registro             |
| status      | Situação da Wallet (ACTIVE ou INACTIVE) |

---

# RESERVE

| Field       | Description                          |
| ----------- | ------------------------------------ |
| id          | Identificador único da Reserve       |
| wallet_id   | Identificador da Wallet proprietária |
| name        | Nome da Reserve                      |
| description | Descrição da Reserve                 |
| created_at  | Data de criação do registro          |
| status      | Situação da Reserve                  |

---

# GOAL

| Field          | Description                                   |
| -------------- | --------------------------------------------- |
| id             | Identificador único do Goal                   |
| reserve_id     | Identificador da Reserve proprietária         |
| name           | Nome do Goal                                  |
| description    | Descrição do Goal                             |
| initial_amount | Valor inicial já existente para o objetivo    |
| target_amount  | Valor financeiro que o usuário deseja atingir |
| priority       | Prioridade do objetivo                        |
| target_date    | Data limite para atingir o objetivo           |
| created_at     | Data de criação do registro                   |
| status         | Situação do Goal                              |

---

# INVESTMENT_TYPE

| Field       | Description                                 |
| ----------- | ------------------------------------------- |
| id          | Identificador único do tipo de investimento |
| name        | Nome do tipo de investimento                |
| description | Descrição do tipo de investimento           |

---

# INVESTMENT_TRANSACTION

| Field              | Description                                     |
| ------------------ | ----------------------------------------------- |
| id                 | Identificador único da transação                |
| goal_id            | Identificador do Goal relacionado               |
| investment_type_id | Identificador do tipo de investimento utilizado |
| transaction_date   | Data em que a movimentação financeira ocorreu   |
| transaction_type   | Tipo da movimentação financeira                 |
| amount             | Valor da movimentação                           |
| description        | Descrição da movimentação                       |
| notes              | Observações adicionais                          |

---

# Status

| Value | Description |
| ----- | ----------- |
| 0     | INACTIVE    |
| 1     | ACTIVE      |

---

# Priority

| Value | Description |
| ----- | ----------- |
| 1     | LOW         |
| 2     | MEDIUM      |
| 3     | HIGH        |

---

# Transaction Type

| Value | Description |
| ----- | ----------- |
| 1     | DEPOSIT     |
| 2     | WITHDRAWAL  |
| 3     | EARNINGS    |
| 4     | ADJUSTMENT  |

--------------------------------------------------------------
# Relacionamentos:

CARTEIRA (1) --------< (N) RESERVAS

RESERVA (1) -------< (N) OBJETIVOS

OBJETIVO (1) ----------< (N) MOVIMENTAÇÃO

TIPO DE INVESTIMENTO (1) -----< (N) MOVIMENTACAO
--------------------------------------------------------------
# RELATIONSHIPS
WALLET (1) --------< (N) RESERVE

RESERVE (1) -------< (N) GOAL

GOAL (1) ----------< (N) INVESTMENT_TRANSACTION

INVESTMENT_TYPE (1) -----< (N) INVESTMENT_TRANSACTION
--------------------------------------------------------------

# CARTEIRA (WALLET):
Um usuário pode possuir várias carteiras de gestão de patrimônio.
Por exemplo:
Carteira: Gestão de Finanças Pessoais.
Carteira 02: Gestão Patrimonial Empresarial.
Carteira 03: Gestão Patrimonial Familiar.
Carteira 04: Gestão Patrimonial Pessoal.

Dentro de cada carteira, a princípio, é dividido em 4 reservas.

# RESERVA (RESERVE):

Um usuário pode ter várias reservas financeiras, porém, está ligada à uma carteira.
Uma reserva financeira possui, a carteira pela qual ela pertence, um nome, descrição e o estado dela, se está ativo ou não.

Exemplo:
Reserva de Emergência:
Reserva de Patrimônio:
Reserva de Oportunidades:
Reserva de Aposentadoria:

# OBJETIVO (GOAL):

Um usuário pode ter vários objetivos/metas financeiras, porém estes objetivos estão relacionado à uma reserva financeira.
Porque todo objetivo financeiro que uma pessoa tem, está contido dentro de uma reserva.

Por exemplo:
Objetivo financeiro: "Construir minha reserva financeira". 
Qual reserva? "Reserva de Emergência".

Objetivo financeiro: "Manutenção do carro"
Qual reserva? "Reserva de Emergência".

Objetivo financeiro: "Comprar um apartamento"
Qual reserva? "Reserva de Patrimônio".

Objetivo financeiro: "Comprar um PetShop"
Qual reserva? "Reserva de Oportunidades".

initial_amount (valor inicial):
Este campo é o valor incial, imagina que voce cria um objetivo; "Comprar uma casa de 500 mil", porém, voce já tem 30.000,00 mil.
Coloca o valor inicial.
O valor meta altera sendo 500 mil menos os 30.000,00 que você já tem.

target_amount (valor da meta):
Valor meta é o valor do objetivo.

date_target (Data Limite):
Data de vencimento do objetivo.
É bom que você já fica ciente de em quanto tempo falta para voce alcançar este objetivo.

# MOVIMENTAÇÃO (INVESTIMENT_TRANSACTION):

amount (Valor):
note (observação):
transaction_date (Data da Transação):

Data da transação é diferente da data de criação.
Eu posso estar registrando uma transação hoje, que eu fiz a uma semana atrás.

OBSERVAÇÃO: 
O NOME DA TABELA "INVESTIMENT_TRANSCATION", ORIGINALMENTE ERA PARA SER "TRANSACTION", PORÉM É UMA PALAVRA RESERVADA DOS BANCOS DE DADOS, COM ISTO A TABELA FOI ALTERADA PARA ESTE NOME.

# TIPO DE INVESTIMENTO (INVESTIMENT_TYPE):
nome e descrição do tipo de investimento.
--------------------------------------------------------------

# ENUMS

# status
0 = INACTIVE (INATIVO)
1 = ACTIVE (ATIVO)
-----------------------------
# priority
1 = LOW (BAIXO)
2 = MEDIUM (MÉDIO)
3 = HIGH (ALTO)
-----------------------------
# TransactionType
1 = DEPOSIT (APORTE)
2 = WITHDRAWAL (RESGATE)
3 = EARNINGS (RENTABILIDADE)
4 = ADJUSTMENT (AJUSTE)

