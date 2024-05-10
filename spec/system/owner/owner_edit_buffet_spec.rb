require 'rails_helper'

describe 'Proprietário edita seu Buffet' do
  it 'e acessa o formulário' do
    register_buffet
    click_on 'Editar dados do Buffet'

    expect(page).to have_content 'Edite seu Buffet'
  end

  it 'com sucesso' do
    register_buffet
    click_on 'Editar dados do Buffet'
    fill_in 'Nome Fantasia', with: 'Americano'
    fill_in 'Razão Social', with: 'Americano LTDA'
    fill_in 'CNPJ', with: '27157960000116'
    fill_in 'Telefone', with: '3232000000'
    fill_in 'Endereço', with: 'Rua Nova, nº 00'
    fill_in 'Bairro', with: 'Bairro Novo'
    fill_in 'Estado', with: 'Estado Novo'
    fill_in 'Cidade', with: 'Cidade Teste'
    fill_in 'CEP', with: '8947562'
    fill_in 'Descrição', with: 'Descrição Teste'
    find("#buffet_payment_methods_pix").click
    find("#buffet_payment_methods_dinheiro").click
    find("#buffet_payment_methods_cartão_de_crédito").click

  
    click_on 'Gravar'

    expect(page).to have_content 'Buffet atualizado com sucesso!'
    expect(page).to have_content 'Buffet Americano | Americano LTDA CNPJ: 27157960000116 | (32) 32000000'
    expect(page).to have_content 'Forma(s) de pagamento(s): Pix, Dinheiro, Cartão de crédito'
  end
end