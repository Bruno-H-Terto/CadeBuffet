require 'rails_helper'

RSpec.describe 'Cliente confirma um pedido' do
  it 'e não é o dono' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    client_1 = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    client_2 = Client.create!(name: 'Antônio', email: 'antonio@email.com', register_number: '72517369003', password: '123456')

    buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                        state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                        phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                        payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)

    event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                      menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                      description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet)

    price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                 additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

    order = Order.create!(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 90, details: 'Formandos da UFJF, turma 2018.1',
                          address: buffet.full_address, client: client_1)
                          
    price_order = PriceOrder.create!(order: order, initial_price: 900, rate: 100, description_rate: 'Adicional de lotação', final_price: 1000, deadline: Date.today + 3,
                                      payment_methods: 'Dinheiro, Pix', owner: owner_first)


    post client_session_path, params: { client: { email: client_2.email, password: client_2.password } }

    post(order_confirm_event_path(order_id: order.id, status: 'confirm'))

    expect(response).to redirect_to root_path
  end

  it 'e faz uma requisiçao desconhecida' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    

    buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                        state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                        phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                        payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)

    event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                      menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                      description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet)

    price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                 additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

    order = Order.create!(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 90, details: 'Formandos da UFJF, turma 2018.1',
                          address: buffet.full_address, client: client)
                          
    price_order = PriceOrder.create!(order: order, initial_price: 900, rate: 100, description_rate: 'Adicional de lotação', final_price: 1000, deadline: Date.today + 3,
                                      payment_methods: 'Dinheiro, Pix', owner: owner_first)


    post client_session_path, params: { client: { email: client.email, password: client.password } }

    post(order_confirm_event_path(order_id: order.id, status: 'random'))

    expect(response).to redirect_to orders_path
    expect(order.status).to eq 'waiting_review'
  end
end