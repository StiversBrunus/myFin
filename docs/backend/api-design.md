
# CARTEIRAS

## GET: /wallets
    Descrição:
        Retorna todas as carteiras do usuário.
    Regras de negócio relacionadas:
        UC002 - O usuário pode listar todas as Wallets.
        RN000 - Uma Usuário pode possuir várias Carteiras.
        RN019 - Uma Carteira não armazena saldo.
        RN020 - O saldo de uma Carteira deve ser calculado através das suas Reservas, dos seus respectivos Objetivos e das suas respectivas Movimentações.
    Request Body:
        Não Possui.
    Response Body:

    ```[
        {
            "id": 1,
            "name": "Patrimônio Pessoal",
            "description": "Minha carteira de patrimônio pessoal.",
            "status": true,
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 2,
            "name": "Patrimônio Empresarial",
            "description": "Minha carteira de patrimônio empresarial.",
            "status": true,
            "created_at": "2026-07-14 13:02:33"
        }
    ]```

    Filtros:
        nome, status
    Ordenação:
        name, status, created_at.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de Wallets de um usuário.

## GET: /wallets/{id}
    Descrição:
        Retorna uma carteira do usuário.
    Regras de negócio relacionadas:
            UC002 - O usuário pode listar todas as Wallets.
    Request Body:
        Não Possui.
    Response Body:

    ```{
        "id": 1,
        "name": "Patrimônio Pessoal",
        "description": "Minha carteira de patrimônio pessoal.",
        "status": true,
        "created_at": "2026-07-14 13:02:33"
    }```

    Filtros:
        nome, status
    Ordenação:
        name, status, created_at.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        404 Not Found
        500 Internal Server Error
    Observações:
        Retorna apenas uma Wallet de um usuário.

## POST: /wallets
    Descrição:
        Cria uma nova carteira.
    Regras de negócio relacionadas:
            RNV008 - O nome da Carteira deve ser único no sistema.
    Request Body:
    ```{
        "name": "Patrimônio Familiar",
        "description": "Minha carteira de patrimônio familiar."
    }```
    Response Body:

    ```{
        "id": 3,
        "name": "Patrimônio Familiar",
        "description": "Minha carteira de patrimônio familiar.",
        "status": true,
        "created_at": "2026-07-14 13:02:33"
    }```

    Status HTTP possíveis:
        201 Created
        400 Bad Request
        403 Forbidden
        409 Conflict
        500 Internal Server Error
    Observações:
        O nome da carteira deve ser único.
        O campo nome tem limite de 100 caracteres.
        O campo descrição tem limite de 255 caracteres.
        O usuário pode incluir apenas o nome e descrição.
        O campo status será criado como active (true).

## PUT: /wallets/{id}
    Descrição:
        Atualiza os dados de uma carteira existente.
    Regras de negócio relacionadas:
            UC003 - O usuário pode alterar o nome, descrição e status de uma Wallet.
            RNV008 - O nome da Carteira deve ser único no sistema.
    Request Body:
    ```{
        "name": "Capital Familiar",
        "description": "Meu Capital familiar.",
        "status": "false"
    }```
    Response Body:

    ```{
        "id": 3,
        "name": "Capital Familiar",
        "description": "Meu Capital familiar.",
        "status": false,
        "created_at": "2026-07-14 14:10:45"
    }```

    Status HTTP possíveis:
        200 OK
        400 Bad Request
        403 Forbidden
        409 Conflict
        500 Internal Server Error
    Observações:
        Não é permitido alterar o ID, nem a data de criação.

## DELETE: /wallets/{id}
    Descrição:
        Remove uma carteira existente.
    Regras de negócio relacionadas:
            RN013 - Uma Carteira somente pode ser removida caso não possua Reservas associadas.
            UC004 - O usuário pode excluir uma Wallet desde que não existam Reserves associadas.
    Request Body:
        Não possui.
    Response Body:
        Não possui.
    Status HTTP possíveis:
        204 No Content
        403 Forbidden
        404 Not Found
        409 Conflict
        500 Internal Server Error
    Observações:
        Caso existam Reservas vinculadas, a exclusão deverá ser impedida.

