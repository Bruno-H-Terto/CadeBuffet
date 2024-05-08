require 'rails_helper'

describe 'Proprietário confirma pedido' do
  include ActionView::Helpers::NumberHelper 

  it 'acessa formulário para preencher valor final' do
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

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 1, estimated_people: 20, details: 'OK', address: buffet_first.full_address)


    login_as owner_first
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    click_on 'Cadastrar novo valor'



    weekend = (0 == order.estimated_date.wday || 6 == order.estimated_date.wday)


    add_people = order.estimated_people - event_1.min_quantity_people if order.estimated_people > event_1.min_quantity_people

    price = 0

    weekend ? price = price_event_1.min_price_weekend.to_i + price_event_1.additional_price_for_person_weekend*add_people :
               price = price_event_1.min_price_working_day.to_i + price_event_1.additional_price_for_person_working_day*add_people

    price = number_to_currency(price)

    expect(page).to have_content "Preço base #{price}"
    expect(page).to have_field'Taxa'
    expect(page).to have_field'Descrição da taxa'
    expect(page).to have_field'Data limite para confirmação'
    expect(page).to have_content'Formas de pagamento'
    expect(find("#price_order_payment_methods_pix").present?).to eq true
    expect(find("#price_order_payment_methods_dinheiro").present?).to eq true
    expect(find("#price_order_payment_methods_cartão_de_crédito").present?).to eq true
    expect(page).to have_button 'Gravar'
  end

  it 'cadastrando o preço do pedido' do
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

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 7, estimated_people: 20, details: 'OK', address: buffet_first.full_address)


    login_as owner_first
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    click_on 'Cadastrar novo valor'
    fill_in 'Taxa', with: '200'
    fill_in 'Data limite para confirmação', with: Date.today + 3
    fill_in 'Descrição da taxa', with: 'Valor adicional devido ao pouco prazo para realização'
    find("#price_order_payment_methods_pix").click
    click_on 'Gravar'


    weekend = (0 == order.estimated_date.wday || 6 == order.estimated_date.wday)


    add_people = order.estimated_people - event_1.min_quantity_people if order.estimated_people > event_1.min_quantity_people

    price = 0

    weekend ? price = price_event_1.min_price_weekend.to_i + price_event_1.additional_price_for_person_weekend*add_people :
               price = price_event_1.min_price_working_day.to_i + price_event_1.additional_price_for_person_working_day*add_people

    price = number_to_currency(price + 200)
    expect(page).to have_content 'Valor do pedido registrado com sucesso!'
    expect(page).to have_content "Valor final #{price}"
    format = I18n.l Date.today + 3
    expect(page).to have_content "Data limite para confirmação #{format}"
    expect(page).to have_content "Taxa de R$ 200,00 | Descrição da taxa: Valor adicional devido ao pouco prazo para realização"
    expect(page).to have_content "Formas de pagamento: Pix"
    expect(page).to have_content 'Confirme o seu pedido'
    expect(page).to have_content 'Confirmar'

  end

  it 'e confirma' do
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

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 7, estimated_people: 20, details: 'OK', address: buffet_first.full_address)


    login_as owner_first
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    click_on 'Cadastrar novo valor'
    fill_in 'Data limite para confirmação', with: Date.today + 3
    fill_in 'Taxa', with: '200'
    fill_in 'Descrição da taxa', with: 'Valor adicional devido ao pouco prazo para realização'
    find("#price_order_payment_methods_pix").click
    click_on 'Gravar'

    click_on 'Confirmar'

    expect(page).to have_content 'Pedido confirmado'
    expect(page).to have_content 'Confirmado pelo Buffet'
  end

  it 'e cancela' do
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

    order = Order.create!(event: event_1, buffet: buffet_first, client: client, estimated_date: Date.today + 7, estimated_people: 20, details: 'OK', address: buffet_first.full_address)


    login_as owner_first
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    click_on 'Cadastrar novo valor'
    fill_in 'Data limite para confirmação', with: Date.today + 3
    fill_in 'Taxa', with: '200'
    fill_in 'Descrição da taxa', with: 'Valor adicional devido ao pouco prazo para realização'
    find("#price_order_payment_methods_pix").click
    click_on 'Gravar'

    click_on 'Cancelar'

    expect(page).to have_content 'Pedido cancelado'
    expect(page).to have_content 'Evento Cancelado'
  end
end