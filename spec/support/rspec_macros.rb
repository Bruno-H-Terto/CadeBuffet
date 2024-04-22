def login()
  owner = Owner.create!(email: 'owner@test.com', password: '123456')

  visit root_path
  click_on 'Sou Proprietário'
  fill_in 'Email', with: 'owner@test.com'
  fill_in 'Password', with: '123456'
  click_on 'Log in'

end

def register_buffet

  login

  fill_in 'Nome Fantasia', with: 'Teste'
  fill_in 'Razão Social', with: 'Teste LTDA'
  fill_in 'CNPJ', with: '12345678900'
  fill_in 'Telefone', with: '(32) 3200-0000'
  fill_in 'Endereço', with: 'Rua Teste, nº 00'
  fill_in 'Bairro', with: 'Bairro Teste'
  fill_in 'Estado', with: 'Estado Teste'
  fill_in 'Cidade', with: 'Cidade Teste'
  fill_in 'CEP', with: '123456789'
  fill_in 'Descrição', with: 'Descrição Teste'
  fill_in 'Formas de Pagamento', with: 'Pagamentos Teste'

  click_on 'Gravar'
end

def register_event
  register_buffet

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
  click_on 'Registrar'
end