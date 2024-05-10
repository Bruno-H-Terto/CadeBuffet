include ActionView::Helpers::NumberHelper 

def login()
  owner = Owner.create!(email: 'owner@test.com', password: '123456')

  visit root_path
  click_on 'Sou Proprietário'
  fill_in 'Email', with: 'owner@test.com'
  fill_in 'Senha', with: '123456'
  click_on 'Entrar'

end

def register_buffet

  login

  fill_in 'Nome Fantasia', with: 'Teste'
  fill_in 'Razão Social', with: 'Teste LTDA'
  fill_in 'CNPJ', with: '08782544000164'
  fill_in 'Telefone', with: '3232000000'
  fill_in 'Endereço', with: 'Rua Teste, nº 00'
  fill_in 'Bairro', with: 'Bairro Teste'
  fill_in 'Estado', with: 'Estado Teste'
  fill_in 'Cidade', with: 'Cidade Teste'
  fill_in 'CEP', with: '123456789'
  fill_in 'Descrição', with: 'Descrição Teste'
  find("#buffet_payment_methods_pix").click
  find("#buffet_payment_methods_dinheiro").click

  click_on 'Gravar'
end

def register_event
  register_buffet
  click_on 'Cadastrar novo evento'

  fill_in 'Nome', with: 'Festa de 15 anos'
  fill_in 'Quantidade mínima de pessoas', with: '10'
  fill_in 'Quantidade máxima de pessoas', with: '50'
  fill_in 'Duração em minutos', with: '120'
  fill_in 'Cardápio', with: 'Salgados e refrigerante'
  uncheck 'Bebidas alcoólicas?'
  check 'Decoração?'
  check 'Estacionamento?'
  check 'Valet?'
  fill_in 'Descrição', with: 'Eventos para festas de 15 anos'
  check 'Evento fixo?'
  fill_in 'Valor base do evento (finais de semana)', with: '14000'
  fill_in 'Adicional por pessoa (finais de semana)', with: '300'
  fill_in 'Hora extra (finais de semana)', with: '600'
  fill_in 'Valor base do evento (dias úteis)', with: '12000'
  fill_in 'Adicional por pessoa (dias úteis)', with: '150'
  fill_in 'Hora extra (dias úteis)', with: '450'
  click_on 'Registrar'
end

def login_client(user)
  visit root_path
  click_on 'Sou Cliente'
  fill_in 'Email', with: user.email
  fill_in 'Senha', with: user.password
  click_on 'Entrar'
end

