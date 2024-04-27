require 'rails_helper'

describe 'Proprietário edita seu evento' do
  it 'a partir da página de consulta do buffet cadastrado'do
    register_event

    click_on 'Festa de 15 anos'
    
    expect(page).to have_content 'Festa de 15 anos'
    expect(page).to have_content 'Festa de 15 anos - Eventos para festas de 15 anos'
    expect(page).to have_content 'Capacidade de 10 à 50 pessoas'
    expect(page).to have_content 'Duração de 120 minutos'
    expect(page).to have_content 'Cardápio: Salgados e refrigerante'
    expect(page).to have_content 'Sem bebida alcoólica'
    expect(page).to have_content 'Decoração própria'
    expect(page).to have_content 'Estacionamento disponível'
    expect(page).to have_content 'Valet disponível'
    expect(page).to have_content 'Local fixo'
    expect(page).to have_content 'Valores nos dias úteis: R$ 12.000,00 com adicional por pessoa de R$ 150,00 + Hora extra de R$ R$ 450,00'
    expect(page).to have_content 'Valores nos fins de semana: R$ 14.000,00 com adicional por pessoa de R$ 300,00 + Hora extra de R$ R$ 600,00'
    expect(page).to have_content 'Editar informações'
  end

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
end