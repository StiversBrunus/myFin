
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
            "name": "Reserva de Emergência",
            "description": "Garantir segurança financeira diante de imprevistos pessoais...",
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 2,
            "name": "Reserva de Oportunidade",
            "description": "Manter recursos disponíveis para aproveitar oportunidades financeiras...",
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        },
        {
            "id": 3,
            "name": "Reserva de Patrimônio",
            "description": "Construir patrimônio e realizar objetivos pessoais de médio e longo...",
            "status": "true",
            "created_at": "2026-07-14 13:02:33"
        }
    ]```
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
    Status HTTP possíveis:
        200 OK
        500 Internal Server Error
    Observações:
        Retorna uma lista de Objetivos de um usuário.


## GET: /goals/{reserveId}/goals
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

    Status HTTP possíveis:
        200 OK
        404 Not Found
        500 Internal Server Error
    Observações:
        Retorna apenas um Objetivo de um usuário.

## POST: /goals
## PUT: /goals/{id}
## DELETE: /goals/{id}

/*BANCOS*/

/*Acredito que não vou permitir o usuário de inserir, editar e excluir um novo banco ou instituição financeira, eu insiro no banco toda vez que surgir uma nova instituição.Como o surgimento de uma nova instituição financeira não é recorrente no país, acredito que isto não dará muito suporte.*/

GET: /banks
GET: /banks/{id}
POST: /banks
PUT: /banks/{id}
DELETE: /banks/{id}

/*TIPOS DE INVESTIMENTOS*/

/*Ainda não sei se vou permitir o usuário de inserir, editar e excluir um novo tipo de investimento, ou se eu insiro no banco toda vez que surgir um novo tipo de investimento, ou toda vez que der um suporte pedindo a adição de um novo tipo de investimento.*/

GET: /investment-types
GET: /investment-types/{id}
POST: /investment-types
PUT: /investment-types/{id}
DELETE: /investment-types/{id}

/*INVESTIMENTOS*/

/*Não sei se Investimentos será uma entidade aonde o usuário irá manipular.Porque investimento é apenas uma tabela intermediária entre uma transação e o (banco + tipo de investimento) aonde o dinheiro está aportado. porém, por enquanto vou deixar listado.*/

GET: /investments
GET: /investments/{id}
POST: /investments
PUT: /investments/{id}
DELETE: /investments/{id}

/*TRANSAÇÕES*/

GET: /investment-transactions
GET: /investment-transactions/{id}
POST: /investment-transactions
PUT: /investment-transactions/{id}
DELETE: /investment-transactions/{id}