require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#valid?' do

    it 'CPF é único' do
      client1 = Client.create(name: 'José', email: 'jose@email.com', register_number: '62260204074', password: '123456')
      client2 = Client.create(name: 'Amadeu', email: 'amadeu@email.com', register_number: '62260204074', password: '456789')

      result = client2.valid?

      expect(result).to eq false
    end

    it 'CPF é obrigatório' do
      client2 = Client.create(name: 'Amadeu', email: 'amadeu@email.com', register_number: '', password: '456789')

      result = client2.valid?

      expect(result).to eq false
    end

    it 'Nome é obrigatório' do
      client2 = Client.create(name: '', email: 'amadeu@email.com', register_number: '62260204074', password: '456789')

      result = client2.valid?

      expect(result).to eq false
    end


    it 'CPF precisa ser valido' do
      client2 = Client.create(name: 'Amadeu', email: 'amadeu@email.com', register_number: '1457', password: '456789')

      result = client2.valid?

      expect(result).to eq false
    end


    it 'CPF é um número' do
      client2 = Client.create(name: 'Amadeu', email: 'amadeu@email.com', register_number: 'abcdefghijk', password: '456789')

      result = client2.valid?

      expect(result).to eq false
    end

    it 'CPF deve conter 11 numeros' do
      client2 = Client.create(name: 'Amadeu', email: 'amadeu@email.com', register_number: '6226020407', password: '456789')

      result = client2.valid?

      expect(result).to eq false
    end
  end
end
