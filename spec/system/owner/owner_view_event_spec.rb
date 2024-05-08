require 'rails_helper'

describe 'Proprietário consulta seu evento' do
  include ActionView::Helpers::NumberHelper 
  it 'a partir da página de consulta do buffet cadastrado'do
    register_event

    click_on 'Festa de 15 anos'
    
    expect(page).to have_content 'Festa de 15 anos'
    expect(page).to have_content 'Festa de 15 anos - Eventos para festas de 15 anos'
    expect(page).to have_content 'Capacidade de 10 à 50 pessoas'
    expect(page).to have_content 'Duração de 120 minutos'
    expect(page).to have_content 'Cardápio: Salgados e refrigerante'
    expect(page).to have_content 'Sem bebida alcoólica'
    expect(page).to have_content 'Decoração própria'
    expect(page).to have_content 'Estacionamento disponível'
    expect(page).to have_content 'Valet disponível'
    expect(page).to have_content 'Local fixo'
    expect(page).to have_content 'Valores nos dias úteis: R$ 12.000,00 com adicional por pessoa de R$ 150,00 + Hora extra de R$ R$ 450,00'
    expect(page).to have_content 'Valores nos fins de semana: R$ 14.000,00 com adicional por pessoa de R$ 300,00 + Hora extra de R$ R$ 600,00'
    expect(page).to have_content 'Editar informações'
  end

  it 'e acessa histórico de pedidos' do
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

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 7, estimated_people: 20, details: 'OK', address: buffet_first.full_address)
    order_2 = Order.create!(event: event_1, buffet: buffet_first, client: client_2, estimated_date: Date.today + 7, estimated_people: 20, details: 'BLZ', address: buffet_first.full_address, status: :canceled)
    price_order = PriceOrder.create!(order: order, initial_price: 900, rate: 100, description_rate: 'Adicional de lotação', final_price: 1000, deadline: Date.today + 3, payment_methods: 'Dinheiro, Pix', owner: buffet_first.owner)
    price_order_2 = PriceOrder.create!(order: order_2, initial_price: 900, rate: 300, description_rate: 'Adicional de lotação', final_price: 1200, deadline: Date.today + 3, payment_methods: 'Dinheiro', owner: buffet_first.owner)

    login_as owner_first
    visit root_path
    click_on 'Festa de formatura'
    click_on 'Histórico de pedidos'

    expect(page).to have_content order.code
    date_format = I18n.l order.estimated_date
    expect(page).to have_content "Data agendada: #{date_format}"
    expect(page).to have_content "Situação: Aguardando avaliação"
    expect(page).to have_content order_2.code
    date_format = I18n.l order_2.estimated_date
    expect(page).to have_content "Data agendada: #{date_format}"
    expect(page).to have_content 'Situação: Evento Cancelado'

  end
end