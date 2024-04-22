require 'rails_helper'

RSpec.describe 'Proprietário cadastra um evento'do
  it 'logo após concluir o cadastro de seu Buffet' do
    owner = Owner.create!(email: 'owner@test.com', password: '123456')

    visit root_path
    click_on 'Sou Proprietário'
    fill_in 'Email', with: 'owner@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    fill_in 'Nome Fantasia', with: 'Teste'
    fill_in 'Razão Social', with: 'Teste LTDA'
    fill_in 'CNPJ', with: '12345678900'
    fill_in 'Telefone', with: '(32) 3200-0000'
    fill_in 'Endereço', with: 'Rua Teste, nº 00'
    fill_in 'Bairro', with: 'Bairro Teste'
    fill_in 'Estado', with: 'Estado Teste'
    fill_in 'Cidade', with: 'Cidade Teste'
    fill_in 'CEP', with: '123456789'
    fill_in 'Descrição', with: 'Descrição Teste'
    fill_in 'Formas de Pagamento', with: 'Pagamentos Teste'

    click_on 'Gravar'

    expect(page).to have_content 'Buffet Teste - Teste LTDA 12345678900 - (32) 3200-0000'
    expect(page).to have_content 'Rua Teste, nº 00, Bairro: Bairro Teste, Cidade: Cidade Teste - Estado Teste'
    expect(page).to have_content 'Descrição Teste - Pagamentos Teste'
    expect(page).to have_content('Cadastrar novo evento')
  end
end