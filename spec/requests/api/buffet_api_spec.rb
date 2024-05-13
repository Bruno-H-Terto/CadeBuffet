require 'rails_helper'

describe 'Buffet API' do
  context 'GET /api/v1/buffets'do
    it 'deve retornar status 200 quando localizar buffets' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')

      buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'Chinas Buffet LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '15202537000101', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)

      get "/api/v1/buffets"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
    end

    it 'deve retornar status 204 se não houver buffets cadastrados' do
      get "/api/v1/buffets"

      expect(response.status).to eq 204
    end

    it 'deve retornar uma lista completa de buffets em ordem alfabética' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')

      buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'Chinas Buffet LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '15202537000101', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)


      get "/api/v1/buffets"

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first['brand_name']).to eq 'Chinas Buffet'
      expect(json_response[0].keys).not_to include 'created_at'
      expect(json_response[0].keys).not_to include 'updated_at'
      expect(json_response.last['brand_name']).to eq 'Giramundo'
   
    end

    it 'deve retornar somente a correspondência procurada' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')

      buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'Chinas Buffet LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '15202537000101', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)


      get "/api/v1/buffets", params: {brand_name: 'Giramundo'}

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response[0]['brand_name']).not_to eq 'Chinas Buffet'
      expect(json_response[0]['brand_name']).to eq 'Giramundo'
    end

    it 'deve retornar um aviso quando sem correspondência' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')

      buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'Chinas Buffet LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '15202537000101', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)


      get "/api/v1/buffets", params: {brand_name: 'Outro Buffet'}

      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq 'Sem resultados disponíveis para: Outro Buffet'
    end

    it 'não aceita parâmetros extras ou desconhecidos' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')

      buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'Chinas Buffet LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '15202537000101', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)


      get "/api/v1/buffets", params: {extra: 'parâmetro', other: 'outro parâmetro'}

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.first['brand_name']).to eq 'Chinas Buffet'
      expect(json_response.last['brand_name']).to eq 'Giramundo'

    end
  end

  context 'GET /api/v1/buffets/:id' do
    it 'retorna status 200 quando tem a correspondência de um Buffet' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')

      buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'Chinas Buffet LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '15202537000101', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      get api_v1_buffet_path buffet

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
    end

    it 'retorna detalhes do Buffet exceto CNPJ e Razão social' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')

      buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'Chinas Buffet LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '15202537000101', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      get api_v1_buffet_path buffet

      json_response = JSON.parse response.body
      expect(json_response['id']).to eq buffet.id
      expect(json_response['brand_name']).to eq 'Chinas Buffet'
      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
      expect(json_response.keys).not_to include 'register_number'
      expect(json_response['city']).to eq 'Juiz de Fora'
      expect(json_response['state']).to eq 'MG'
      expect(json_response['address']).to eq 'Rua Principal, 42'
      expect(json_response['phone_number']).to eq '32999999999'
      expect(json_response['district']).to eq 'Centro'
      expect(json_response['zip_code']).to eq '32000-000'
      expect(json_response['payment_methods']).to eq 'Pix'
      expect(json_response['description']).to eq 'Buffets e eventos'
      expect(json_response['owner_id']).to eq owner.id

    end

    it 'e não encontra uma correspondência' do

      get '/api/v1/buffets/42'

      expect(response.status).to eq 404
      json_response = JSON.parse(response.body)
      expect(json_response['message']).to eq 'Não foi encontrado um Buffet com id=> parâmetros: buffet.id=42'
    end
  end
end