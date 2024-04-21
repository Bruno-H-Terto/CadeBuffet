require 'rails_helper'

RSpec.describe 'Proprietário registra seu Buffet' do
  it 'a partir da página inicial' do
    owner = Owner.create(email: 'owner@test.com', password: '123456')

    visit dashboard_path
    click_on 'Sou Proprietário'
    fill_in 'Email', with: 'owner@test.com'
    fill_in 'Password', with: '123456'
    click_on 'Log in'

    expect(current_path).to eq buffets_root_path

  end
end