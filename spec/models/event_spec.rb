require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#valid?'do
    it 'Todos os campos validos' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
  
      result = event.valid?

      expect(result).to eq true
    end

    it 'Nome é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: '', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
  
      result = event.valid?

      expect(result).to eq false
    end

    it 'Quantidade mínima de pessoas é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: 'Festa de formatura', min_quantity_people: '', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
  
      result = event.valid?

      expect(result).to eq false
    end

    it 'Quantidade máxima de pessoas é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
  
      result = event.valid?

      expect(result).to eq false
    end

    it 'Duração é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
  
      result = event.valid?

      expect(result).to eq false
    end

    it 'Menu é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: '', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
  
      result = event.valid?

      expect(result).to eq false
    end

    it 'Descrição é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: '', owner: owner, buffet: buffet)
  
  
      result = event.valid?

      expect(result).to eq false
    end

    it 'Proprietário é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', buffet: buffet)
  
  
      result = event.valid?

      expect(result).to eq false
    end

    it 'Buffet é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner)
  
  
      result = event.valid?

      expect(result).to eq false
    end

    it 'Número máximo de pessoas deve ser maior ou igual ao mínimo' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.new(name: 'Festa de formatura', min_quantity_people: '20', max_quantity_people: '10', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)
  
  
      result = event.valid?

      expect(result).to eq false
    end
  end
end
