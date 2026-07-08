# manual-tests

# Plano de Testes Manuais

## Objetivo

Validar que o modelo físico do banco de dados foi implementado corretamente antes do início do desenvolvimento do Backend.

---

# 1. DATABASE

| Teste                            | Objetivo                                      | Resultado Esperado                   | Status |
|----------------------------------|-----------------------------------------------|--------------------------------------|--------|
| TESTE 001 - Criar Banco de Dados | Executar todo o script SQL em um banco vazio. | O banco devem ser criados sem erros. | ☐      |

---

# 2. CRUD

| Teste                              | Objetivo                                    | Resultado Esperado           | Status |
|------------------------------------|---------------------------------------------|------------------------------|--------|
| TESTE 002 - Wallet                 | Inserir uma Wallet.                         | Registro criado com sucesso. | ☐      |
| TESTE 003 - Reserve                | Inserir uma Reserve vinculada a uma Wallet. | Registro criado com sucesso. | ☐      |
| TESTE 004 - Goal                   | Inserir um Goal vinculado a uma Reserve.    | Registro criado com sucesso. | ☐      |
| TESTE 005 - Bank                   | Inserir um Bank.                            | Registro criado com sucesso. | ☐      |
| TESTE 006 - Investment Type        | Inserir um Investment Type.                 | Registro criado com sucesso. | ☐      |
| TESTE 007 - Investment             | Inserir um Investment.                      | Registro criado com sucesso. | ☐      |
| TESTE 008 - Investment Transaction | Inserir uma Investment Transaction.         | Registro criado com sucesso. | ☐      |

---

# 3. PRIMARY KEYS

| Teste                | Objetivo                                                  | Resultado Esperado                           | Status |
|----------------------|-----------------------------------------------------------|----------------------------------------------|--------|
| TESTE 009 - Identity | Verificar a geração automática do ID em todas as tabelas. | IDs gerados automaticamente pelo PostgreSQL. | ☐      |

---

# 4. FOREIGN KEYS

| Teste     | Objetivo                                                   | Resultado Esperado   | Status |
|-----------|------------------------------------------------------------|----------------------|--------|
| TESTE 010 | Inserir Reserve com Wallet inexistente.                    | Erro de Foreign Key. | ☐      |
| TESTE 011 | Inserir Goal com Reserve inexistente.                      | Erro de Foreign Key. | ☐      |
| TESTE 012 | Inserir Investment com Bank inexistente.                   | Erro de Foreign Key. | ☐      |
| TESTE 013 | Inserir Investment com Investment Type inexistente.        | Erro de Foreign Key. | ☐      |
| TESTE 014 | Inserir Investment Transaction com Goal inexistente.       | Erro de Foreign Key. | ☐      |
| TESTE 015 | Inserir Investment Transaction com Investment inexistente. | Erro de Foreign Key. | ☐      |

---

# 5. CHECK CONSTRAINTS

| Teste     | Objetivo                                                  | Resultado Esperado | Status |
|-----------|-----------------------------------------------------------|--------------------|--------|
| TESTE 016 | Inserir Goal com priority = 5.                            | Erro de CHECK.     | ☐      |
| TESTE 017 | Inserir Investment Transaction com transaction_type = 10. | Erro de CHECK.     | ☐      |
| TESTE 018 | Inserir Goal com target_amount = 0.                       | Erro de CHECK.     | ☐      |
| TESTE 019 | Inserir Goal com initial_amount = -100.                   | Erro de CHECK.     | ☐      |
| TESTE 020 | Inserir Investment Transaction com amount = 0.            | Erro de CHECK.     | ☐      |

---

# 6. UNIQUE CONSTRAINTS

| Teste     | Objetivo                                                    | Resultado Esperado  | Status |
|-----------|-------------------------------------------------------------|---------------------|--------|
| TESTE 021 | Criar duas Wallets com o mesmo nome.                        | Erro de UNIQUE.     | ☐      |
| TESTE 022 | Criar duas Reservas com o mesmo nome na mesma Wallet.       | Erro de UNIQUE.     | ☐      |
| TESTE 023 | Criar duas Reservas com o mesmo nome em Wallets diferentes. | Operação permitida. | ☐      |
| TESTE 024 | Criar dois Goals com o mesmo nome na mesma Reserve.         | Erro de UNIQUE.     | ☐      |
| TESTE 025 | Criar dois Goals com o mesmo nome em Reservas diferentes.   | Operação permitida. | ☐      |
| TESTE 026 | Criar dois Banks com o mesmo nome.                          | Erro de UNIQUE.     | ☐      |
| TESTE 027 | Criar dois Investment Types com o mesmo nome.               | Erro de UNIQUE.     | ☐      |

---

# 7. RELACIONAMENTOS

| Teste     | Objetivo                                                    | Resultado Esperado                                         |Status |
|-----------|-------------------------------------------------------------|----------------------------------------------------------- |-------|
| TESTE 028 | Criar uma Wallet → Reserve → Goal → Investment Transaction. | Todos os relacionamentos devem ser mantidos corretamente.  |☐      |
| TESTE 029 | Criar um Bank → Inst_Tp → Investment → Transaction.         | Todos os relacionamentos devem ser mantidos corretamente.  | ☐     |
| TESTE 030 | Consultar os dados utilizando JOIN entre todas as tabelas relacionadas. | Os relacionamentos devem retornar os registros.| ☐     |

---

# 8. EXCLUSÕES

| Teste     | Objetivo                                                      | Resultado Esperado                   | Status |
|-----------|---------------------------------------------------------------|--------------------------------------|--------|
| TESTE 031 | Excluir uma Wallet com Reservas associadas.                   | Exclusão bloqueada pela Foreign Key. | ☐      |
| TESTE 032 | Excluir uma Reserve com Goals associados.                     | Exclusão bloqueada pela Foreign Key. | ☐      |
| TESTE 033 | Excluir um Goal com Investment Transactions associadas.       | Exclusão bloqueada pela Foreign Key. | ☐      |
| TESTE 034 | Excluir um Bank com Investments associados.                   | Exclusão bloqueada pela Foreign Key. | ☐      |
| TESTE 035 | Excluir um Investment Type com Investments associados.        | Exclusão bloqueada pela Foreign Key. | ☐      |
| TESTE 036 | Excluir um Investment com Investment Transactions associadas. | Exclusão bloqueada pela Foreign Key. | ☐      |

---

# Resultado Final

## Critérios de Aprovação

| Item                         | Status |
|------------------------------|--------|
| Script executado sem erros   | ☐      |
| Tabelas criadas corretamente | ☐      |
| Primary Keys validadas       | ☐      |
| Foreign Keys validadas       | ☐      |
| Check Constraints validadas  | ☐      |
| Unique Constraints validadas | ☐      |
| Relacionamentos validados    | ☐      |
| Exclusões validadas          | ☐      |

## Resultado

☐ Banco de dados aprovado para desenvolvimento do Backend.

☐ Banco de dados reprovado. Necessário corrigir inconsistências antes do desenvolvimento.