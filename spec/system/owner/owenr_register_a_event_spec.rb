require 'rails_helper'

describe 'Proprietário cadastra um evento'do
  it 'e localiza o link logo após concluir o cadastro de seu Buffet' do

    register_buffet

    expect(page).to have_content('Cadastrar novo evento')

  end

  it 'com sucesso'do

    register_buffet
    click_on 'Cadastrar novo evento'

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
    fill_in 'Valor base do evento (finais de semana)', with: '10000'
    fill_in 'Adicional por pessoa (finais de semana)', with: '100'
    fill_in 'Hora extra (finais de semana)', with: '300'
    fill_in 'Valor base do evento (dias úteis)', with: '12000'
    fill_in 'Adicional por pessoa (dias úteis)', with: '150'
    fill_in 'Hora extra (dias úteis)', with: '450'
   
    click_on 'Registrar'


    expect(page).to have_content 'Evento registrado com sucesso!'
    expect(page).to have_content 'Festa de 15 anos'


  end

  it 'e falha por deixar campos do evento vazios'do

    register_buffet
    click_on 'Cadastrar novo evento'

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

    expect(page).to have_content 'Não foi possível cadastrar seu Evento.'
    expect(page).to have_content 'Reveja os campos abaixo:'
    expect(page).to have_content 'Quantidade mínima de pessoas não pode ficar em branco'
    expect(page).to have_content 'Quantidade máxima de pessoas não pode ficar em branco'
  

  end

  it 'e falha por não preencher valores'do

    register_buffet
    click_on 'Cadastrar novo evento'

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
    fill_in 'Valor base do evento (finais de semana)', with: ''
    fill_in 'Adicional por pessoa (finais de semana)', with: '100'
    fill_in 'Hora extra (finais de semana)', with: ''
    fill_in 'Valor base do evento (dias úteis)', with: '12000'
    fill_in 'Adicional por pessoa (dias úteis)', with: '150'
    fill_in 'Hora extra (dias úteis)', with: '450'
    click_on 'Registrar'

    expect(page).to have_content 'Não foi possível cadastrar seu Evento.'
    expect(page).to have_content 'Reveja os campos abaixo:'
    expect(page).to have_content 'Valor base do evento (finais de semana) não pode ficar em branco'
    expect(page).to have_content 'Hora extra (finais de semana) não pode ficar em branco'
  

  end

end