# RESERVAS

## GET: /wallet/{walletId}/reserves
    Descrição:
        Lista todas as reservas de uma carteira.
    Regras de negócio relacionadas:
        UC006 - O usuário pode listar as Reserves.
        RN002 - Qualquer Reserva pertence obrigatoriamente a uma Carteira.
    Request Body:
        Não possui.
    Response Body:
    ```[
        {
            "id": 1,
            "wallet_id": 1,
            "name": "Reserva de Emergência",
            "description": "Garantir segurança financeira diante de imprevistos pessoais...",
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 2,
            "wallet_id": 1,
            "name": "Reserva de Oportunidade",
            "description": "Manter recursos disponíveis para aproveitar oportunidades financeiras...",
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 3,
            "wallet_id": 1,
            "name": "Reserva de Patrimônio",
            "description": "Construir patrimônio e realizar objetivos pessoais de médio e longo...",
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        }
    ]```

    Filtros:
        carteira, nome, status
    Ordenação:
        name, status, created_at.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de Reservas de uma Wallet de um usuário.

## GET: /reserves
    Descrição:
        Lista todas as reservas com filtro.
    Regras de negócio relacionadas:
        UC006 - O usuário pode listar as Reserves.
        RN002 - Qualquer Reserva pertence obrigatoriamente a uma Carteira.
    Request Body:
    {
        "wallet_id": "",
        "name": "",
        "status": ""
    }
    Response Body:
    ```[
        {
            "id": 1,
            "wallet_id": 1,
            "name": "Reserva de Emergência",
            "description": "Garantir segurança financeira diante de imprevistos pessoais...",
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 5,
            "wallet_id": 2,
            "name": "Reserva Operacional",
            "description": "Garantir o funcionamento da empresa durante períodos de baixa receita...",
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 9,
            "wallet_id": 3,
            "name": "Reserva Familiar de Emergência",
            "description": "Proteger a família contra eventos inesperados e manter o padrão de vida...",
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        }
    ]```

    Filtros:
        carteira, nome, status
    Ordenação:
        name, status, created_at.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de Reservas de um usuário conforme o filtro.

## GET: /reserves/{id}
    Descrição:
        Retorna uma única reserva do usuário.
    Regras de negócio relacionadas:
            UC006 - O usuário pode listar as Reserves.
    Request Body:
        Não Possui.
    Response Body:

    ```{
        "id": 1,
        "wallet_id": 1,
        "name": "Reserva de Emergência",
        "description": "Garantir segurança financeira diante de imprevistos pessoais...",
        "status": "true",
        "created_at": "2026-07-14 13:02:33"
    }```

    Filtros:
        carteira, nome, status
    Ordenação:
        name, status, created_at.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        404 Not Found
        500 Internal Server Error
    Observações:
        Retorna apenas uma Reserva de um usuário.

## POST: /reserves
    Descrição:
        Cria uma nova reserva.
    Regras de negócio relacionadas:
            UC005 - O usuário pode criar uma Reserve.
            RN002 - Uma Reserva pertence obrigatoriamente a uma Carteira.
            RNV009 - O nome de uma Reserva deve ser único dentro da mesma Carteira. 
            É permitido que Carteiras diferentes possuam Reservas com o mesmo nome.
    Request Body:
    ```{
        "wallet_id": "1",
        "name": "Reserva de Aposentadoria",
        "description": "Construir independência financeira e segurança para o futuro. Exemplo..."
    }```
    Response Body:

    ```{
        "id": 4,
        "wallet_id:" "1",
        "name": "Reserva de Aposentadoria",
        "description": "Construir independência financeira e segurança para o futuro. Exemplo...",
        "status": "true",
        "created_at": "2026-07-14 13:02:33"
    }```

    Status HTTP possíveis:
        201 Created
        400 Bad Request
        403 Forbidden
        409 Conflict
        500 Internal Server Error
    Observações:
        O usuário deve indicar a carteira.
        O nome da reserva deve ser único dentro de uma carteira.
        O campo nome tem limite de 100 caracteres.
        O campo descrição tem limite de 255 caracteres.
        O campo status será criado como active (true).

