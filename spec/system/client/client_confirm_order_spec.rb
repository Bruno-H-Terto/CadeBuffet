require 'rails_helper'

describe 'Cliente tem pedido aprovado pelo Buffet' do
  it 'e recebe notificação' do
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

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 10, estimated_people: 20, address: buffet_first.full_address, details: 'Ok', status: 1)
    price_order = PriceOrder.create!(order: order, initial_price: 900, rate: 100, description_rate: 'Adicional de lotação', final_price: 1000, deadline: Date.today + 3, payment_methods: 'Dinheiro, Pix', owner: buffet_first.owner)

    login_client client
    visit root_path
    click_on 'Meus pedidos'

    expect(page).to have_content 'Pedidos liberados pelo Buffet'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Situação: Confirmado pelo Buffet"
  end

  it 'acessa página do pedido e consula valor atualizado' do
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

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 10, estimated_people: 20, address: buffet_first.full_address, details: 'Ok', status: 1)
    price_order = PriceOrder.create!(order: order, initial_price: 900, rate: 100, description_rate: 'Adicional de lotação', final_price: 1000, deadline: Date.today + 3, payment_methods: 'Dinheiro, Pix', owner: buffet_first.owner)

    login_client client
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code

    date_format = I18n.l Date.today + 3
    expect(page).to have_content "Data limite para confirmação #{date_format}"
    expect(page).to have_content 'Valor final R$ 1.000,00'
    expect(page).to have_content 'Taxa de R$ 100,00 | Descrição da taxa: Adicional de lotação'
    expect(page).to have_content 'Formas de pagamento: Dinheiro, Pix'
    expect(page).to have_content "Mais informações de contato: #{buffet_first.full_address} | #{buffet_first.mask_phone_number}"

  end

  it 'e o confirma' do
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

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 10, estimated_people: 20, address: buffet_first.full_address, details: 'Ok', status: 1)
    price_order = PriceOrder.create!(order: order, initial_price: 900, rate: 100, description_rate: 'Adicional de lotação', final_price: 1000, deadline: Date.today + 3, payment_methods: 'Dinheiro, Pix', owner: buffet_first.owner)

    login_client client
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Confirmar evento'


    expect(page).to have_content 'Evento confirmado com sucesso'
    expect(page).to have_content 'Pedidos confirmados'
    date_format = I18n.l Date.today + 10
    click_on 'Pedidos confirmados'
    expect(page).to have_content "Código: #{order.code} Agendado para #{date_format}"
    expect(page).to have_content "Situação: Evento confirmado"
    expect(page).to have_content "Valor final R$ 1.000,00"
    expect(page).to have_content "Formas de pagamento: Dinheiro, Pix"
    expect(page).to have_content "Local de realização do evento: #{order.address}"
    expect(page).to have_content "Mais informações de contato: (32) 999999999"
  end
end