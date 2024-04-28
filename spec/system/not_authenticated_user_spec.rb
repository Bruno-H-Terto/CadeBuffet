require 'rails_helper'

describe 'Usuário não autenticado' do 
  it 'acessa a página inicial e tem acesso a listagem de Buffets'do
    visit root_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Listar Buffets'
  end

  it 'vizualiza a listagem de Buffets' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')
    owner_third = Owner.create!(email: 'ownerother@test.com', password: '123456')

    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)

    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '(11)97895-9999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)

    buffet = Buffet.create!(brand_name: 'Buffet Grande Família', corporate_name: 'Grande Família LTDA', city: 'Rio de Janeiro',
                          state:'RJ', address: 'Av 7 de Setembro, 101', register_number: '40386821000122', 
                          phone_number: '(21)94563-9999', district: 'Centro', zip_code: '21000-000',
                          payment_methods: 'Pix', description: 'Churrascaria', owner: owner_third)



    visit root_path
    click_on 'Listar Buffets'

    expect(page).to have_content 'Buffet Chinas Buffet'
    expect(page).to have_content 'Localizado em Juiz de Fora - MG'
    expect(page).to have_content 'Buffet Giramundo'
    expect(page).to have_content 'Localizado em São Paulo - SP'
    expect(page).to have_content 'Buffet Buffet Grande Família'
    expect(page).to have_content 'Localizado em Rio de Janeiro - RJ'

  end

  it 'acessa a página de detalhes de um Buffet'do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')
    owner_third = Owner.create!(email: 'ownerother@test.com', password: '123456')

    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)

    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '(11)97895-9999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)

    buffet = Buffet.create!(brand_name: 'Buffet Grande Família', corporate_name: 'Grande Família LTDA', city: 'Rio de Janeiro',
                          state:'RJ', address: 'Av 7 de Setembro, 101', register_number: '40386821000122', 
                          phone_number: '(21)94563-9999', district: 'Centro', zip_code: '21000-000',
                          payment_methods: 'Pix', description: 'Churrascaria', owner: owner_third)



    visit root_path
    click_on 'Listar Buffets'
    click_on 'Chinas Buffet'

    expect(page).to have_content 'Chinas Buffet' 
    expect(page).to have_content 'Chinas Buffet | CNPJ: 75889767000112 | Telefone: (32)99999-9999' 
    expect(page).to have_content 'Rua: Rua Principal, 42 | Bairro: Centro | Cidade: Juiz de Fora - MG | (CEP: 32000-000)' 
    expect(page).to have_content 'Descrição: Buffets e eventos | Forma(s) de pagamento(s): Pix'

  end

  it 'realiza uma busca' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')
    owner_third = Owner.create!(email: 'ownerother@test.com', password: '123456')
  
    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)
  
    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '(11)97895-9999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)
  
    buffet = Buffet.create!(brand_name: 'Buffet Grande Família', corporate_name: 'Grande Família LTDA', city: 'Rio de Janeiro',
                          state:'RJ', address: 'Av 7 de Setembro, 101', register_number: '40386821000122', 
                          phone_number: '(21)94563-9999', district: 'Centro', zip_code: '21000-000',
                          payment_methods: 'Pix', description: 'Churrascaria', owner: owner_third)

  visit root_path
  fill_in 'Busca', with: 'Chu'  
  click_on 'Buscar'
  
  expect(current_path).to eq search_path
  expect(page).not_to have_content 'Buffet Chinas Buffet'
  expect(page).not_to have_content 'Localizado em Juiz de Fora - MG'
  expect(page).to have_content 'Buffet Giramundo'
  expect(page).to have_content 'Localizado em São Paulo - SP'
  expect(page).to have_content 'Buffet Buffet Grande Família'
  expect(page).to have_content 'Localizado em Rio de Janeiro - RJ'
  end
  
end

