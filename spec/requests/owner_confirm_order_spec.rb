require 'rails_helper'

RSpec.describe 'Propritério aceita um pedido' do

  it 'vê o pedido não sendo o dono' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

    buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                        state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                        phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                        payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)


    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                        state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                        phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                        payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)

    event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                      menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                      description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet)

    price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                 additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

    order = Order.create!(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 90, details: 'Formandos da UFJF, turma 2018.1',
                          address: buffet.full_address, client: client)

    login_as owner_second

    get order_view_path(buffet.id)

    expect(response).to redirect_to root_path
  end

  it 'faz uma requisição inválida' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

    buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                        state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                        phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                        payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)


    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                        state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                        phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                        payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)

    event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                      menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                      description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet)

    price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                 additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

    order = Order.create!(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 90, details: 'Formandos da UFJF, turma 2018.1',
                          address: buffet.full_address, client: client)

    login_as owner_second

    get order_view_path(99999)

    expect(response).to redirect_to root_path
  end

  it 'e não é o dono' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

    buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                        state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                        phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                        payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)


    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                        state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                        phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                        payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)

    event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                      menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                      description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet)

    price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                 additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

    order = Order.create!(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 90, details: 'Formandos da UFJF, turma 2018.1',
                          address: buffet.full_address, client: client)

    login_as owner_second


    post(confirm_order_path(id: order.id, status: 1))

    expect(response).to redirect_to root_path
  end
end