require 'rails_helper'

describe 'Buffet API - Events' do
  context 'GET /api/v1/buffets/:buffet_id/events' do
    it 'retorna status 200 quando localiza eventos disponíveis' do
      owner = Owner.create!(email: 'owner1234@test.com', password: '123456')
  
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
  
      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
      price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

      get "/api/v1/buffets/#{buffet.id}/events"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
    end

    it 'retorna detalhes de um evento apenas do buffet procurado' do
      owner = Owner.create!(email: 'owner1234@test.com', password: '123456')
      owner_2 = Owner.create!(email: 'ownersecond@test.com', password: '123456')
  
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      buffet_2 = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_2)
  
      event_1 = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
      price_event_1 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_1)

      event_2 = Event.create!(name: 'Festa temática Marvel', min_quantity_people: '30', max_quantity_people: '90', duration_in_minutes: '60',
                            menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                            description: 'Evento geek com temática clássico dos anos 80', owner: owner, buffet: buffet)

      price_event_2 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                      additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_2)

      event_3 = Event.create!(name: 'Festa de Casamento', min_quantity_people: '50', max_quantity_people: '200', duration_in_minutes: '60',
                            menu: 'A definir', alcoholic_drink: true, self_decoration: true, parking: true, valet: false, fixed_location: true,
                            description: 'A mais de 30 anos no mercado', owner: owner_2, buffet: buffet_2)

      price_event_3 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                            additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_3)

      get "/api/v1/buffets/#{buffet.id}/events"

      
      json_response = JSON.parse response.body
      expect(json_response.length).to eq 2
      expect(json_response[0]['name']).to eq 'Festa de formatura'
      expect(json_response[0]['min_quantity_people']).to eq 10
      expect(json_response[0]['max_quantity_people']).to eq 90
      expect(json_response[0]['duration_in_minutes']).to eq 60
      expect(json_response[0]['menu']).to eq 'A definir'
      expect(json_response[0]['alcoholic_drink']).to eq false
      expect(json_response[0]['self_decoration']).to eq true
      expect(json_response[0]['parking']).to eq true
      expect(json_response[0]['valet']).to eq false
      expect(json_response[0]['fixed_location']).to eq true
      expect(json_response[0]['description']).to eq 'Especialidade em formaturas'
      expect(json_response[0]['owner_id']).to eq owner.id
      expect(json_response[0]['buffet_id']).to eq buffet.id
      expect(json_response[0].keys).not_to include 'created_at'
      expect(json_response[0].keys).not_to include 'updated_at'
      expect(json_response[1]['name']).to eq 'Festa temática Marvel'
      expect(json_response[1]['name']).not_to eq 'Festa de Casamento'

    end

    it 'retorna uma mensagem quando não localiza eventos cadastrados para um Buffet' do
      owner = Owner.create!(email: 'owner1234@test.com', password: '123456')
  
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      get "/api/v1/buffets/#{buffet.id}/events"

      json_response = JSON.parse response.body
      expect(json_response['message']).to eq "Não existem eventos cadastrado para o Buffet: #{buffet.brand_name}"

    end
  end
end