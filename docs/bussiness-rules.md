# bussiness-rules

# Regras de Negócio

RN001 - Uma Carteira pode possuir várias Reservas.

RN002 - Uma Reserva pertence obrigatoriamente a uma Carteira.

RN003 - Uma Reserva pode possuir vários Objetivos.

RN004 - Um Objetivo pertence obrigatoriamente a uma Reserva.

RN005 - Um Objetivo pode possuir várias Movimentações.

RN006 - Uma Movimentação pertence obrigatoriamente a um Objetivo.

RN007 - Uma Movimentação deve possuir um Tipo de Investimento.

RN008 - Um Tipo de Investimento pode ser utilizado em várias Movimentações.

RN009 - Uma Carteira somente pode ser removida caso não possua reservas associadas. 

RN010 - Uma Reserva somente pode ser removida caso não possua Objetivos associados.

RN011 - Uma Objetivo somente pode ser removida caso não possua Movimentação associadas. 

RN012 - Uma Carteira não armazena saldo.

RN013 - O saldo de uma Carteira deve ser calculado através das suas Reservas dos seus respectivos objetivos e dos das suas respectivas movimentações (investment_type + goal + reserve).

RN014 - Uma Reserva não armazena saldo.

RN015 - O saldo de uma Reserva deve ser calculado através das suas Movimentação dos seus respectivos objetivos (investment_type + goal).

RN016 - Um Objetivo não armazena saldo.

RN017 - O saldo de um Objetivo deve ser calculado através das suas Movimentação (investment_type).

RN018 - O campo status deve aceitar apenas os valores:
    0 = INACTIVE
    1 = ACTIVE
Armazenando apenas os valores 0 e 1.

RN019 - O campo priority deve aceitar apenas os valores:
    1 = LOW
    2 = MEDIUM
    3 = HIGH
Armazenando apenas os valores 1, 2 e 3.

RN020 - O campo transaction_type deve aceitar apenas os valores:
    1 = DEPOSIT
    2 = WITHDRAWAL
    3 = EARNINGS
    4 = ADJUSTMENT

RN021 - O valor de uma transação (investiment_transaction) deve ser maior que zero? (Não sei, e quando eu for resgatar?)

RN022 - O valor da meta (target_amount) deve ser maior ou igual a zero.

RN023 - O valor inicial (initial_amount) deve ser maior ou igual a zero.

RN024 - A data da transação representa a data real do evento financeiro e pode ser diferente da data em que o registro foi inserido no sistema.


