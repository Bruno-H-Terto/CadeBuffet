require 'rails_helper'

describe 'Proprietário acessa a página'do
  it 'e é enviado para autenticação'do
    visit root_path
    click_on 'Sou Proprietário'

    expect(page).to have_field 'Email'
    expect(page).to have_field 'Senha'
    
  end

  it 'e realiza seu cadastro' do
    visit root_path
    click_on 'Sou Proprietário'
    click_on 'Cadastrar'
    fill_in 'Email', with: 'onwer1234@test.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'
    click_on 'Cadastrar'

    expect(page).to have_content 'Registre o Buffet para prosseguir!'
  end
end