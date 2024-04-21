require 'rails_helper'

RSpec.describe 'Proprietário registra seu Buffet' do
  it 'a partir da página inicial' do
    owner = Owner.create(email: 'owner@test.com', password: '123456')

    visit dashboard_path
    click_on 'Sou Proprietário'
    fill_in 'Email', with: 'owner@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq new_buffets_buffet_path

  end


  it 'e cadastra seu Buffet' do
    owner = Owner.create(email: 'owner@test.com', password: '123456')

    visit dashboard_path
    click_on 'Sou Proprietário'
    fill_in 'Email', with: 'owner@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    fill_in 'Nome Fantasia', with: 'Teste'
    fill_in 'Razão social', with: 'Teste LTDA'
    fill_in 'CNPJ', with: '12345678900'
    fill_in 'Telefone para contato', with: '(32) 3200-0000'
    fill_in 'Endereço', with: 'Rua Teste, nº 00'
    fill_in 'Bairro', with: 'Bairro Teste'
    fill_in 'Estado', with: 'Estado Teste'
    fill_in 'Cidade', with: 'Cidade Teste'
    fill_in 'Descrição', with: 'Descrição Teste'

    
  end
end