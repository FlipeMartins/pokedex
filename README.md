# pokedex

## Proposta

Uma app simples que consuma uma API e exiba dados de maneira a incorporar diversas tecnicas e boas práticas de desenvolvimento.


## Arquitetura

Usa uma abstração de VIP (View Interactor Presenter) com camadas extras para prover mais escalabilidade e auxiliar decisões de negócios.

### Camadas:

#### Display (View)

É a camada mais volátil da arquitetura, responsável pela interface do usuário e não toma nenhuma decisão ou regra de negócio. A principal funcionalidade é propagar eventos para a camada posterior e receber eventos de atualização de interface.

Define como informações são exibidas em nível de hierarquia da informação mas não tem ciência de como ela é adquirida, formatada ou armazenada.

#### Interactor (Business Logic)

É responsável por aplicar e definir as regras de negócio da aplicação, conectar com camadas extras como Analytcs e camada de Service pra recuperação de dados e envio de métricas e após efetuar (ou delegar) o processamento repassar para camada de apresentação processar as informações ao usuário.

#### Presenter (Presentation Logic)

É responsável por pegar os dados brutos recebidos da camada anterior e reprocessar de maneira a apresentá-los amigavelmente ao usuário. Pode definir os dados diretamente ou delegar pra alguma dependência de comunicação múltilateral (DataProvider por exemplo) ligado a ele.

#### Service

É responsável por se conectar com a API, decodar modelos corretamente e repassar falhas ou sucessos ao Interactor. Diferente das camadas principais que tem comunicação unilateral (Display -> Interactor | Interactor -> Presenter | Presenter -> Display) esta camada funciona como um worker, pegando parte da responsabilidade do interactor pra si e tendo uma comunicação bilateral com ele.

Observação: Na implementação atual (por falta de tempo) esta camada está acessando diretamente a URLSession e efetuando o request e isso não é o ideal. A aplicacão deveria ter uma camada transversal que fosse responsável por encapsular as lógicas gerais de integração com Apis, uma espécie de "NetworkManager". A camada de service de cada scene acessaria o "NetworkManager" solicitando request a determinado endpoint.

Mas pra que um NetworkManager se posso efetuar a request direto? Responsabilidades como, gerencimaneto de token, SSL Pinning, Criptografia de payload, gerenciamento de url base entre outros devem ser transparente para cada Scene. se fazendo a necessidade desta camada extra em aplicações de grande escala.


#### Analytics

Também de comunicação bilateral é reponsável por propagar eventos do usuário para alimentar databases e permitir análises comportamentais da base assim como também auxiliar as camadas estratégicas da empresa a tomar deicisões baseadas em dados (Data Driven Decision).

A proposta da implementação em questão é que o AnalyticsManager receba Providers que sejam capazes de emitir eventos. Ele centraliza as chamadas e repassa aos seus providers permitindo que possamos adicionar novos elementos ao projeto que uma vez adicionados já são capazes de emitir todos os eventos implementados.

Como por exemplo usamos o ConsoleAnalyticsProvider que simplesmente gera um log em console quando um evento é propagado. A ideia é simplesmente representar o envio do evento. Em uma implementação real criaríamos um provider com envio de dados a um servidor ou ferramenta.

As dependências aqui são abstratas, garantindo liberdade a diversas implementações. O conceito de injeção de providers também permite adicionar e remover elementos em tempo de execução com o uso de Feature Toggles por exemplo.

#### Data Provider

Este elemento tem como função prover dados a camada ao qual está acoplada (nos exemplos deste projeto está acoplado ao presenter mas podem haver instâncias em outras camadas também). No projeto é usado como um agrupador local para textos, mas é importante lembrar que neste caso é apenas uma representação, o papel real desta camada é prover dados externos que possam ser configurados sem necessidade de republicação. Aqui pode ser acoplado uma camada que busque todos os textos de um Api, garantindo maleabilidade da informação em tempo real, internacionalização remota e correção e atualizações over the air.

Não necessáriamente precisa ser utilizado só pra textos, pode ser acoplado em qualquer camada e prover valores como feature flags, configs remotos e etc.

## Mocks

A aplicação possui um sitema embed de mocks da camada de serviço para cada Scene, o racional desta implementação tem 2 principais funcionalidades.

1 - Tirar a dependência da API do desenvolvimento da aplicação. Ativando o mock, uma vez que o contrato tenha sido definido os times podem trabalhar em paralelo, agilizando processo de desenvolvimento.

2 - Esta mesma camada de mock pode ser utilizada no target de teste de UI por exemplo a partir da injeção de launch arguments, gatantindo um ambiente estável e sem dependências externas, evitando flaky tests e garantindo a confiabilidade da suite.

PS: Existem ferramentas de mercado que podem criar stubs de http tanto já na camada da aplicação quanto na camada de rede. Optei por esta implementação simples porque é totalmente customizada, de fácil entendimento e não adiciona dependências de terceiros a aplicação. (O uso pode ser complementar com ourtras soluções)


## Tests


### Unit Tests

Foram aplicados a critério de exemplo unit tests na camada de lógica (Interactor) da PokemonDetails Scene. Em um projeto real a cobertura deveria ser maior, por uma questão de tempo aqui foi apenas aplicado em um ponto de maneira a demonstar o conceito. A arquitetura aplicada no projeto permite testes em todas as camadas devido ao isolamento dos limites das mesmas por meio de protocolos e a aplicação de dependências abstratas injetadas.

### UITests

Também a critério de exemplo (devido ao tempo) foi criado um único UITest que navega na aplicacão a partir da tela de listagem até a tela de detalhes e verifica se os dados são mostrados como esperado.

A aplicação prevê injeção de launch options e aplica accessibility identifier nos principais elementos permitindo a criação de mais testes. A ideia foi demonstrar a estrutura funcional e não efetuar uma grande cobertura.


## Pontos que ficaram a desejar (Seriam implementados caso houvesse mais tempo)

### Profundidade

Algumas das camadas implementadas foram adotadas como conceito (DataProvider, Analytics, DesignSystem, etc...), sem a profundidade real que o assunto merece. Por ser um projeto de teste estes conceitos estão bem rasos. Fico a disposição e adoraria discutir a respeito do racional por trás das decisões.

### Layout

O layout ficou extremamente simplório. Na tentativa de mostrar o máximo de conceitos possível criar uma interface gráfica atrativa ficou em segundo plano.

### Camada transversal de Network

Conforme explicado acima quando falamos da camada de service, esta camada não foi criada devido ao prazo, mas seria importante em uma aplicação real.

### Modularização

As camadas de Analytcs e DesignSystem (NetworkManager caso tivesse sido implementado) foram representadas em estruturas separadas dentro do projeto, a ideia seria que estas camadas fossem modularizadas e tratadas como dependências via SPM por exemplo, mas devido ao tempo não foi possível.

Até mesmo cada scene poderia se tornar um Feature Module em caso de times específicos e controle de governança avançado de code base, mas aqui já é um passo bem mais a frente.

