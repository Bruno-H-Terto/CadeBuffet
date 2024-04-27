require 'rails_helper'

RSpec.describe PriceEvent, type: :model do
  describe '#valid?'do
    it 'Todos os campos validos' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.new(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)
  
  
      result = price_event.valid?

      expect(result).to eq true
    end

    it 'Valor base fins de semana é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.new(min_price_weekend: '', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)
  
  
      result = price_event.valid?

      expect(result).to eq false
    end

    it 'Valor base dias úteis é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.new(min_price_weekend: '1000', min_price_working_day: '', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)
  
  
      result = price_event.valid?

      expect(result).to eq false
    end

    it 'Hora extra finais de semana é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.new(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)
  
  
      result = price_event.valid?

      expect(result).to eq false
    end

    it 'Hora extra dias úteis é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.new(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)
  
  
      result = price_event.valid?

      expect(result).to eq false
    end

    it 'Valor adicional por pessoa fins de semana é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.new(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '', additional_price_for_person_working_day: '100', event: event)
  
  
      result = price_event.valid?

      expect(result).to eq false
    end

    it 'Valor adicional por pessoa dias útes é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '20', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.new(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '', event: event)
  
  
      result = price_event.valid?

      expect(result).to eq false
    end


    it 'O preço deve estar associado a um evento' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '(32)99999-9999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      price_event = PriceEvent.new(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                  additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100')


      result = price_event.valid?

      expect(result).to eq false
    end
  end
end
