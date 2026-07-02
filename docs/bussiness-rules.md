# bussiness-rules

# Regras de Negócio

RN001 - Uma Carteira pode possuir várias Reservas.

RN002 - Uma Reserva pertence a apenas uma Carteira.

RN003 - Uma Reserva pode possuir vários Objetivos.

RN004 - Um Objetivo pertence a apenas uma Reserva.

RN005 - Um Objetivo pode possuir várias Movimentações.

RN006 - Uma Movimentação pertence a apenas um Objetivo.

RN007 - Uma Movimentação deve possuir um Tipo de Investimento.

RN008 - Carteira não armazena saldo.

RN009 - Reserva não armazena saldo.

RN010 - Objetivo não armazena saldo.

RN011 - O saldo é calculado a partir das movimentações.

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