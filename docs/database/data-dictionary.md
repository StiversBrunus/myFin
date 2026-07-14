# data-dictionary

# Dicionário de Dados

# WALLET

| Field       | Description                             |
|-------------|-----------------------------------------|
| id          | Identificador único da Wallet           |
| name        | Nome da Wallet                          |
| description | Descrição da Wallet                     |
| created_at  | Data de criação do registro             |
| status      | Situação da Wallet (ACTIVE ou INACTIVE) |

### Constraints

- PRIMARY KEY: `id`
- UNIQUE: `name`

---

# RESERVE

| Field       | Description                          |
|-------------|--------------------------------------|
| id          | Identificador único da Reserve       |
| wallet_id   | Identificador da Wallet proprietária |
| name        | Nome da Reserve                      |
| description | Descrição da Reserve                 |
| created_at  | Data de criação do registro          |
| status      | Situação da Reserve                  |

### Constraints

- PRIMARY KEY: `id`
- FOREIGN KEY: `wallet_id` → `wallet(id)`
- UNIQUE: (`wallet_id`, `name`)

---

# GOAL

| Field          | Description                                         |
|----------------|-----------------------------------------------------|
| id             | Identificador único do Goal                         |
| reserve_id     | Identificador da Reserve proprietária               |
| name           | Nome do Goal                                        |
| description    | Descrição do Goal                                   |
| initial_amount | Valor inicial já existente para o objetivo          |
| target_amount  | Valor financeiro total que o usuário deseja atingir |
| priority       | Prioridade do objetivo                              |
| target_date    | Data limite para atingir o objetivo                 |
| created_at     | Data de criação do registro                         |
| status         | Situação do Goal                                    |

### Constraints

- PRIMARY KEY: `id`
- FOREIGN KEY: `reserve_id` → `reserve(id)`
- UNIQUE: (`reserve_id`, `name`)
- CHECK:
  - `priority IN (1, 2, 3)`
  - `initial_amount >= 0`
  - `target_amount > 0`

---

# INVESTMENT_TRANSACTION

| Field            | Description                                          |
|------------------|------------------------------------------------------|
| id               | Identificador único da transação                     |
| goal_id          | Identificador do Goal relacionado                    |
| investment_id    | Identificador do Investimento utilizado              |
| transaction_date | Data em que a movimentação financeira ocorreu        |
| transaction_type | Tipo da movimentação financeira                      |
| amount           | Valor da movimentação                                |
| description      | Descrição da movimentação                            |
| note             | Observações adicionais                               |
| created_at       | Data em que a movimentação foi registrada no sistema |

### Constraints

- PRIMARY KEY: `id`
- FOREIGN KEY: `goal_id` → `goal(id)`
- FOREIGN KEY: `investment_id` → `investment(id)`
- CHECK:
  - `transaction_type IN (1, 2, 3, 4)`
  - `amount > 0`

---

# INVESTMENT

| Field              | Description                           |
|--------------------|---------------------------------------|
| id                 | Identificador único do Investimento   |
| bank_id            | Identificador do Banco                |
| investment_type_id | Identificador do Tipo de Investimento |
| name               | Nome do Investimento                  |
| description        | Descrição do Investimento             |
| created_at         | Data de criação do registro           |
| status             | Situação do Investimento              |

### Constraints

- PRIMARY KEY: `id`
- FOREIGN KEY: `bank_id` → `bank(id)`
- FOREIGN KEY: `investment_type_id` → `investment_type(id)`

---

# BANK

| Field       | Description                  |
|-------------|------------------------------|
| id          | Identificador único do Banco |
| name        | Nome do Banco                |
| description | Descrição do Banco           |
| created_at  | Data de criação do registro  |
| status      | Situação do Banco            |

### Constraints

- PRIMARY KEY: `id`
- UNIQUE: `name`

---

# INVESTMENT_TYPE

| Field       | Description                                 |
|-------------|---------------------------------------------|
| id          | Identificador único do Tipo de Investimento |
| name        | Nome do Tipo de Investimento                |
| description | Descrição do Tipo de Investimento           |
| created_at  | Data de criação do registro                 |
| status      | Situação do Tipo de Investimento            |

### Constraints

- PRIMARY KEY: `id`
- UNIQUE: `name`

---

# Status

| Value | Description |
|-------|-------------|
| 0     | INACTIVE    |
| 1     | ACTIVE      |

---

# Priority

| Value | Description |
|-------|-------------|
| 1     | LOW         |
| 2     | MEDIUM      |
| 3     | HIGH        |

---

# Transaction Type

| Value | Description |
|-------|-------------|
| 1     | DEPOSIT     |
| 2     | WITHDRAWAL  |
| 3     | EARNINGS    |
| 4     | ADJUSTMENT  |

