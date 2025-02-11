# Guia de Motéis

## Sobre o Projeto
O **Guia de Motéis** é um aplicativo desenvolvido em Flutter para ajudar usuários a encontrar motéis, visualizar detalhes e comparar opções. Ele utiliza o **BLoC pattern** para gerenciamento de estado e interação com a API.

## Tecnologias Utilizadas
- **Flutter**: Framework para desenvolvimento cross-platform.
- **Dart**: Linguagem de programação.
- **BLoC (Business Logic Component)**: Para gerenciamento de estado.
- **HTTP**: Para chamadas de API.
- **SharedPreferences**: Para armazenamento local de preferências do usuário.
- **Tailwind CSS**: Para estilização (se aplicável em versão web).

## Estrutura do Projeto
O projeto segue uma estrutura modular e organizada para facilitar a manutenção:

```
/guia_de_moteis
│-- lib/
│   │-- main.dart                  # Ponto de entrada do aplicativo
│   │-- blocs/                      # Gerenciamento de estado com BLoC
│   │   │-- motel_bloc.dart
│   │   │-- motel_event.dart
│   │   │-- motel_state.dart
│   │-- models/                     # Modelos de dados
│   │   │-- categoria_item_model.dart
│   │   │-- desconto_model.dart
│   │   │-- item_model.dart
│   │   │-- motel_model.dart
│   │   │-- periodo_model.dart
│   │   │-- suite_model.dart
│   │-- pages/                      # Telas do aplicativo
│   │   │-- motel_list_page.dart
│   │   └── widgets/               # Componentes reutilizáveis
│   │       │-- custom_appbar.dart
│   │       │-- drawer.dart
│   │       │-- filter_bar.dart
│   │       │-- icon_wrap.dart
│   │       │-- motel_card.dart
│   │       │-- motel_grid.dart
│   │       │-- motel_grid_carousel.dart
│   │       │-- period_buttom.dart
│   │       │-- suite_card.dart
│   │       │-- toggle_button.dart
│   │-- repositories/               # Repositórios para acessar dados
│   │   │-- motel_repository.dart
│   │-- services/                   # Serviços como chamadas de API
│   │   │-- api_service.dart
│   └── test/                        # Testes do aplicativo
│       │-- motel_bloc_test.dart
│       │-- motel_list_page_test.dart
│       │-- widget_test.dart
│-- pubspec.yaml                    # Arquivo de dependências
│-- README.md                        # Documentação do projeto
```

## Instalação
1. Clone o repositório:
   ```bash
   git clone https://github.com/Vitu26/guia_de_moteis.git
   cd guia_de_moteis
   ```
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
3. Execute o projeto:
   ```bash
   flutter run
   ```

## Principais Funcionalidades
- Listagem de motéis com informações detalhadas.
- Filtros personalizados por preço, localização e comodidades.
- Visualização de suítes e períodos de disponibilidade.
- Armazenamento de preferências do usuário.





