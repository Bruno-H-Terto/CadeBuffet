require 'rails_helper'

describe 'Proprietário edita seu evento' do

  it 'e edita com sucesso' do
    register_event

    click_on 'Festa de 15 anos'
    click_on 'Editar informações'
    fill_in 'Nome', with: 'Festa de 15 anos e formatura'
    fill_in 'Quantidade mínima de pessoas', with: '30'
    fill_in 'Quantidade máxima de pessoas', with: '50'
    fill_in 'Duração em minutos', with: '300'
    fill_in 'Cardápio', with: 'Salgados e refrigerante'
    uncheck 'Bebidas alcoólicas?'
    check 'Decoração?'
    check 'Estacionamento?'
    check 'Valet?'
    fill_in 'Descrição', with: 'Eventos para festas de 15 anos'
    uncheck 'Evento fixo?'
    fill_in 'Valor base do evento (finais de semana)', with: '15000'
    fill_in 'Adicional por pessoa (finais de semana)', with: '400'
    fill_in 'Hora extra (finais de semana)', with: '700'
    fill_in 'Valor base do evento (dias úteis)', with: '13000'
    fill_in 'Adicional por pessoa (dias úteis)', with: '300'
    fill_in 'Hora extra (dias úteis)', with: '500'
    click_on 'Registrar'

    expect(page).to have_content 'Evento atualizado com sucesso!'
  end

  it 'Falha ao deixar campos do evento em branco' do
    register_event

    click_on 'Festa de 15 anos'
    click_on 'Editar informações'
    fill_in 'Nome', with: ''
    fill_in 'Quantidade mínima de pessoas', with: ''
    fill_in 'Quantidade máxima de pessoas', with: '50'
    fill_in 'Duração em minutos', with: '300'
    fill_in 'Cardápio', with: 'Salgados e refrigerante'
    uncheck 'Bebidas alcoólicas?'
    check 'Decoração?'
    check 'Estacionamento?'
    check 'Valet?'
    fill_in 'Descrição', with: 'Eventos para festas de 15 anos'
    uncheck 'Evento fixo?'
    fill_in 'Valor base do evento (finais de semana)', with: '15000'
    fill_in 'Adicional por pessoa (finais de semana)', with: '400'
    fill_in 'Hora extra (finais de semana)', with: '700'
    fill_in 'Valor base do evento (dias úteis)', with: '13000'
    fill_in 'Adicional por pessoa (dias úteis)', with: '300'
    fill_in 'Hora extra (dias úteis)', with: '500'
    click_on 'Registrar'

    expect(page).to have_content 'Não foi possível atualizar seu Evento.'
    expect(page).to have_content 'Reveja os campos abaixo:'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Quantidade mínima de pessoas não pode ficar em branco'
  end

  it 'Falha ao deixar campos do preço em branco' do
    register_event

    click_on 'Festa de 15 anos'
    click_on 'Editar informações'
    fill_in 'Nome', with: 'Festa de 15 anos e formatura'
    fill_in 'Quantidade mínima de pessoas', with: '30'
    fill_in 'Quantidade máxima de pessoas', with: '50'
    fill_in 'Duração em minutos', with: '300'
    fill_in 'Cardápio', with: 'Salgados e refrigerante'
    uncheck 'Bebidas alcoólicas?'
    check 'Decoração?'
    check 'Estacionamento?'
    check 'Valet?'
    fill_in 'Descrição', with: 'Eventos para festas de 15 anos'
    uncheck 'Evento fixo?'
    fill_in 'Valor base do evento (finais de semana)', with: '15000'
    fill_in 'Adicional por pessoa (finais de semana)', with: ''
    fill_in 'Hora extra (finais de semana)', with: '700'
    fill_in 'Valor base do evento (dias úteis)', with: '13000'
    fill_in 'Adicional por pessoa (dias úteis)', with: ''
    fill_in 'Hora extra (dias úteis)', with: '500'
    click_on 'Registrar'

    expect(page).to have_content 'Não foi possível atualizar seu Evento.'
    expect(page).to have_content 'Reveja os campos abaixo:'
    expect(page).to have_content 'Adicional por pessoa (finais de semana) não pode ficar em branco'
    expect(page).to have_content 'Adicional por pessoa (dias úteis) não pode ficar em branco'
  end
  it 'falha e vizualiza formulário parcialmente preenchido ' do
    register_event

    click_on 'Festa de 15 anos'
    click_on 'Editar informações'

    fill_in 'Nome', with: ''
    fill_in 'Quantidade mínima de pessoas', with: ''
    fill_in 'Quantidade máxima de pessoas', with: '50'
    fill_in 'Duração em minutos', with: ''
    fill_in 'Cardápio', with: 'Salgados e refrigerante'
    uncheck 'Bebidas alcoólicas?'
    check 'Decoração?'
    check 'Estacionamento?'
    check 'Valet?'
    fill_in 'Descrição', with: 'Eventos para festas de 15 anos'
    uncheck 'Evento fixo?'
    fill_in 'Valor base do evento (finais de semana)', with: '15000'
    fill_in 'Adicional por pessoa (finais de semana)', with: ''
    fill_in 'Hora extra (finais de semana)', with: '700'
    fill_in 'Valor base do evento (dias úteis)', with: '13000'
    fill_in 'Adicional por pessoa (dias úteis)', with: ''
    fill_in 'Hora extra (dias úteis)', with: '500'
    click_on 'Registrar'

    expect(page).to have_content 'Não foi possível atualizar seu Evento.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Salgados e refrigerante'

  end
end