require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?'do
    it 'todos os campos validos' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

      order = Order.new(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 90, details: 'Formandos da UFJF, turma 2018.1',
                            address: buffet.full_address, client: client)

      result = order.valid?

      expect(result).to eq true
    end

    it 'data de realização é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

      order = Order.new(buffet: buffet, event: event, estimated_date: '', estimated_people: 90, details: 'Formandos da UFJF, turma 2018.1',
                            address: buffet.full_address, client: client)

      result = order.valid?

      expect(result).to eq false
    end

    it 'número de convidados é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

      order = Order.new(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: '', details: 'Formandos da UFJF, turma 2018.1',
                            address: buffet.full_address, client: client)


      result = order.valid?

      expect(result).to eq false
    end

    it 'observações é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

      order = Order.new(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 90, details: '',
                            address: buffet.full_address, client: client)


      result = order.valid?

      expect(result).to eq false
    end


    it 'endereço é obrigatório' do
      owner = Owner.create!(email: 'owner@test.com', password: '123456')
      client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

      buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                          state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                          phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                          payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

      event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                        menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                        description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

      price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                   additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

      order = Order.new(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 90, details: 'Formandos da UFJF, turma 2018.1',
                            address: '', client: client)


      result = order.valid?

      expect(result).to eq false
    end

  end


  it 'numero de convidados não deve ultrapassar a capacidade do evento' do
    owner = Owner.create!(email: 'owner@test.com', password: '123456')
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

    buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                        state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                        phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                        payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

    event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                      menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                      description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

    price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                 additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

    order = Order.new(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 91, details: 'Formandos da UFJF, turma 2018.1',
                          address: buffet.full_address, client: client)


    result = order.valid?

    expect(result).to eq false
  end


  it 'código é aleatório' do
    owner = Owner.create!(email: 'owner@test.com', password: '123456')
    client = Client.create!(name: 'José', email: 'jose1@email.com', register_number: '61795864036', password: '123456')

    buffet = Buffet.create!(brand_name: 'Buffet teste', corporate_name: 'Buffet teste LTDA', city: 'Juiz de Fora',
                        state:'MG', address: 'Rua Principal, 42', register_number: '75889767000112', 
                        phone_number: '32999999999', district: 'Centro', zip_code: '32000-000',
                        payment_methods: 'Pix', description: 'Buffets e eventos', owner: owner)

    event = Event.create!(name: 'Festa de formatura', min_quantity_people: '10', max_quantity_people: '90', duration_in_minutes: '60',
                      menu: 'A definir', alcoholic_drink: false, self_decoration: true, parking: true, valet: false, fixed_location: true,
                      description: 'Especialidade em formaturas', owner: owner, buffet: buffet)

    price_event = PriceEvent.create!(min_price_weekend: '1000', min_price_working_day: '900', extra_hour_weekend: '200', extra_hour_working_day: '150',
                                 additional_price_for_person_weekend: '150', additional_price_for_person_working_day: '100', event: event)

    order_1 = Order.create!(buffet: buffet, event: event, estimated_date: Date.today + 10, estimated_people: 90, details: 'Formandos da UFJF, turma 2018.1',
                          address: buffet.full_address, client: client)

    order_2 = Order.create!(buffet: buffet, event: event, estimated_date: Date.today + 15, estimated_people: 50, details: 'Formandos da UFMG, turma 2018.3',
                          address: buffet.full_address, client: client)


    result = (order_1.code == order_2)

    expect(result).to eq false
  end
end
