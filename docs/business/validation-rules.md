# Validation Rules

## Regras de Validação

### Campos Enumerados

RNV001 - O campo `status` deve aceitar apenas os seguintes valores:
- 0 = INACTIVE
- 1 = ACTIVE

RNV002 - O campo `priority` deve aceitar apenas os seguintes valores:
- 1 = LOW
- 2 = MEDIUM
- 3 = HIGH

RNV003 - O campo `transaction_type` deve aceitar apenas os seguintes valores:
- 1 = DEPOSIT
- 2 = WITHDRAWAL
- 3 = EARNINGS
- 4 = ADJUSTMENT

---

### Validação de Valores

RNV004 - O valor da Movimentação (`investment_transaction.amount`) deve ser maior que zero.

RNV005 - O valor da Meta (`target_amount`) deve ser maior que zero.

RNV006 - O valor Inicial (`initial_amount`) deve ser maior ou igual a zero.

---

### Datas

RNV007 - A data da transação representa a data real do evento financeiro e pode ser diferente da data em que o registro foi inserido no sistema.

---

### Unicidade

RNV008 - O nome da Carteira deve ser único no sistema.

RNV009 - O nome de uma Reserva deve ser único dentro da mesma Carteira.
É permitido que Carteiras diferentes possuam Reservas com o mesmo nome.

RNV010 - O nome de um Objetivo deve ser único dentro da mesma Reserva.
É permitido que Reservas diferentes possuam Objetivos com o mesmo nome.

RNV011 - O nome do Banco deve ser único no sistema.

RNV012 - O nome do Tipo de Investimento deve ser único no sistema.