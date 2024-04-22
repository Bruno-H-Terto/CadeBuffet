require 'rails_helper'

RSpec.describe 'Proprietário registra preço' do
  it 'e acessa o formulário' do
    register_event

    expect(page).to have_field 'Valor mínimo do evento (finais de semana)'
    expect(page).to have_field 'Valor mínimo do evento (dias úteis)'
    expect(page).to have_field 'Valor adicional por pessoa (finais de semana)'
    expect(page).to have_field 'Valor adicional por pessoa (dias úteis)'
    expect(page).to have_field 'Hora extra (finais de semana)'
    expect(page).to have_field 'Hora extra (dias úteis)'

  end

  it 'e acessa o formulário' do
    register_event

    fill_in 'Valor mínimo do evento (finais de semana)', with: '1200'
    fill_in 'Valor mínimo do evento (dias úteis)', with: '1000'
    fill_in 'Valor adicional por pessoa (finais de semana)', with: '120'
    fill_in 'Valor adicional por pessoa (dias úteis)', with: '100'
    fill_in 'Hora extra (finais de semana)', with: '220'
    fill_in 'Hora extra (dias úteis)', with: '200'
    click_on 'Gravar'

    expect(page).to have_content 'Valores salvos com sucesso!'
  end
end