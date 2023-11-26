# Exemplo de pesquisa por CEP:
# viacep.com.br/ws/01001000/json/

class Api::V1::AddressesController < ApplicationController
    before_action :set_address, only: [:show, :update, :destroy]

    # route: GET /addresses
    def index
        @addresses = Address.where(erro: [nil, false]).order(id: 'DESC').limit(1)

        render json: @addresses
    end

    # route: GET /addresses/1
    def show
        render json: @addresses
    end
    
    # route: POST /addresses
    def create

        # Criação de novos CEPS(Address)
        @address = Address.new(address_params)
        
        if @address.save
            render json: { message: "Cadastro realizado com sucesso!", address: @address }, status: :created
        else
            render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # route: PUT /addresses/1
    def update

        # Atualizar endereços, seja uma mudança, etc.
        if @address.update(address_params)
            render json: @address
        else
            render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # route: DELETE /addresses/1
    def destroy
        @address.destroy
    end

    private

    def set_address
        # Variável básica, recebendo o valor de CEP mesmo assim na solicitação.
        zip_code = params[:zip_code]

        # Vai procurar o CEP pelo ZIP_CODE, OU quando haver uma criação nova(CEP) no banco de dados 
        # Supostamente evitando CEPS duplicados.
        @address = Address.find_by(zip_code: zip_code)

        # Array simples com as URLS e nomes dos provedores de CEP
        cep_providers = [
            { url: "https://brasilapi.com.br/api/cep/v1#{zip_code}/json", name: 'brasilapi' } # Provedora Teste da própria contribuição a BrasilAPI
        ]
    end

    # Apenas irá funcionar qualquer CEP com esses parâmetros abaixo(o serviço é das provedora que está fornecendo.)
    def address_params
        params.require(:address).permit(:cep, :logradouro, :bairro, :cidade, :uf, :ibge, :gia, :ddd, :siafi, :erro)
    end
end