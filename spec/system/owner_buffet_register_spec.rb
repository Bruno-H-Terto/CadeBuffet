require 'rails_helper'

RSpec.describe 'Proprietário registra seu Buffet' do
  it 'a partir da página inicial' do
    login()

    expect(current_path).to eq new_buffet_path

  end

  it 'e é obrigado a concluir o cadastro' do
    login()
    visit root_path
    
    expect(page).to have_content 'Registre o Buffet para prosseguir!'
    expect(current_path).to eq new_buffet_path

  end

  it 'e desloga sem registrar em seguida' do
    login()
    click_on 'Sair'
    
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(current_path).to eq root_path

  end
  it 'e cadastra com sucesso' do
    login()
  
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

    expect(page).to have_content 'Buffet salvo com sucesso!'
  end

  it 'e falha por não poder ter mais de um Buffet registrado para o mesmo usuário' do
    login()

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
    visit new_buffet_path 

    expect(page).to have_content 'Propietário já está em uso!'

  end
  
  it 'e falha por deixar campos vazios' do
    login()

    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Telefone', with: '(32) 3200-0000'
    fill_in 'Endereço', with: 'Rua Teste, nº 00'
    fill_in 'Bairro', with: 'Bairro Teste'
    fill_in 'Estado', with: 'Estado Teste'
    fill_in 'Cidade', with: 'Cidade Teste'
    fill_in 'CEP', with: '123456789'
    fill_in 'Descrição', with: 'Descrição Teste'
    fill_in 'Formas de Pagamento', with: 'Pagamentos Teste'

    click_on 'Gravar'

    expect(page).to have_content 'Não foi possível concluir está operação.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'

  end
end