require 'rails_helper'

describe 'Buffet API' do
  context 'GET /api/v1/buffets/1'do

    it 'sucesso' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'Chinas Buffet LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '15202537000101', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      get "/api/v1/buffets"

      expect(response.status).to eq 200
      expect(response.body).to eq 'Chinas Buffet'
      expect(response.content_type).to include 'application/json'
      
   
    end

  end
end