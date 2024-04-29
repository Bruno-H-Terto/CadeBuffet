require 'rails_helper'

describe 'Cliente acessa a plataforma' do


  it 'e falha ao deixar o nome e CPF em branco'do
    visit root_path
    click_on 'Sou Cliente'
    click_on 'Cadastrar'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'Email', with: 'josep@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'

    expect(page).to have_content 'Não foi possível salvar cliente'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
  end

  it 'e se cadastra com sucesso'do
    visit root_path
    click_on 'Sou Cliente'
    click_on 'Cadastrar'
    fill_in 'Nome', with: 'José'
    fill_in 'CPF', with: '62260204074'
    fill_in 'Email', with: 'josep@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'

    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso.'
    expect(current_path).to eq root_path
  end

  it 'e realiza log in' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

    visit root_path
    click_on 'Sou Cliente'
    fill_in 'Email', with: 'jose1@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'José - 617******36'
  end

  it 'não possui autorização para criar um Buffet' do
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

    visit root_path
    click_on 'Sou Cliente'
    fill_in 'Email', with: 'jose1@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Entrar'
    visit new_buffet_path

    expect(page).to have_content 'Usuário não autorizado. Clique em sair e acesse a página com o login Proprietário.'
  end
end