---

# Relacionamentos

```
CARTEIRA (1) --------< (N) RESERVAS

RESERVA (1) ---------< (N) OBJETIVOS

OBJETIVO (1) --------< (N) MOVIMENTAÇÕES

INVESTIMENTO (1) ----< (N) MOVIMENTAÇÕES

BANCO (1) -----------< (N) INVESTIMENTOS

TIPO DE INVESTIMENTO (1) ----< (N) INVESTIMENTOS
```

---

# Relationships

```
WALLET (1) --------< (N) RESERVE

RESERVE (1) -------< (N) GOAL

GOAL (1) ----------< (N) INVESTMENT_TRANSACTION

INVESTMENT (1) ----< (N) INVESTMENT_TRANSACTION

BANK (1) ----------< (N) INVESTMENT

INVESTMENT_TYPE (1) ----< (N) INVESTMENT
```

---

```
      WALLET
        |
        | 1:N
        v
      RESERVE
        |
        | 1:N
        v
       GOAL
        |
        | 1:N
        v
INVESTMENT_TRANSACTION
        ^
        |
        | N:1
        |
    INVESTMENT
      /      \
     /        \
  N:1          N:1
   /            \
BANK      INVESTMENT_TYPE
```

---

# WALLET

Um usuário pode possuir várias carteiras de gestão patrimonial.

Exemplos:

- Gestão de Finanças Pessoais
- Gestão Patrimonial Empresarial
- Gestão Patrimonial Familiar
- Gestão Patrimonial Pessoal

Cada Wallet é composta, inicialmente, por quatro Reservas.

---

# RESERVE

Uma Reserva pertence obrigatoriamente a uma Wallet.

Exemplos:

- Reserva de Emergência
- Reserva de Patrimônio
- Reserva de Oportunidades
- Reserva de Aposentadoria

Cada Reserva possui nome, descrição e status.

---

# GOAL

Um Goal representa um objetivo financeiro pertencente a uma Reserva.

Exemplos:

**Objetivo:** Construir Reserva de Emergência

**Reserva:** Reserva de Emergência

**Objetivo:** Manutenção do Carro

**Reserva:** Reserva de Emergência

**Objetivo:** Comprar um Apartamento

**Reserva:** Reserva de Patrimônio

**Objetivo:** Comprar um Pet Shop

**Reserva:** Reserva de Oportunidades

### initial_amount

Representa o valor que o usuário já possui no momento da criação do objetivo.

Exemplo:

Objetivo: Comprar uma casa de R$ 500.000,00

Valor já disponível: R$ 30.000,00

```
initial_amount = 30000.00
target_amount = 500000.00
```

O progresso do objetivo será calculado considerando o valor inicial somado às movimentações registradas.

### target_amount

Valor total que o usuário deseja atingir.

### target_date

Data limite para alcançar o objetivo.

---

# INVESTMENT_TRANSACTION

Representa todas as movimentações financeiras registradas para um determinado objetivo.

### amount

Valor da movimentação.

### note

Observações adicionais.

### transaction_date

Data em que o evento financeiro realmente ocorreu.

Ela pode ser diferente de `created_at`, pois o usuário pode registrar hoje uma movimentação realizada dias ou semanas atrás.

### Observação

O nome da tabela foi definido como `investment_transaction`, pois `transaction` é uma palavra reservada em diversos bancos de dados.

---

# INVESTMENT

Representa um investimento financeiro.

Cada Investimento pertence a um Banco e a um Tipo de Investimento.

Exemplos:

- Tesouro Selic
- CDB Liquidez Diária
- Fundo Imobiliário XPML11
- Ação PETR4

---

# BANK

Representa a instituição financeira onde o investimento está aplicado.

Exemplos:

- Nubank
- Inter
- Itaú
- BTG Pactual
- XP Investimentos

---

# INVESTMENT_TYPE

Representa a categoria do investimento.

Exemplos:

- CDB
- Tesouro Direto
- Ações
- Fundos Imobiliários
- ETF
- Criptomoedas

---

# Observações

As entidades abaixo **não armazenam saldo** no banco de dados:

- Wallet
- Reserve
- Goal
- Investment
- Bank
- Investment Type

Todos os saldos deverão ser calculados dinamicamente através das movimentações financeiras (`investment_transaction`).

---

# ENUMS

## status

```
0 = INACTIVE
1 = ACTIVE
```

---

## priority

```
1 = LOW
2 = MEDIUM
3 = HIGH
```

---

## transaction_type

```
1 = DEPOSIT
2 = WITHDRAWAL
3 = EARNINGS
4 = ADJUSTMENT
```