## PUT: /reserves/{id}
    Descrição:
        Atualiza os dados de uma reserva existente.
    Regras de negócio relacionadas:
            UC007 - O usuário pode alterar o nome, descrição e status de uma Reserve.
            RNV009 - O nome de uma Reserva deve ser único dentro da mesma Carteira. 
            É permitido que Carteiras diferentes possuam Reservas com o mesmo nome.
    Request Body:
    ```{
        "name": "Reserva de Aposentadoria",
        "description": "Construir independência financeira e segurança para o futuro. Exemplo...",
        "status": "false"
    }```
    Response Body:

    ```{
        "id": 4,
        "wallet_id:" "1",
        "name": "Reserva de Aposentadoria",
        "description": "Construir independência financeira e segurança para o futuro. Exemplo...",
        "status": "false",
        "created_at": "2026-07-14 13:02:33"
    }```

    Status HTTP possíveis:
        200 OK
        400 Bad Request
        403 Forbidden
        409 Conflict
        500 Internal Server Error
    Observações:
        Não é permitido alterar o ID, carteira, e data de criação.

## DELETE: /reserves/{id}
    Descrição:
        Remove uma reserva existente.
    Regras de negócio relacionadas:
            RN014 - Uma Reserva somente pode ser removida caso não possua Objetivos associados.
            UC008 - O usuário pode excluir uma Reserve desde que não existam Goals associados.
    Request Body:
        Não possui.
    Response Body:
        Não possui.
    Status HTTP possíveis:
        204 No Content
        403 Forbidden
        404 Not Found
        409 Conflict
        500 Internal Server Error
    Observações:
        Caso existam Objetivos vinculados, a exclusão deverá ser impedida.

# OBJETIVOS

## GET: /goals
    Descrição:
        Lista todos os objetivos com filtro.
    Regras de negócio relacionadas:
        UC010 - O usuário pode listar os Goals.
        RN004 - Um Objetivo pertence obrigatoriamente a uma Reserva.
    Request Body:
    {
        "reserve_id": "",
        "name": "",
        "target_amount": "",
        "target_date": "",
        "priority": ""
        "status": ""
    }
    Response Body:
    ```[
        {
            "id": 1,
            "reserve_id": 1,
            "name": "Fundo de Emergência",
            "description": "Formar uma reserva equivalente a 6 meses das despesas mensais.",
            "initial_amount": 0.00,
            "target_amount": 30000.00,
            "target_date": "2026-01-01",
            "priority": 1,
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 4,
            "reserve_id": 2,
            "name": "Comprar Ações",
            "description": "Aproveitar oportunidades de compra no mercado de ações.",
            "initial_amount": 0.00,
            "target_amount": 10000.00,
            "target_date": "2026-01-01",
            "priority": 2,
            "status": "false",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 7,
            "reserve_id": 3,
            "name": "Entrada do Imóvel",
            "description": "Acumular recursos para a entrada da casa própria.",
            "initial_amount": 0.00,
            "target_amount": 10000.00,
            "target_date": "2026-01-01",
            "priority": 1,
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        }
    ]```

    Filtros:
        reserva, nome, valor meta, data meta, Nível Prioridade, status
    Ordenação:
        reserva, name, valor, data, prioridade, status, created_at.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de Objetivos de um usuário.

