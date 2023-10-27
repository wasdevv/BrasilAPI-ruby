## Introdução

Projeto Ruby on Rails 7.1 feito para contribuir ao projeto BrasilAPI.

só usar o comando rails s, após estar no diretório do projeto, e depois `rails db:drop db:create db:migrate`.

A Api é servida via banco, o consumo desse projeto inicialmente é em via REST de um terceiro(gem rest-client).

No momento atual, não armazenarei nenhum dado nas tabelas, por que é mais rápido.
Então os dados que vai vim remotamente da gem viaCEP.

## Configuração no Projeto

- [✓] - ~Fazer buscas de CEP via REST~, Fazer buscas via Net::HTTP, URI e JSON, que são bibliotecas padrões do Rails para suporte a HTTP.
- [✓] - Buscar via REST externo e salvar no banco caso seja um CEP novo.
- [✓] - Buscar CEP com e sem hífen(-).
- [✓] - Análisar caso o CEP esteja com erro/inválido, retornando uma request erro=true.
- [✓] - Análise caso o CEP esteja sem logradouro, mais comum em cidades pequenas.
- [ ] - uma Log de CEPs inválidos para evitar problemas futuros com logger.level = Logger::WARN ( Usando a log própria do Rails, possibilidade de tentar fazer em uma proxima versão em nuvem ).
- [ ] - Criação de uma route para a lista dos CEPS inválidos, possibilitando re-ajustre dos CEPS inválidos, atualizar o CEP, etc.( Tentar fazer nos ultimos commits ).
- [✓] - Múltiplos provedores de origem(originalmente o BrasilAPI e o viaCEP, tentarei ver outros.)

## Versão do Ruby/Ruby on Rails

- Rails 7.1
- Ruby 3.2.2

## Adições futuras

- [ ] - 
- [ ] -
- [ ] -
