require 'rails_helper'

RSpec.describe Buffet, type: :model do
  describe '#valid?'do
    it 'Todos os campos validos' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq true
    end

    it 'Nome Fantasia é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: '', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'Razão Social é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: '', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'Cidade é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: '',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'Estado é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'Endereço é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: '', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'CNPJ é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'Telefone é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'Bairro é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: '', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'CEP é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'Métodos para pagamento são obrigatórios' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: '', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'Descrição é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: '', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'Proprietário é obrigatório' do
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123456789123456', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos')
   
   
      result = buffet.valid?

      expect(result).to eq false
    end

    it 'CNPJ é um número' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.new(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '123asd', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)
   
   
      result = buffet.valid?

      expect(result).to eq false
    end
  end
end
