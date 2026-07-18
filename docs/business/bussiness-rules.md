# Business Rules

## Regras de Negócio

### Relacionamentos

RN000 - Uma Usuário pode possuir várias Carteiras.

RN001 - Uma Carteira pode possuir várias Reservas.

RN002 - Uma Reserva pertence obrigatoriamente a uma Carteira.

RN003 - Uma Reserva pode possuir vários Objetivos.

RN004 - Um Objetivo pertence obrigatoriamente a uma Reserva.

RN005 - Um Objetivo pode possuir várias Movimentações.

RN006 - Uma Movimentação pertence obrigatoriamente a um Objetivo.

RN007 - Uma Movimentação deve possuir um Investimento.

RN008 - Um Investimento pode ser utilizado em várias Movimentações.

RN009 - Um Investimento deve possuir um Banco.

RN010 - Um Banco pode ser utilizado em vários Investimentos.

RN011 - Um Investimento deve possuir um Tipo de Investimento.

RN012 - Um Tipo de Investimento pode ser utilizado em vários Investimentos.

---

### Exclusão de Registros

RN013 - Uma Carteira somente pode ser removida caso não possua Reservas associadas.

RN014 - Uma Reserva somente pode ser removida caso não possua Objetivos associados.

RN015 - Um Objetivo somente pode ser removido caso não possua Movimentações associadas.

RN016 - Um Banco somente pode ser removido caso não possua Investimentos associados.

RN017 - Um Tipo de Investimento somente pode ser removido caso não possua Investimentos associados.

RN018 - Um Investimento somente pode ser removido caso não possua Movimentações associadas.

---

### Cálculo de Saldo

RN019 - Uma Carteira não armazena saldo.

RN020 - O saldo de uma Carteira deve ser calculado através das suas Reservas, dos seus respectivos Objetivos e das suas respectivas Movimentações.

RN021 - Uma Reserva não armazena saldo.

RN022 - O saldo de uma Reserva deve ser calculado através dos seus Objetivos e das suas respectivas Movimentações.

RN023 - Um Objetivo não armazena saldo.

RN024 - O saldo de um Objetivo deve ser calculado através das suas Movimentações (`investment_transaction`).

RN025 - Um Investimento não armazena saldo.

RN026 - Um Tipo de Investimento não armazena saldo.

RN027 - Um Banco não armazena saldo.