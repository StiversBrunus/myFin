# data-dictionary

# Dicionário de Dados

# CARTEIRA (WALLET):

# RESERVA (RESERVE):

# OBJETIVO (GOAL):

initial_amount (valor inicial):
target_amount (valor da meta):
date_target (Data Limite):


# MOVIMENTAÇÃO (INVESTIMENT_TRANSACTION):

amount (Valor):
note (observação):
transaction_date (Data da Transação):

Data da transação é diferente da data de criação.
Eu posso estar registrando uma transação hoje, que eu fiz a uma semana atrás.

OBSERVAÇÃO: 
O NOME DA TABELA "INVESTIMENT_TRANSCATION", ORIGINALMENTE ERA PARA SER "TRANSACTION", PORÉM É UMA PALAVRA RESERVADA DOS BANCOS DE DADOS, COM ISTO A TABELA FOI ALTERADA PARA ESTE NOME.

# TIPO DE INVESTIMENTO (INVESTIMENT_TYPE):
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

