# Webscrapper Github

Uma aplicação que faz webscrapping nos perfis do GitHub, encurta a URL base e guarda algumas informações do perfil.

## Dependências e Instalação

* Ruby 3.4.2

* Rails 8.0.2

* PostgreSQL 16.9

Considerando que todas as dependências do projeto já foram instaladas, preparar o Webscrapper Github, execute os comandos abaixo em seu terminal:

```sh
$ bundle install
```

```sh
$ rake db:drop db:create db:migrate db:migrate RAILS_ENV=test
```

## Como Executar

### Aplicação

Para executar esta aplicação, basta entrar na raíz do projeto e executar o comando abaixo em seu terminal:

```sh
$ ./bin/dev
```

### Testes

Para executar os testes desta aplicação, basta entrar na raíz do projeto e executar o comando abaixo em seu terminal:

```sh
$ rspec
```

## Como Funciona

Esta aplicação é iniciada pela rota `root` que renderiza uma lista com todos os perfis cadastrados, um campo de busca e botões de ação para cadastrar um novo perfil ou visualizar/alterar um perfil já cadastrado.

Para cadastrar um novo perfil é necessário clicar no botão `Novo perfil`, preencher as informações do formulário e `Salvar`.

Para atualizar um perfil é necessário localizar o perfil desejado na tela inicial, clicar no botão de `Editar`, preencher as informações do formulário e `Atualizar`.

Para visualizar todos os detalhes do perfil é necessário localizar o perfil desejado na tela inicial, clicar no botão de `Detalhes`.

### Sobre a Arquitetura

Esta é uma arquitetura monolítica com conceitos de clean code, onde cada responsabilidade está bem definida e organizada entre model, controller, service, e view.

Para o model, optei por fazer um modelo simples com poucas responsabilidades, apenas para validar os dados que serão salvos no banco de dados e fazer a busca pelos registros de acordo com um termo.

O controller também tem uma responsabilidade bem definida onde ele apenas chama o service que de fato será o responsável por processar os dados e redirecionar o usuário para a view correspondente de acordo com o resultado do obtido.

Os services, são divididos em 3 propósitos.

  * UrlShortenerService: Este service tem como objetivo único realizar a integração com a api `encurtador.dev` para fazer o encurtamentos das URL dos perfils cadastrados.

  * WebscrapperService: Este service tem como objetivo único fazer o webscrapping nos perfis do GitHub com a utilização da gem `selenium-webdriver`.

  * ProfileService: Este service tem como objetivo tirar a responsabilidade do controller sobre o processamentos dos dados, e desta forma de acordo coma função chamada ele processa os dados e retorna um resultado ou chama os outros services conforme necessário.

Para este projeto, a escolha da arquitetura monolítica serviu muito bem para integrar todos os processos (front, back, integrações, etc...) de forma simples e junto com as divisões de responsabilidade entre as classes, o código ficou limpo e de fácil entendimento.

A escolha do `encurtador.dev` se deve ao fato e que é uma API gratuita e sem limite de uso, prazo de validade e de fácil implementação, o que a torna perfeita para o propósito deste projeto.

Para a escolha `selenium-webdriver` o principal fator foi encontrar uma ferramenta que pudesse navegar livremente pela página alvo respeitando seu tempo de render e elementos dinâmicos.

### Front-end

Para o front-end usei a gem `dartsass-rails`. Com a utilização do Sass pude criar um tema padrão para todo o projeto e assim organizar melhor todo o CSS de forma simples, tornado a mantenção do mesmo muito fácil.

Também foram criadas algumas partials, que servem como componentes simples de elementos que são utilizados recorrentemente, como: botões, inputs, alerta, logo, textos, etc...

No javascript adicionei o `Jquery`, com ele pude simplificar as interações no DOM e trazer algumas ações para a view.

### Testes

Para os testes optei pela utilização das gems `RSpec` (escrita dos testes), `Shoulda Matchers` (simplifica testes de validações em model), `Factory Bot` (fabrica dados previamente definidos), `Faker` (gera dados fictícios) e `Database Cleaner` (apaga os registros do banco de dados de teste)

## Notas adicionais

### Melhorias

Pensando em um futuro algumas melhorias que podem ser feitas são.

  * Dividir ainda mais as responsabilidades do services, principalmente do `ProfileService` (pensando em SOLID), talvez até criar um projeto independente dependendo da escala do projeto.

  * Adicionar mais opções de excessões para trazer mais clareza ao tipo de falha que ocorreu durante um projeto, exemplo: "Usuário já cadastrado", "Falha em fazer o webscrapping", "URL inválida", etc...

  * Dependendo da escala do projeto poderia utilizar também o `turbo-rails` para trazer melhor performance às views

  * Também dependendo da escala do projeto poderia mudar a arquitetura separando o front-end do back-end e isolando as funções principais em microserviços.

### Conclusão

Por fim, esta solução foi pensanda para atender à necessidade de forma simples, mas bem definida com fácil manutenção e futuros aprimoramentos.
