# bussiness-rules

# Regras de Negócio

RN001 - Uma Carteira pode possuir várias Reservas.

RN002 - Uma Reserva pertence obrigatoriamente a uma Carteira.

RN003 - Uma Reserva pode possuir vários Objetivos.

RN004 - Um Objetivo pertence obrigatoriamente a uma Reserva.

RN005 - Um Objetivo pode possuir várias Movimentações.

RN006 - Uma Movimentação pertence obrigatoriamente a um Objetivo.

RN007 - Uma Movimentação deve possuir um Investimento.

RN008 - Um Investimento pode ser utilizado em várias Movimentações.

RN009 - Um Investimento deve possuir um banco.

RN010 - Um Banco pode ser utilizado em várias Investimentos.

RN011 - Um Investimento deve possuir um Tipo de Investimento.

RN012 - Um Tipo de Investimento pode ser utilizado em várias Investimentos.

RN013 - Uma Carteira somente pode ser removida caso não possua reservas associadas. 

RN014 - Uma Reserva somente pode ser removida caso não possua Objetivos associados.

RN015 - Uma Objetivo somente pode ser removida caso não possua Movimentação associadas. 

RN016 - Uma Movimentação somente pode ser removida caso não possua Investimentos associadas. 

RN017 - Uma Investimento somente pode ser removida caso não possua Tipo de Investimento associadas. 

RN018 - Uma Investimento somente pode ser removida caso não possua um Banco associadas. 

RN019 - Uma Carteira não armazena saldo.

RN020 - O saldo de uma Carteira deve ser calculado através das suas Reservas dos seus respectivos objetivos e dos das suas respectivas movimentações (investment_type + goal + reserve).

RN021 - Uma Reserva não armazena saldo.

RN022 - O saldo de uma Reserva deve ser calculado através das suas Movimentação dos seus respectivos objetivos (investment_type + goal).

RN023 - Um Objetivo não armazena saldo.

RN024 - O saldo de um Objetivo deve ser calculado através das suas Movimentação (investment_transaction).

RN025 - Um Investimento não armazena saldo.

RN026 - Um Tipo de Investimento não armazena saldo.

RN027 - Um Banco não armazena saldo.

RN028 - O campo status deve aceitar apenas os valores:
    0 = INACTIVE
    1 = ACTIVE
Armazenando apenas os valores 0 e 1.

RN029 - O campo priority deve aceitar apenas os valores:
    1 = LOW
    2 = MEDIUM
    3 = HIGH
Armazenando apenas os valores 1, 2 e 3.

RN030 - O campo transaction_type deve aceitar apenas os valores:
    1 = DEPOSIT
    2 = WITHDRAWAL
    3 = EARNINGS
    4 = ADJUSTMENT

RN031 - O valor de uma transação (investiment_transaction) deve ser maior que zero? (Não sei, e quando eu for resgatar?)

RN032 - O valor da meta (target_amount) deve ser maior ou igual a zero.

RN033 - O valor inicial (initial_amount) deve ser maior ou igual a zero.

RN034 - A data da transação representa a data real do evento financeiro e pode ser diferente da data em que o registro foi inserido no sistema.


