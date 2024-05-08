require 'rails_helper'

RSpec.describe 'Propritério edita seu Buffet' do
  it 'e não é o dono' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')


    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)

    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)


    login_as owner_second
    patch(buffet_path(buffet_first.id), params: {brand_name: 'Comida brasileira'})

    expect(response).to redirect_to root_path

  end

  it 'tenta acessar tela de edição de outro Buffet' do
    owner_first = Owner.create!(email: 'owner1234@test.com', password: '123456')
    owner_second= Owner.create!(email: 'ownersecond@test.com', password: '123456')


    buffet_first = Buffet.create!(brand_name: 'Chinas Buffet', corporate_name: 'China LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner_first)

    buffet_second = Buffet.create!(brand_name: 'Giramundo', corporate_name: 'Giramundo LTDA', city: 'São Paulo',
                          state:'SP', address: 'Rua Nova, 75', register_number: '83448951000155', 
                          phone_number: '11978959999', district: 'Centro', zip_code: '11000-000',
                          payment_methods: 'Cartão, dinheiro', description: 'Churrascaria', owner: owner_second)


    login_as owner_second
    get(edit_buffet_path(buffet_first.id), params: {brand_name: 'Comida brasileira'})

    expect(response).to redirect_to root_path
  end
end