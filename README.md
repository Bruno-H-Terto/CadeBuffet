# Cadê Buffet

![Ruby on Rails](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTb_StgJi8yn-R4opsDlXUT-GLttJEJW9oiALTAPlr6cA&s)

> Status: Em desenvolvimento

Cadê Buffet é uma aplicação de gerenciamento de Buffets, desenvolvida no treinamento TreinaDev por Bruno Herculano, Turma 12. Nela temos três tipos de usuários: proprietário, cliente e visitante. Apenas os dois primeiros necessitam de autenticação, com permissões delimitadas ao contexto de cada usuário.

## Tecnologias Necessárias
- [Ruby 3.2.1](https://www.ruby-lang.org/en/news/2023/02/08/ruby-3-2-1-released/)
- [Node v20.12.2 (LTS)](https://nodejs.org/en/blog/release/v20.12.2)
- [Rails 7.1.3.2](https://rubygems.org/gems/rails/versions/7.1.3.2)
- Sqlite3 3.37.2

## 1 - Gems Utilizadas
- [Rspec Rails](https://github.com/rspec/rspec-rails)
- [Capybara](https://github.com/teamcapybara/capybara)
- [Devise](https://github.com/heartcombo/devise)

## 2 - Configuração
1. Clone o repositório e entre na pasta do projeto:
   ```sh
   git clone https://github.com/Bruno-H-Terto/CadeBuffet.git
   cd CadeBuffet
   ```

Para seu correto funcionamento, torna-se necessário as seguintes tecnologias:
  1. Versão [ruby 3.2.1](https://www.ruby-lang.org/en/news/2023/02/08/ruby-3-2-1-released/)
  1. [Node v20.12.2(LTS)](https://nodejs.org/en/blog/release/v20.12.2)
  1. [Rails 7.1.3.2](https://rubygems.org/gems/rails/versions/7.1.3.2)
  1. Sqlite3 3.37.2

#### 2.1 - Instale as dependências e configure o banco de dados:

1. Execute
   ```sh
    bundle install
    rails db:migrate
    ```

A aplicação já conta com usuários, buffets e eventos cadastrados. Recomendamos o uso para fins de teste dos usuários:
  1. Proprietário: email = 'ownertest@email.com 'e senha = '123456';
  1. Cliente: email = 'clienttest@email.com' e senha = '123456'.

### 3 - Execução de Testes

Para executar os testes, utilize o seguinte comando:
    ```
      rspec
    ```

(Os arquivos de testes estão localizados em ./spec)

### 4 - Funcionamento da aplicação
Está secção aborda o funcionamento da aplicação do ponto de vista dos três usuários possíveis: Proprietários de Buffets, Clientes e visitantes:

#### 4.1 - Proprietários
* Um proprietário deve se registrar na plataforma através do link presente na página inicial "*Sou proprietário*". Também, o acesso na plataforma se limita aos dados de seu próprio Buffet, sendo possível no **máximo** a consulta de dados fornecidos nativamente pela plataforma de outros Buffets e Eventos.
* Para se registrar são necessários um email e uma senha de minimo 6 caracteres. Uma vez devidamente registrado, o proprietário **deve** realizar o registro de seu Buffet, sendo impedido sua navegação pela plataforma até que o mesmo conclua este cadastro. O Buffet conta com o registro de campos obrigatórios como: 
  - Razão social; 
  - Nome fantasia; 
  - CNPJ único e [válido](https://www.campuscode.com.br/conteudos/o-calculo-do-digito-verificador-do-cpf-e-do-cnpj) (porém está verificação só diz respeito aos dígitos validadores);
  -  Um telefone para contato nacional no formato "*DDxxxxxxxx*" ou em celular com mais um dígito adicional;
  - Endereço completo;
  - Formas de pagamento.
* Concluído o registro, o proprietário terá a disponibilidade de cadastrar eventos, na área reservada "*Meu Buffet*".
* O registro de um novo evento necessita de informações obrigatórias como: Número máximo e mínimo de convidados; Nome e descrição; Valores para dias úteis e fins de semana. Após a conclusão deste cadastro, o Buffet estará apto a receber pedidos de clientes interessados.

##### 4.1.1 - Pedidos
Uma vez solicitado um pedido para realização de um evento, por um cliente devidamente registrado na plataforma. O proprietário terá a possibilidade de avaliar o pedido, sendo suas opções disponíveis neste momento de aceitar ou recusar o mesmo. Em caso positivo, o pedido liberado terá seu status atualizado e para sua conclusão será necessário aguardar a confirmação do solicitante até um prazo máximo estabelecido pelo Proprietário. Em caso negativo, o pedido será irrefutavelmente cancelado, não havendo opção de reativação.

###### 4.1.1.1 - Considerações sobre pedidos
* Um proprietário tem a possibilidade de aplicar uma taxa adicional ou desconto sobre o valor inicialmente orçado, sendo limitado apenas a um desconto máximo igual ao valor do serviço. 
* A data limite estabelecida para confirmação é de no **máximo** até a data solicitada pelo cliente para realização do evento, ficando sob responsabilidade do proprietário seu correto registro.
* Além disso, pedidos uma vez cadastrados não podem ser editados (tanto pelo cliente, tanto pelo proprietário), está medida visa a evitar quebras de contratos e zelar pela proteção dos envolvidos.
* Qualquer pedido, independente de sua natureza, inicialmente receberá o status de "*Aguardando revisão*", sendo os outros **únicos** status disponíveis: "*Confirmado pelo Buffet*", "*Evento confirmado*" (quando há confirmação de ambas as partes) e "*Evento cancelado*" (quando há o cancelamento de qualquer uma das partes).

#### 4.2 - Clientes
Um cliente tem a possibilidade de solicitar a realização de eventos, bem como consultas e navegações pela platorma em seu escopo de autorização. Fica impossibilitado a um cliente o acesso a qualquer área destinada ao Administrador de um Buffet, bem como o acesso a dados de seus semelhantes usuários da aplicação.

##### 4.2.1 - Cadastro
Um cliente deve informar um nome, email, senha é CPF [válido](https://www.campuscode.com.br/conteudos/o-calculo-do-digito-verificador-do-cpf-e-do-cnpj)  e único. Após estes procedimento, seu acesso já estará liberado.

##### 4.2.2 - Considerações sobre pedidos
Um cliente pode solicitar pedidos para qualquer Buffet em qualquer data futura. O pedido deve atender a especificação da quantidade de convidados estabelecidas pelo Buffet. Uma vez realizado o pedido não pode ser editado, sendo em caso de última necessidade orientado o seu cancelamento. Uma vez confirmado, o Evento não terá opção de cancelamento, ficando a partir daí, sob responsabilidade do Administrador o Evento e o Cliente a garantia do cumprimento do acordado.

#### 4.3 - Visitantes
Visitantes podem apenas consultar Buffets e Eventos sem poder solicitar ou gerenciar eventos.

#### 4.4 - Área de acesso comum
Todos os usuários podem acessar a área de pesquisa e listagem de Buffets e eventos.

### 5 - API
A aplicação *Cadê Buffet* fornece a exposição de uma API com 5 endpoints ativos.
#### 5.1 - Listagem de Buffets
A API fornece a listagem completa de Buffets através o caminho:
> GET `/api/v1/buffets`
* Este caminho retorna a listagem completa em ordem alfabética pelo nome fantasia de todos os Buffets cadastrados na plataforma;
* Esta requisição permite um parâmetro adicional `?brand_name=` que retorna a filtragem da listagem de Buffets em função de seu nome fantasia. Está busca é de correspondência aproximada, tendo retorno para correspondencias não exatas. Além disso, não são aceitos parâmetros adicionais, sendo em caso de não correspondência na busca o retorno de uma mensagem de erro;
* Caso a plataforma não disponha de Buffets em registro é realizado um retorno informando sobre está indisponibilidade.
#### 5.2 - Detalhes de um Buffet
A plataforma fornece um end-point de detalhes para um Buffet:
> GET `/api/v1/buffets/:id`
* Essa filtragem exata é realizada através da passagem de um argumento via parâmetro do ID correspondente do Buffet, sendo este o **único** parâmetro aceito;
* Em caso de sucesso serão listados dados relacionados ao Buffet exceto CNPJ e Razão Social;
* Caso a busca seja má sucedida, a resposta emitida terá status 404 e uma mensagem relatando o erro.

#### 5.3 - Listagem de eventos de um Buffet
É fornecido a opção de listagem de todos os eventos registrados por um Buffet:
> GET `/api/v1/buffets/:buffet_id/events`
* Esta requisição necessita da passagem de um **único** parâmentro *:buffet_id* correspondente ao ID do Buffet de interesse;
* Caso haja correspondência será retornado a listagem dos Buffets em registro correspondentes. Caso contrario, a requisão retornará status 404 acompanhado de uma mensagem de erro;
* Na hipótese de um Buffet não possuir eventos em registro, a aplicação retornará uma mensagem relatando o ocorrido.

#### 5.4 - Detalhes de um evento
É fornecido a opção da listagem de um evento em específico:
> GET `/api/v1/events/:id`
* Diferente da busca anterior, esta necessita como argumento o ID do Evento registrado, sendo este passado via parâmetro. Sendo, parâmetros adicionais ao informado, ignorados;
* Em caso de correspondência serão exibidados referentes ao evento procurado. Em caso contrário, será retornado uma resposta com status 404 e uma mensagem com o erro correspondente.

#### 5.5 - Consulta de disponibilidade de um evento
É fornecido a opção de consulta de disponibilidade de um evento, com base em uma data e a quantidade estimada de convidados:
> GET `/api/v1/events/:id/avaliable_event`
* Esta requisição necessita de três parâmetros para um retorno adequado: o ID do evento, semelhante a funcionalidade anterior de detalhes de um evento; a data estimada para realização do evento; e a quantidade estimada de convidados, sendo estes os únicos parâmetros reconhecidos pela aplicação;
* Caso a requisição obdeça as especificações para seu funcionamento, será avaliado a possibilidade de realização de um evento. Esta avaliação leva em consideração: se a data fornecida não esta agendada para a realização de outro evento e se a quantidade de convidados se encontra dentro das especificações do evento. Neste momento existem duas possibilidades:
  1. O pedido é possível, então logo é retornado o valor orçado para realização;
  1. O pedido não atende uma (ou mais) das especificações descritas, logo, neste caso, é retornado uma mensagem declarando a indisponibilidade, bem como sua justificativa.
* Caso a requisição não apresente os parâmetros necessários (um ou mais deles), é retornado uma resposta com status 404 juntamento com uma mensagem de erro relatando o ocorrido;
* É por fim, caso o ID do evento não encontre correspondência é retornado uma mensagem com status 404 com uma mensagem com erro correspondente.

### 6 - Desafios durante o desenvolvimento

O principal desafio encontrado durante a realização do projeto mencionado diz respeito a gestão e organização de tempo. Sendo todo o processo enriquecedor, levando a desafios e adaptações para sua conclusão. É evidente seu caratér transformador, sendo, até o momento, minha melhor experiência no estudo de desenvolvimento de software.

### 7 - Considerações finais

Independente do resultado, tenho muito a agradecer ao João Almeida e a toda a equipe da Campus Code. Me sinto orgulhoso por ter tido a oportunidade de participar desta edição do TreinaDev e tenha certeza que muitos ainda irão se beneficiar desta iniciativa.

