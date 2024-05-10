require 'rails_helper'

describe 'Cliente realiza um pedido' do
  it 'a partir da página inicial' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')

  
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

    
    event_2 = Event.create!(name: 'Chá de revelação', min_quantity_people: '12', max_quantity_people: '30', duration_in_minutes: '100',
                            menu: 'Bolo e e doces para festa', alcoholic_drink: false, self_decoration: true, parking: false, valet: true, fixed_location: false,
                            description: 'Eventos para toda a família', owner: owner_first, buffet: buffet_first)

    price_event_2 = PriceEvent.create!(min_price_weekend: '2000', min_price_working_day: '1400', extra_hour_weekend: '400', extra_hour_working_day: '270',
                                        additional_price_for_person_weekend: '320', additional_price_for_person_working_day: '180', event: event_2)

    event_3 = Event.create!(name: 'Samba', min_quantity_people: '20', max_quantity_people: '50', duration_in_minutes: '300',
                            menu: 'Tira gostos e peças de carne', alcoholic_drink: true, self_decoration: true, parking: true, valet: false, fixed_location: true,
                            description: 'Música ao vivo e pista de dança', owner: owner_second, buffet: buffet_second)
            
    price_event_3 = PriceEvent.create!(min_price_weekend: '5000', min_price_working_day: '2400', extra_hour_weekend: '700', extra_hour_working_day: '500',
                                        additional_price_for_person_weekend: '500', additional_price_for_person_working_day: '320', event: event_3)


    login_client client
    visit root_path
    click_on 'Novo pedido'

    expect(page).to have_content 'Festa de formatura'
    expect(page).to have_content 'Chá de revelação'
    expect(page).to have_content 'Samba'
    

  end

  it 'através de listagem de eventos' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')

  
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

    
    event_2 = Event.create!(name: 'Chá de revelação', min_quantity_people: '12', max_quantity_people: '30', duration_in_minutes: '100',
                            menu: 'Bolo e e doces para festa', alcoholic_drink: false, self_decoration: true, parking: false, valet: true, fixed_location: false,
                            description: 'Eventos para toda a família', owner: owner_first, buffet: buffet_first)

    price_event_2 = PriceEvent.create!(min_price_weekend: '2000', min_price_working_day: '1400', extra_hour_weekend: '400', extra_hour_working_day: '270',
                                        additional_price_for_person_weekend: '320', additional_price_for_person_working_day: '180', event: event_2)

    event_3 = Event.create!(name: 'Samba', min_quantity_people: '20', max_quantity_people: '50', duration_in_minutes: '300',
                            menu: 'Tira gostos e peças de carne', alcoholic_drink: true, self_decoration: true, parking: true, valet: false, fixed_location: true,
                            description: 'Música ao vivo e pista de dança', owner: owner_second, buffet: buffet_second)
            
    price_event_3 = PriceEvent.create!(min_price_weekend: '5000', min_price_working_day: '2400', extra_hour_weekend: '700', extra_hour_working_day: '500',
                                        additional_price_for_person_weekend: '500', additional_price_for_person_working_day: '320', event: event_3)



    login_client client
    visit root_path
    click_on 'Listar Buffets'
    click_on 'Chinas Buffet'
    click_on 'Novo pedido - Festa de formatura'

    expect(page).to have_content 'Festa de formatura'
    expect(page).to have_field 'Data desejada'
    expect(page).to have_field 'Quantidade estimada de convidados'
    expect(page).to have_field 'Observações'
    expect(page).to have_field 'Local de realização do evento'

    
  end

  it 'com sucesso' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
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

    login_client client
    visit root_path
    click_on 'Listar Buffets'
    click_on 'Chinas Buffet'
    click_on 'Novo pedido - Festa de formatura'
    format_date = Date.today + 7
    fill_in 'Data desejada', with: format_date
    fill_in 'Quantidade estimada de convidados', with: '20'
    fill_in 'Observações', with: 'Tema a fantasia'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido realizado com sucesso'
    expect(current_path).to eq root_path

  end

  it ', mas não pode ter mais de um pedido em avaliação para o mesmo Buffet' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    owner = Owner.create!(email: 'owner1234@test.com', password: '123456')


  
    buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix, Dinheiro, Cartão de crédito', description: 'Buffets e eventos', owner: owner)

    event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                          menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: false,
                          description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
    price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                     additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

    order = Order.create!(event: event, buffet: buffet, client: client, estimated_date: Date.today + 1, estimated_people: 20, details: 'OK', address: buffet.full_address)

    login_client client
    visit root_path
    click_on 'Listar Buffets'
    click_on 'Chinas Buffet'
    click_on 'Novo pedido - Festa de formatura'

    expect(page).to have_content 'Não é permitido o registro simultãneo de dois ou mais pedidos para o mesmo Buffet'
    expect(current_path).to eq root_path
  end

  it 'e pode ter mais de um pedido para o mesmo Buffet desde que o outro já tenha sido avaliado' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    owner = Owner.create!(email: 'owner1234@test.com', password: '123456')


  
    buffet = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix, Dinheiro, Cartão de crédito', description: 'Buffets e eventos', owner: owner)


    event_1 = Event.create!(name: 'Festa de casamento', min_quantity_people: '50', max_quantity_people: '100', duration_in_minutes: '180',
                          menu: 'A definir', alcoholic_drink: true, self_decoration: true, parking: true, valet: true, fixed_location: false,
                          description: 'ESpecialidades para noivas', owner: owner, buffet: buffet)

    event_2 = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                          menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: false,
                          description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
    price_event_1 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                          additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_1)

    price_event_2 = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                     additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event_2)

    order = Order.create!(event: event_1, buffet: buffet, client: client, estimated_date: Date.today + 1, estimated_people: 20, details: 'OK', address: buffet.full_address, status: :confirmed_for_buffet)

    login_client client
    visit root_path
    click_on 'Listar Buffets'
    click_on 'Chinas Buffet'
    click_on 'Novo pedido - Festa de formatura'
    format_date = Date.today + 7
    fill_in 'Data desejada', with: format_date
    fill_in 'Quantidade estimada de convidados', with: '20'
    fill_in 'Observações', with: 'Tema a fantasia'
    click_on 'Gravar'

    expect(page).to have_content 'Pedido realizado com sucesso'
    expect(current_path).to eq root_path
  end
end