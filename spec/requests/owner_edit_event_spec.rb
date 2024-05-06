require 'rails_helper'

RSpec.describe 'Propritério edita um evento' do
  it 'e não é o dono' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')
    owner_third = Owner.create!(email: 'ownerother@test.com', password: '123456')

    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)

    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)

    buffet = Buffet.create!(brand_name: 'Buffet Grande Família', corporate_name: 'Grande Família LTDA', city: 'Rio de Janeiro',
                          state:'RJ', address: 'Av 7 de Setembro, 101', register_number: '40386821000122', 
                          phone_number: '21945639999', district: 'Centro', zip_code: '21000-000',
                          payment_methods: 'Pix', description: 'Churrascaria', owner: owner_third)

                          event_1 = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                          menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                          description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet_first)
  
    price_event_1 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                     additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_1)

    
    event_2 = Event.create!(name: 'Chá de revelação', min_quantity_people: '12', max_quantity_people: '30', duration_in_minutes: '100',
                            menu: 'Bolo e e doces para festa', alcoholic_drink: false, self_decoration: true, parking: false, valet: true, fixed_location: false,
                            description: 'Eventos para toda a família', owner: owner_first, buffet: buffet_first)


    login_as owner_second


    patch(event_path(event_2.id), params: {event: {name: 'Casa', buffet_id: 1}})

    expect(response).to redirect_to root_path
  end

  it 'e tenta editar não sendo o dono' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')
    owner_third = Owner.create!(email: 'ownerother@test.com', password: '123456')

    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)

    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)

    buffet = Buffet.create!(brand_name: 'Buffet Grande Família', corporate_name: 'Grande Família LTDA', city: 'Rio de Janeiro',
                          state:'RJ', address: 'Av 7 de Setembro, 101', register_number: '40386821000122', 
                          phone_number: '21945639999', district: 'Centro', zip_code: '21000-000',
                          payment_methods: 'Pix', description: 'Churrascaria', owner: owner_third)

                          event_1 = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                          menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                          description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet_first)
  
    price_event_1 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                     additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_1)

    
    event_2 = Event.create!(name: 'Chá de revelação', min_quantity_people: '12', max_quantity_people: '30', duration_in_minutes: '100',
                            menu: 'Bolo e e doces para festa', alcoholic_drink: false, self_decoration: true, parking: false, valet: true, fixed_location: false,
                            description: 'Eventos para toda a família', owner: owner_first, buffet: buffet_first)


    login_as owner_second


    get(edit_event_path(event_2.id), params: {event: {name: 'Casa', buffet_id: 1}})

    expect(response).to redirect_to root_path
  end
end