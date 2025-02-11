import 'package:flutter_test/flutter_test.dart';
import 'package:guia_de_moteis/models/motel_model.dart';
import 'package:guia_de_moteis/blocs/motel_bloc.dart';
import 'package:guia_de_moteis/blocs/motel_state.dart';
import 'package:guia_de_moteis/blocs/motel_event.dart';
import 'package:guia_de_moteis/repositories/motel_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMotelRepository extends Mock implements MotelRepository {}

void main() {
  group('MotelBloc Tests', () {
    late MotelBloc motelBloc;
    late MockMotelRepository mockRepository;

    setUp(() {
      mockRepository = MockMotelRepository();
      motelBloc = MotelBloc(mockRepository);
    });

    tearDown(() {
      motelBloc.close();
    });

    test('Estado inicial deve ser MotelLoading', () {
      expect(motelBloc.state, equals(MotelLoading()));
    });

    blocTest<MotelBloc, MotelState>(
      'Deve carregar motéis corretamente',
      build: () {
        when(() => mockRepository.fetchMotels()).thenAnswer((_) async => [
          Motel(
            fantasia: 'Motel Teste',
            logo: 'logo.png',
            bairro: 'Centro',
            distancia: 2.5,
            favoritos: 10,
            media: 4.5,
            qtdAvaliacoes: 20,
            suites: [],
          )
        ]);
        return motelBloc;
      },
      act: (bloc) => bloc.add(LoadMotels()),
      expect: () => [
        isA<MotelLoading>(),
        isA<MotelLoaded>(),
      ],
    );

blocTest<MotelBloc, MotelState>(
  'Deve alternar favorito corretamente',
  build: () {
    return motelBloc;
  },
  seed: () => MotelLoaded(moteis: [
    Motel(
      fantasia: 'Motel Teste',
      logo: 'logo.png',
      bairro: 'Centro',
      distancia: 2.5,
      favoritos: 10,
      media: 4.5,
      qtdAvaliacoes: 20,
      suites: [],
      isFavorito: false,
    ),
  ]),
  act: (bloc) {
    final currentState = bloc.state as MotelLoaded;
    final motel = currentState.moteis.first; // Pegando o motel já existente
    bloc.add(ToggleFavorite(motel));
  },
  expect: () => [
    isA<MotelLoaded>().having(
      (state) => state.moteis.first.isFavorito,
      'Motel marcado como favorito',
      true,
    ),
  ],
);

  });
}