## GET: /reserves/{reserveId}/goals
    Descrição:
        Lista todos os objetivos de uma reserva.
    Regras de negócio relacionadas:
        UC010 - O usuário pode listar os Goals.
        RN004 - Um Objetivo pertence obrigatoriamente a uma Reserva.
    Request Body:
        Não possui.
    Response Body:
    ```[
        {
            "id": 1,
            "reserve_id": 1,
            "name": "Fundo de Emergência",
            "description": "Formar uma reserva equivalente a 6 meses das despesas mensais.",
            "initial_amount": 0.00,
            "target_amount": 30000.00,
            "target_date": "2026-01-01",
            "priority": 1,
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 2,
            "reserve_id": 1,
            "name": "Manutenção da Casa",
            "description": "Reservar recursos para reparos e manutenções inesperadas da residência.",
            "initial_amount": 0.00,
            "target_amount": 5000.00,
            "target_date": "2026-01-01",
            "priority": 2,
            "status": "false",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 3,
            "reserve_id": 1,
            "name": "Manutenção do Veículo",
            "description": "Reservar recursos para manutenção preventiva e corretiva do veículo.",
            "initial_amount": 0.00,
            "target_amount": 3000.00,
            "target_date": "2026-01-01",
            "priority": 2,
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        }
    ]```

    Filtros:
        reserva, nome, valor meta, data meta, Nível Prioridade, status
    Ordenação:
        reserva, name, valor, data, prioridade, status, created_at.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de Objetivos de uma Reserva de um usuário.

## GET: /goals/{id}
    Descrição:
        Retorna um único objetivo do usuário.
    Regras de negócio relacionadas:
            UC010 - O usuário pode listar os Goals.
    Request Body:
        Não Possui.
    Response Body:

    ```{
        "id": 9,
        "reserve_id": 3,
        "name": "Viagem Internacional",
        "description": "Financiar uma viagem internacional.",
        "initial_amount": 0.00,
        "target_amount": 20000.00,
        "target_date": "2026-01-01",
        "priority": 3,
        "status": "true",
        "created_at": "2026-07-14 13:02:33"
    }```

    Filtros:
        reserva, nome, valor meta, data meta, Nível Prioridade, status
    Ordenação:
        reserva, name, valor, data, prioridade, status, created_at.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        404 Not Found
        500 Internal Server Error
    Observações:
        Retorna apenas um Objetivo de um usuário.

## POST: /goals
    Descrição:
        Cria um novo objetivo.
    Regras de negócio relacionadas:
            UC009 - O usuário pode criar um Goal.
            RN004 - Um Objetivo pertence obrigatoriamente a uma Reserva.
            RNV010 - O nome de um Objetivo deve ser único dentro da mesma Reserva.
            É permitido que Reservas diferentes possuam Objetivos com o mesmo nome.
    Request Body:
    ```{
        "reserve_id": 13,
        "name": "Capital de Giro",
        "description": "Garantir recursos para manter as operações da empresa.",
        "initial_amount": 0.00,
        "target_amount": 100000.00,
        "target_date": "2026-01-01",
        "priority": 1,
    }```
    Response Body:

    ```{
        "id": 13,
        "reserve_id": 5,
        "name": "Capital de Giro",
        "description": "Garantir recursos para manter as operações da empresa.",
        "initial_amount": 0.00,
        "target_amount": 100000.00,
        "target_date": "2026-01-01",
        "priority": 1,
        "status": "true",
        "created_at": "2026-07-14 13:02:33"
    }```

    Status HTTP possíveis:
        201 Created
        400 Bad Request
        403 Forbidden
        409 Conflict
        500 Internal Server Error
    Observações:
        O usuário deve indicar a reserva.
        O nome do Objetivo deve ser único dentro de uma reserva.
        O campo nome tem limite de 100 caracteres.
        O campo descrição tem limite de 255 caracteres.
        O campo status será criado como active (true).

