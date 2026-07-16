
/*CARTEIRAS*/

GET: /wallets
GET: /wallets/{id}
POST: /wallets
PUT: /wallets/{id}
DELETE: /wallets/{id}

/*RESERVAS*/

GET: /reserves
GET: /reserves/{id}
POST: /reserves
PUT: /reserves/{id}
DELETE: /reserves/{id}

/*OBJETIVOS*/

GET: /goals
GET: /goals/{id}
POST: /goals
PUT: /goals/{id}
DELETE: /goals/{id}

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