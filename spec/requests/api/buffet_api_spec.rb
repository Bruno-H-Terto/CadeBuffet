require 'rails_helper'

describe 'Buffet API' do
  context 'GET /api/v1/buffets/1'do

    it 'sucesso' do
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
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response[0]['brand_name']).to eq 'Chinas Buffet'
      expect(json_response[1]['brand_name']).to eq 'Giramundo'

      
   
    end

  end
end