## PUT: /goals/{id}
    Descrição:
        Atualiza os dados de um objetivo existente.
    Regras de negócio relacionadas:
            UC011 - O usuário pode alterar...
            RNV010 - O nome de um Objetivo deve ser único dentro da mesma Reserva.
            É permitido que Reservas diferentes possuam Objetivos com o mesmo nome.
    Request Body:
    ```{
        "name": "Capital de Giro",
        "description": "Garantir recursos para manter as operações da empresa.",
        "initial_amount": 0.00,
        "target_amount": 100000.00,
        "target_date": "2026-01-01",
        "priority": 1,
        "status": "false"
    }```
    Response Body:

    ```{
        "id": 13,
        "reserve_id": 5,
        "name": "Capital de Giro",
        "description": "Garantir recursos para manter as operações da empresa.",
        "initial_amount": 0.00,
        "target_amount": 100000.00,
        "target_date": "2026-01-01",
        "priority": 1,
        "status": "false",
        "created_at": "2026-07-14 13:02:33"
    }```

    Status HTTP possíveis:
        200 OK
        400 Bad Request
        403 Forbidden
        409 Conflict
        500 Internal Server Error
    Observações:
        Não é permitido alterar o ID, reserva, e data de criação.


## DELETE: /goals/{id}
    Descrição:
        Remove um objetivo existente.
    Regras de negócio relacionadas:
            RN015 - Um Objetivo somente pode ser removido caso não possua Movimentações associadas.
            UC012 - O usuário pode excluir um Goal desde que não existam Investment Transactions associadas.
    Request Body:
        Não possui.
    Response Body:
        Não possui.
    Status HTTP possíveis:
        204 No Content
        403 Forbidden
        404 Not Found
        409 Conflict
        500 Internal Server Error
    Observações:
        Caso existam Transações vinculados, a exclusão deverá ser impedida.

# BANCOS

## GET: /banks
    Descrição:
        Lista todos os bancos com filtro.
    Regras de negócio relacionadas:
        UC021 - O usuário pode listar os bancos.
        RN016 - Um Banco não pode ser removido.
    Request Body:
    {
        "name": "",
        "description": ""
    }
    Response Body:
    ```[
        {
            "id": 1,
            "name": "Banco do Brasil",
            "description": "Banco do Brasil S.A",
            "status": "true"
        },
        {
            "id": 2,
            "name": "Caixa Econômica Federal",
            "description": "Caixa Econômica Federal",
            "status": "true"
        },
        {
            "id": 3,
            "name": "Bradesco",
            "description": "Banco Bradesco S.A",
            "status": "true"
        }
    ]```

    Filtros:
        nome, status
    Ordenação:
        name, status.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de bancos conforme o filtro.

## GET: /banks/{id}
    Descrição:
        Lista todos os bancos com filtro.
    Regras de negócio relacionadas:
        UC021 - O usuário pode listar os bancos.
        RN016 - Um Banco não pode ser removido.
    Request Body:
        Não Possui.
    Response Body:
    ```{
            "id": 1,
            "name": "Banco do Brasil",
            "description": "Banco do Brasil S.A",
            "status": "true"
        }```

    Filtros:
        Nenhum
    Ordenação:
        Nenhum.
    Paginação:
        Nenhum.
    Status HTTP possíveis:
        200 OK
        404 Not Found
        500 Internal Server Error
    Observações:
        Retorna apenas um banco.

# TIPOS DE INVESTIMENTOS

## GET: /investment-types
    Descrição:
        Lista todos os tipos de investimentos com filtro.
    Regras de negócio relacionadas:
        UC024 - O usuário pode listar os tipos de investimento.
        UC023 - O usuário não pode cadastrar um tipo de investimento.
        UC025 - O usuário não pode alterar um tipo de investimento.
        UC026 - O usuário não pode excluir um tipo de investimento.
        RNV012 - O nome do Tipo de Investimento deve ser único no sistema.
        RN017 - Um Tipo de Investimento não pode ser removido.
        RN026 - Um Tipo de Investimento não armazena saldo.
    Request Body:
    {
        "name": "",
        "description": "",
        "status": ""
    }
    Response Body:
    ```[
        {
            "id": 1,
            "name": "Conta de Investimento",
            "description": "Conta de Investimento",
            "status": "true"
        },
        {
            "id": 2,
            "name": "CDB",
            "description": "Certificado de Depósito Bancário",
            "status": "true"
        },
        {
            "id": 3,
            "name": "Previdência Privada",
            "description": "Plano de Previdência Complementar Privada",
            "status": "true"
        }
    ]```

    Filtros:
        nome, description, status
    Ordenação:
        name, status.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de tipos de investimentos conforme o filtro.

