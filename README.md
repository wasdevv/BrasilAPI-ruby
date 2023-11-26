<div align="center">
<h1><img src="https://raw.githubusercontent.com/BrasilAPI/BrasilAPI/main/public/brasilapi-logo-small.png" /></h1>

</div>

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
- [ ] - uma Log de CEPs inválidos para evitar problemas futuros com logger.level = Logger::WARN.
- [ ] - Criação de uma route para a lista dos CEPS inválidos, possibilitando re-ajustre dos CEPS inválidos, atualizar o CEP, etc.
- [✓] - Múltiplos provedores de origem(originalmente o BrasilAPI e o viaCEP, tentarei ver outros.)

## Versão do Ruby/Ruby on Rails

- Rails 7.1
- Ruby 3.2.2

## Busca de CEPS

```
def self.fetch_from_remote(cep, url, service_provider = '' )
        # Depurar um endereço novo.
        Rails.logger.info("Buscando Requisição a URL: #{url}")

        # Uso da biblioteca Padrão do Rails para busca HTTP
        # Possibilidade de testes da documentação próprio Ruby on Rails.
        uri = URI(url)

        response = Net::HTTP.get(uri)
        data = JSON.parse(response, synbolize_names: true)

        if data.is_a?(Array)
            Rails.logger.warn(data.to_s)
            data = data.first
        end

        address = new(
            cep: format_cep(data[:code] || data[:cep]),
            service: data[:service] || service_provider,
            bairro: data[:bairro] || data[:district] || data[:neighborhood],
            logradouro: data[:logradouro] || data[:address] || data[:street],
            complemento: data[:complemento],
            cidade: data[:localidade] || data[:city] || data[:cidade],
            uf: data[:uf] || data[:state],
            ibge: data[:ibge], # || data[:ibge_code] NÃO SEI SE É APROPRIADO / USÁVEL, MAS VOU DEIXAR COMENTADO PARA USO FUTURO(POSSÍVELMENTE)
            gia: data[:gia],
            ddd: data[:ddd],
            siafi: data[:siafi],
            erro: data[:erro] || !data[:ok]
        )
    end
end
```