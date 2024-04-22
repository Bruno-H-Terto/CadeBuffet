require 'rails_helper'

RSpec.describe 'Proprietário cadastra um evento'do
  it 'logo após concluir o cadastro de seu Buffet' do

    register_buffet

    expect(page).to have_content 'Buffet Teste - Teste LTDA 12345678900 - (32) 3200-0000'
    expect(page).to have_content 'Rua Teste, nº 00, Bairro: Bairro Teste, Cidade: Cidade Teste - Estado Teste'
    expect(page).to have_content 'Descrição Teste - Pagamentos Teste'
    expect(page).to have_content('Cadastrar novo evento')
    expect(page).to have_content('Não existem eventos Cadastrados')
  end

  it 'com sucesso'do

    register_buffet
    fill_in 'Nome', with: 'Festa de 15 anos'
    fill_in 'Quantidade mínima de pessoas', with: '10'
    fill_in 'Quantidade máxima de pessoas', with: '50'
    fill_in 'Duração em minutos', with: '120'
    fill_in 'Cardápio', with: 'Salgados e refrigerante'
    uncheck 'Bebidas alcoólicas?'
    check 'Decoração?'
    check 'Estacionamento?'
    check 'Valet?'
    fill_in 'Descrição', with: 'Eventos para festas de 15 anos'
    check 'Evento fixo?'
    click_on 'Registrar'

    expect(current_path).to eq buffets_buffet_path(Buffet.last)
    expect(page).to have_content 'Evento registrado com sucesso!'
    expect(page).to have_content 'Festa de 15 anos'
    expect(page).to have_content 'Eventos para festas de 15 anos'

  end

  it 'e falha por deixar campos vazios'do

    register_buffet
    fill_in 'Nome', with: 'Evento de formatura'
    fill_in 'Quantidade mínima de pessoas', with: ''
    fill_in 'Quantidade máxima de pessoas', with: ''
    fill_in 'Duração em minutos', with: '120'
    fill_in 'Cardápio', with: 'Salgados e refrigerante'
    uncheck 'Bebidas alcoólicas?'
    check 'Decoração?'
    check 'Estacionamento?'
    check 'Valet?'
    fill_in 'Descrição', with: 'Eventos para festas de 15 anos'
    check 'Evento fixo?'
    click_on 'Registrar'

    expect(page).to have_content 'Não foi possível concluir está operação.'
    expect(page).to have_content 'Eventos para festas de 15 anos'
  

  end
end