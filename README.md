## Introdução

Projeto Ruby on Rails 7.1 feito para contribuir ao projeto BrasilAPI.

só usar o comando rails s, após estar no diretório do projeto, e depois `rails db:drop db:create db:migrate`.

A Api é servida via banco, o consumo desse projeto inicialmente é em via REST de um terceiro(gem rest-client).

No momento atual, não armazenarei nenhum dado nas tabelas, por que é mais rápido.
Então os dados que vai vim remotamente da gem viaCEP.

## 2° Etapa - Feito(s)

- [ ] - Fazer buscas de CEP via REST.
- [ ] - Buscar via REST externo e salvar no banco caso seja um CEP novo.
- [ ] - Buscar CEP com e sem hífen(-).
- [ ] - Análisar caso o CEP esteja com erro/inválido, retornando uma request erro=true.
- [ ] - Análise caso o CEP esteja sem logradouro, mais comum em cidades pequenas.
- [ ] - Configuração de URL para visionamento da API.
- [ ] - uma Log de CEPs inválidos para evitar problemas futuros.

## 3° Versão do Ruby/Ruby on Rails

- Rails 7.1
- ruby 3.2.0

## Mais pautas/configs/etc em breve.
