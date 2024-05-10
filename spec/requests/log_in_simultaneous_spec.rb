require 'rails_helper'

describe 'Usuário tenta acesso simultâneo de cliente e proprietário' do
  it 'inicialmente de proprietário para cliente' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    owner= Owner.create!(email: 'owner1234@test.com', password: '123456')

    login_as owner

    get new_client_session_path

    expect(response).to redirect_to new_buffet_path
  end

  it 'acessando de cliente para proprietário' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')
    owner= Owner.create!(email: 'owner1234@test.com', password: '123456')

    post client_session_path, params: { client: { email: client.email, password: client.password } }

    get my_company_owner_session_path

    expect(response).to redirect_to root_path
  end
end