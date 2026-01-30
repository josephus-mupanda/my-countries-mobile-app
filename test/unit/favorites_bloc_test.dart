import 'package:bloc_test/bloc_test.dart';
import 'package:countries_app/data/repositories/favorite_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:countries_app/data/models/favorites_model.dart';
import 'package:countries_app/logic/favorites/favorites_bloc.dart';
import 'package:countries_app/logic/favorites/favorites_event.dart';
import 'package:countries_app/logic/favorites/favorites_state.dart';
import '../helpers/test_setup.dart';

// Mock class implementing the repository interface
class MockFavoritesRepository extends Mock implements FavoritesRepository {}

void main() {

  setupTestFallbacks();
  
  late MockFavoritesRepository mockRepository;
  late FavoritesBloc favoritesBloc;

  final mockFavorites = [
    FavoriteCountry(
      cca2: 'ET',
      name: 'Ethiopia',
      capital: 'Addis Ababa',
      flagUrl: 'https://flagcdn.com/w320/et.png',
    ),
    FavoriteCountry(
      cca2: 'KE',
      name: 'Kenya',
      capital: 'Nairobi',
      flagUrl: 'https://flagcdn.com/w320/ke.png',
    ),
  ];

  setUp(() {
    mockRepository = MockFavoritesRepository();
    favoritesBloc = FavoritesBloc(mockRepository);
  });

  tearDown(() {
    favoritesBloc.close();
  });

  group('FavoritesBloc', () {
    blocTest<FavoritesBloc, FavoritesState>(
      'emits loaded state with favorites when loadFavorites succeeds',
      build: () {
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => mockFavorites);
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(const FavoritesEvent.loadFavorites()),
      expect: () => [
        FavoritesState.loaded(mockFavorites),
      ],
      verify: (_) {
        verify(() => mockRepository.getFavorites()).called(1);
      },
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'emits loaded state with empty list when loadFavorites returns empty',
      build: () {
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => []);
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(const FavoritesEvent.loadFavorites()),
      expect: () => [
        const FavoritesState.loaded([]),
      ],
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'adds country to favorites when toggleFavorite called on non-favorite',
      build: () {
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => []);
        when(() => mockRepository.saveFavorites(any()))
            .thenAnswer((_) async {});
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(FavoritesEvent.toggleFavorite(mockFavorites[0])),
      expect: () => [
        FavoritesState.loaded([mockFavorites[0]]),
      ],
      verify: (_) {
        verify(() => mockRepository.saveFavorites([mockFavorites[0]])).called(1);
      },
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'removes country from favorites when toggleFavorite called on existing favorite',
      build: () {
        when(() => mockRepository.getFavorites())
            .thenAnswer((_) async => mockFavorites);
        when(() => mockRepository.saveFavorites(any()))
            .thenAnswer((_) async {});
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(FavoritesEvent.toggleFavorite(mockFavorites[0])),
      expect: () => [
        FavoritesState.loaded([mockFavorites[1]]),
      ],
      verify: (_) {
        verify(() => mockRepository.saveFavorites([mockFavorites[1]])).called(1);
      },
    );

    test('initial state is loaded with empty list', () {
      final bloc = FavoritesBloc(mockRepository);
      expect(bloc.state, const FavoritesState.loaded([]));
    });

    blocTest<FavoritesBloc, FavoritesState>(
      'handles error from repository gracefully',
      build: () {
        when(() => mockRepository.getFavorites())
            .thenThrow(Exception('Storage error'));
        return FavoritesBloc(mockRepository);
      },
      act: (bloc) => bloc.add(const FavoritesEvent.loadFavorites()),
      errors: () => [isA<Exception>()],
      expect: () => [
        // Should still emit the initial state
        const FavoritesState.loaded([]),
      ],
    );
  });
}