## GET: /investment-types/{id}
    Descrição:
        Lista apenas um tipo de investimento.
    Regras de negócio relacionadas:
        UC024 - O usuário pode listar os tipos de investimento.
        UC023 - O usuário não pode cadastrar um tipo de investimento.
        UC025 - O usuário não pode alterar um tipo de investimento.
        UC026 - O usuário não pode excluir um tipo de investimento.
        RNV012 - O nome do Tipo de Investimento deve ser único no sistema.
        RN017 - Um Tipo de Investimento não pode ser removido.
        RN026 - Um Tipo de Investimento não armazena saldo.
    Request Body:
        Não Possui.
    Response Body:
    ```{
            "id": 4,
            "name": "Tesouro Direto",
            "description": "Programa Tesouro Direto - Programa de Negociação de Títulos Públicos Federais",
            "status": "true"
        }```

    Filtros:
        Nenhum
    Ordenação:
        Nenhum.
    Paginação:
        Nenhum.
    Status HTTP possíveis:
        200 OK
        404 Not Found
        500 Internal Server Error
    Observações:
        Retorna apenas um tipo de investimento.


# INVESTIMENTOS

/*Não sei se Investimentos será uma entidade aonde o usuário irá manipular.Porque investimento é apenas uma tabela intermediária entre uma transação e o (banco + tipo de investimento) aonde o dinheiro está aportado. porém, por enquanto vou deixar listado.*/

## GET: /investments
    Descrição:
        Lista todos os investimentos com filtro.
    Regras de negócio relacionadas:
        RN018 - Um Investimento não pode ser removido.
        RN025 - Um Investimento não armazena saldo.
    Request Body:
    {
        "bank_id": "",
        "investment_type_id": "",
        "name": "",
        "description": "",
        "status": ""
    }
    Response Body:
    ```[
        {
            "id": 1,
            "bank_id": 1,
            "investment_type_id": 1,
            "name": "Cofrinho BB",
            "description": "Cofrinho - Banco do Brasil - Fundo de Investimentos.",
            "status": "true"
        },
        {
            "id": 2,
            "bank_id": 6,
            "investment_type_id": 3,
            "name": "Caixinha",
            "description": "Caixinha - Nubank - [Colocar o Nome]",
            "status": "true"
        },
        {
            "id": 3,
            "bank_id": 7,
            "investment_type_id": 3,
            "name": "Meu Porquinho",
            "description": "Meu Porquinho - Inter",
            "status": "true"
        }
    ]```

    Filtros:
        bancos, tipo de investimentos, nome, description, status
    Ordenação:
        bancos, tipo de investimentos, nome, description, status
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de investimentos conforme o filtro.


# TRANSAÇÕES

