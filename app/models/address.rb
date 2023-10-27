require 'net/http'
require 'uri'
require 'json'

class Address < ApplicationRecord
    attr_accessor :zip_code
    validates :cep, uniqueness: true, presence: true
    
    # Se logradouro estiver estiver presente, A MENOS que o atributo bairro esteja em branco, nulo ou em branco.
    # Se o atributo BAIRRO estiver em branco, o logradouro é OBRIGATÓRIO.
    validates :logradouro, presence: true, unless: -> { bairro.blank? }
    # Verificar a estética comum de CEPS brasileiros(provavelmente é a única síntase).
    def self.format_cep(cep)
        cep = cep.to_s.gsub(/[^0-9]/, '')
        "#{cep[0..4]}-#{cep[-3..-1]}"
    end

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
        
        # Se acontecer algum ERRO no CEP ou ser INVÁLIDO.
        # Vai registrar na LOG do rails, e se for nil, não irá salvar ser salvo no banco de dados.
        if address.erro
            Rails.logger.error(address.to_s)
            return nil
        end

        address.save unless data[:ok] == false
    rescue JSON::ParserError, SocketError => e
        Rails.logger.error("Ocorreu um erro na request HTTP: #{e}")
        nil
    end
end
