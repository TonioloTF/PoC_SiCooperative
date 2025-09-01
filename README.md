# Projeto SiCooperative (Spark + PostgreSQL)

## Descrição

O projeto foi desenvovido no VSCode e contém dois notebooks:  

1. pipe_movimento_flat.ipynb - Realiza a leitura individual das tabelas, fazendo todo o relacionamento e agregação dos dados com Spark.  
2. pipe_movimento_flat_query.ipynb - Realiza a leitura da query pronta diretamente do banco de dados.

Obs: Nos scripts estão todas as credenciais de conexão com o banco PostgreSQL (Render).

---

## Estrutura de Pastas

Dentro do projeto existem 3 pastas:

- **Drivers**: Diretório onde está o JDBC do PostgreSQL.  
- **Outputs**: Diretório de saída do arquivo CSV.  
- **Scripts**: Diretório com a DDL das tabelas e os scripts para popular as mesmas.

---

## Pontos Complementares

- A nomeclatura das tabelas e campos não está padronizada. A primeira ação recomendada seria criar um prefixo para qualificar a natureza de cada coluna e tabela.  
- Considerando que estamos falando de um data lake que será utilizado para análises gerenciais, recomendaria modificar a modelagem das tabelas para uma abordagem Star Schema, onde o fato movimento também receberia as informações de conta e associado. Dessa forma haveria ganho de performance de acordo com a análise a ser realizada.

---

## Dificuldades

- Configuração do ambiente: houve problema para identificar incompatibilidade da versão do Spark com a versão do Java instalada na máquina.