## GET: /investment-transactions
    Descrição:
        Lista todas as transações com filtro.
    Regras de negócio relacionadas:
        UC014 - O usuário pode consultar as Investment Transactions.
        RNV007 - A data da transação representa a data real do evento financeiro e pode ser diferente da data em que o registro foi inserido no sistema.
    Request Body:
    {
        "goal_id": "",
        "investment_id": "",
        "transaction_date": "",
        "transaction_type": "",
        "amount": "",
        "description": ""
    }
    Response Body:
    ```[
        {
            "id": 1,
            "goal_id": 28,
            "investment_id": 2,
            "transaction_date": "2026-07-22 11:35:00",
            "transaction_type": 1,
            "amount": 500.00,
            "description": "500,00 reais, depositado na caixinha do nubank.",
            "note": "Coloquei 500,00 reais no Nubank, na caixinha 'viagens', para viagem em familia no final do ano.",
            "created_at": "2026-07-22 11:47:29"
        },
        {
            "id": 2,
            "goal_id": 36,
            "investment_id": 3,
            "transaction_date": "2026-07-05 09:15:00",
            "transaction_type": 3,
            "amount": "23.05",
            "description": "Rendimento: Cofrinho - Banco do Brasil (Viagem Internacional)",
            "note": "23,05 de rendimento do saldo aplicado no cofrinho do Banco do Brasil, reservado para viagem internacional.",
            "created_at": "2026-07-05 12:02:07"
        },
        {
            "id": 3,
            "goal_id": 19,
            "investment_id": 4,
            "transaction_date": "2026-07-15 18:55:18",
            "transaction_type": 2,
            "amount": 15000.00,
            "description": "Resgate: Confrinho - Mercado Pago (Compra de Equipamentos)",
            "note": "Regate de 15 mil reais do cofrinho do mercado pago, para modernizar a empresa com novos equipamentos.",
            "created_at": "2026-07-22 09:35:13"
        }
    ]```

    Filtros:
        objetivo, investimento, data de transação, tipo de transação, valor e descricao
    Ordenação:
        objetivo, data de transação, tipo de transação, valor e descricao
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de movimentações conforme o filtro.

## GET: /goals/{goalId}/investment-transactions
    Descrição:
        Listar todas as transações de um objetivo.
    Regras de negócio relacionadas:
        UC014 - O usuário pode consultar as Investment Transactions.
        RNV007 - A data da transação representa a data real do evento financeiro e pode ser diferente da data em que o registro foi inserido no sistema.
    Request Body:
        Não possui.
    Response Body:
    ```[
        {
            "id": 1,
            "goal_id": 22,
            "investment_id": 1,
            "transaction_date": "2026-07-22 11:35:00",
            "transaction_type": 1,
            "amount": 7500.00,
            "description": "Depósito: Cofrinho - Banco do Brasil (Encargos Trabalhistas).",
            "note": "Coloquei 7.500,00 reais no Banco do Brasil, para garantir recursos para encargos e obrigações trabalhistas..",
            "created_at": "2026-07-22 11:47:29"
        },
        {
            "id": 2,
            "goal_id": 22,
            "investment_id": 3,
            "transaction_date": "2026-07-05 09:15:00",
            "transaction_type": 3,
            "amount": "2500.00",
            "description": "Rendimento: Cofrinho - Banco do Brasil (Encargos Trabalhistas)",
            "note": "2.500,00 de rendimento do saldo aplicado no cofrinho do Banco do Brasil, reservado para encargos e...",
            "created_at": "2026-07-05 12:02:07"
        },
        {
            "id": 3,
            "goal_id": 22,
            "investment_id": ?,
            "transaction_date": "2026-07-15 18:55:18",
            "transaction_type": 2,
            "amount": 5000.00,
            "description": "Resgate: Cofrinho - Banco do Brasil (Encargos Trabalhistas)",
            "note": "Regate de 5 mil reais do cofrinho do Banco do Brasil, para pagar encargos trabalhistas.",
            "created_at": "2026-07-22 09:35:13"
        }
    ]```

    Filtros:
        Não possui.
    Ordenação:
        data de transação, tipo de transação, valor.
    Paginação:
        page, size, sort
    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de movimentações de um objetivo.

## GET: /investment-transactions/{id}
    Descrição:
        Retorna uma única transação do usuário.
    Regras de negócio relacionadas:
        UC014 - O usuário pode consultar as Investment Transactions.
        RNV007 - A data da transação representa a data real do evento financeiro e pode ser diferente da data em que o registro foi inserido no sistema.
    Request Body:
        Não Possui.
    Response Body:

    ```{
        "id": 2,
        "goal_id": 22,
        "investment_id": 3,
        "transaction_date": "2026-07-05 09:15:00",
        "transaction_type": 3,
        "amount": "2500.00",
        "description": "Rendimento: Cofrinho - Banco do Brasil (Encargos Trabalhistas)",
        "note": "2.500,00 de rendimento do saldo aplicado no cofrinho do Banco do Brasil, reservado para encargos e...",
        "created_at": "2026-07-05 12:02:07"
    }```

    Filtros:
        Não possui.
    Ordenação:
       data de transação, tipo de transação, valor.
    Paginação:
        page, size, sort

    Status HTTP possíveis:
        200 OK
        404 Not Found
        500 Internal Server Error
    Observações:
        Retorna apenas uma transação de um usuário.

