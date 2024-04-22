require 'rails_helper'

RSpec.describe 'Proprietário registra preço' do
  it 'acessa o formulário' do
    register_event
    
    click_on 'Valores para Festa de 15 anos'

    expect(current_path).to eq new_buffets_price_event_path
  end
end