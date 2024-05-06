require 'rails_helper'

describe 'Proprietário acessa pedidos' do
  it 'e acessa tela de pedidos' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    client_2 = Client.create!(name: 'André', email: 'andre@email.com', register_number: '72517369003', password: '123456')
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')


  
    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix, Dinheiro, Cartão de crédito', description: 'Buffets e eventos', owner: owner_first)

    event_1 = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                          menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: false,
                          description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet_first)
  
    price_event_1 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                     additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_1)

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 1, estimated_people: 20, details: 'OK', address: buffet_first.full_address)
    order_2 = Order.create!(event: event_1, buffet: buffet_first, client: client_2, estimated_date: Date.today + 1, estimated_people: 20, details: 'BLZ', address: buffet_first.full_address)

    login_as owner_first
    visit root_path
    click_on 'Pedidos'

    expect(page).to have_content 'Pedidos aguardando avaliação'
    expect(page).to have_content order.code
    expect(page).to have_content order_2.code
  end

  it 'e os consulta' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    client_2 = Client.create!(name: 'André', email: 'andre@email.com', register_number: '72517369003', password: '123456')
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')


  
    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix, Dinheiro, Cartão de crédito', description: 'Buffets e eventos', owner: owner_first)

    event_1 = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                          menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: false,
                          description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet_first)
  
    price_event_1 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                     additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_1)

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 1, estimated_people: 20, details: 'OK', address: buffet_first.full_address)
    order_2 = Order.create!(event: event_1, buffet: buffet_first, client: client_2, estimated_date: Date.today + 1, estimated_people: 20, details: 'BLZ', status: 1, address: buffet_first.full_address)

    login_as owner_first
    visit root_path
    click_on 'Pedidos'

    expect(page).to have_content 'Pedidos aguardando avaliação'
    expect(page).to have_content order.code
    expect(page).to have_content 'Demais pedidos'
    expect(page).to have_content order_2.code
  end

  it 'e vê somente os seus' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')

    owner_second = Owner.create!(email: 'owner5678@test.com', password: '123456')


  
    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix, Dinheiro, Cartão de crédito', description: 'Buffets e eventos', owner: owner_first)

    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)

    event_1 = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                          menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: false,
                          description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet_first)
  
    price_event_1 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                          additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_1)

    event_2 = Event.create!(name: 'Samba', min_quantity_people: '20', max_quantity_people: '50', duration_in_minutes: '300',
                          menu: 'Tira gostos e peças de carne', alcoholic_drink: true, self_decoration: true, parking: true, valet: false, fixed_location: true,
                          description: 'Música ao vivo e pista de dança', owner: owner_second, buffet: buffet_second)

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 1, estimated_people: 20, details: 'OK', address: buffet_first.full_address)
    order_2 = Order.create!(event: event_2, buffet: buffet_second, client: client, estimated_date: Date.today + 1, estimated_people: 20, details: 'BLZ', address: buffet_second.full_address)

    login_as owner_first
    visit root_path
    click_on 'Pedidos'
    click_on order.code

    expect(page).to have_content order.code
    expect(page).to have_content "Quantidade estimada de convidados #{order.estimated_people}"
    format = I18n.l order.estimated_date
    expect(page).to have_content "Data desejada #{format}"
    expect(page).to have_content "Cliente #{order.client.name}"
    expect(page).to have_content "Local de realização do evento #{order.address}"
    expect(page).not_to have_content order_2.code

  end
  it 'e é informado que possui dois pedidos para o mesmo dia' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    client_2 = Client.create!(name: 'André', email: 'andre@email.com', register_number: '72517369003', password: '123456')
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')


  
    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix, Dinheiro, Cartão de crédito', description: 'Buffets e eventos', owner: owner_first)

    event_1 = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                          menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: false,
                          description: 'Especialidade em formaturas', owner: owner_first, buffet: buffet_first)

    price_event_1 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                          additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_1)


    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 1, estimated_people: 20, details: 'OK', address: buffet_first.full_address)
    order_2 = Order.create!(event: event_1, buffet: buffet_first, client: client_2, estimated_date: Date.today + 1, estimated_people: 20, details: 'BLZ', address: buffet_first.full_address)

    login_as owner_first
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    
    expect(page).to have_content 'Existem 2 pedidos agendados para está data'
    expect(page).to have_content 'Valor final ainda não confirmado'
    expect(page).to have_content 'Cadastrar novo valor'
  end
end 