## POST: /investment-transactions
    Descrição:
        Cria uma nova transação.
    Regras de negócio relacionadas:
            UC013 - O usuário pode registrar uma Investment Transaction.
            RNV004 - O valor da Movimentação (`investment_transaction.amount`) deve ser maior que zero.
    Request Body:
    ```{
        "goal_id": 16,
        "investment_id": 3,
        "transaction_date": "2026-07-05 09:15:00",
        "transaction_type": 1,
        "amount": "75000.00",
        "description": "Depósito: Cofrinho - Banco do Brasil (Abrir uma nova unidade)",
        "note": "75.000,00 de depósito no cofrinho do Banco do Brasil, reservado para abrir nova unidade..."
    }```
    Response Body:

    ```{
        "id": 14,
        "goal_id": 16,
        "investment_id": 3,
        "transaction_date": "2026-07-05 09:15:00",
        "transaction_type": 1,
        "amount": "75000.00",
        "description": "Depósito: Cofrinho - Banco do Brasil (Abrir uma nova unidade)",
        "note": "75.000,00 de depósito no cofrinho do Banco do Brasil, reservado para abrir nova unidade...",
        "created_at": "2026-07-05 12:02:07"
    }```

    Status HTTP possíveis:
        201 Created
        400 Bad Request
        403 Forbidden
        409 Conflict
        500 Internal Server Error
    Observações:
        O usuário deve indicar o objetivo.
        O usuário deve indicar o tipo de transação
        O valor deve ser maior do que zero.
        O campo descrição tem limite de 255 caracteres.
        O campo note é sem limites de caracter, deve ser validada a entrada do campo.

PUT: /investment-transactions/{id}
    Descrição:
        Atualiza os dados de uma transação existente.
    Regras de negócio relacionadas:
        UC015 - O usuário pode alterar os dados de uma Investment Transaction.

    Request Body:
    ```{
        "goal_id": 16,
        "investment_id": 3,
        "transaction_date": "2026-07-05 09:15:00",
        "transaction_type": 3,
        "amount": "75000.00",
        "description": "Rendimentos: Cofrinho - Banco do Brasil (Abrir uma nova unidade)",
        "note": "75.000,00 de rendimento no cofrinho do Banco do Brasil, reservado para abrir nova unidade..."
    }```
    Response Body:

    ```{
        "id": 14,
        "goal_id": 16,
        "investment_id": 3,
        "transaction_date": "2026-07-05 09:15:00",
        "transaction_type": 3,
        "amount": "75000.00",
        "description": "Rendimentos: Cofrinho - Banco do Brasil (Abrir uma nova unidade)",
        "note": "75.000,00 de rendimento no cofrinho do Banco do Brasil, reservado para abrir nova unidade...",
        "created_at": "2026-07-05 12:02:07"
    }```

    Status HTTP possíveis:
        200 OK
        400 Bad Request
        403 Forbidden
        409 Conflict
        500 Internal Server Error
    Observações:
        Não é permitido alterar o ID, objetivo e data de criação.

DELETE: /investment-transactions/{id}
    Descrição:
        Remove uma transacao existente.
    Regras de negócio relacionadas:
        UC016 - O usuário pode excluir uma Investment Transaction.
    Request Body:
        Não possui.
    Response Body:
        Não possui.
    Status HTTP possíveis:
        204 No Content
        403 Forbidden
        404 Not Found
        409 Conflict
        500 Internal Server Error
    Observações:
        Não possui.
