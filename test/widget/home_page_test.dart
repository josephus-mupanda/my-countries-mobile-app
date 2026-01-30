import 'dart:async';

import 'package:countries_app/presentation/widgets/country_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:countries_app/presentation/pages/home_page.dart';
import 'package:countries_app/logic/countries/countries_bloc.dart';
import 'package:countries_app/logic/countries/countries_state.dart';
import 'package:countries_app/logic/countries/countries_event.dart';
import 'package:countries_app/logic/favorites/favorites_bloc.dart';
import 'package:countries_app/logic/favorites/favorites_state.dart';
import 'package:countries_app/logic/favorites/favorites_event.dart';
import 'package:countries_app/data/models/country_summary.dart';
import 'package:countries_app/data/models/favorites_model.dart';

// Mock BLoCs with proper stream implementation
class MockCountriesBloc extends Mock implements CountriesBloc {
  // Create a real stream controller
  final StreamController<CountriesState> _streamController = 
      StreamController<CountriesState>.broadcast();
  
  @override
  Stream<CountriesState> get stream => _streamController.stream;
  
  CountriesState _currentState = const CountriesState.loading();
  
  @override
  CountriesState get state => _currentState;
  
  // Helper method to update state for testing
  void updateState(CountriesState newState) {
    _currentState = newState;
    _streamController.add(newState);
  }
  
  @override
  void add(event) {
    // Mock implementation - do nothing or handle specific events
    super.noSuchMethod(Invocation.method(#add, [event]));
  }
  
  @override
  Future<void> close() async {
    _streamController.close();
    return super.noSuchMethod(Invocation.method(#close, []));
  }
}

class MockFavoritesBloc extends Mock implements FavoritesBloc {
  final StreamController<FavoritesState> _streamController = 
      StreamController<FavoritesState>.broadcast();
  
  @override
  Stream<FavoritesState> get stream => _streamController.stream;
  
  FavoritesState _currentState = const FavoritesState.loaded([]);
  
  @override
  FavoritesState get state => _currentState;
  
  // Helper method to update state for testing
  void updateState(FavoritesState newState) {
    _currentState = newState;
    _streamController.add(newState);
  }
  
  @override
  void add(event) {
    // Mock implementation
    super.noSuchMethod(Invocation.method(#add, [event]));
  }
  
  @override
  Future<void> close() async {
    _streamController.close();
    return super.noSuchMethod(Invocation.method(#close, []));
  }
}

void main() {
  // Register fallback values
  setUpAll(() {
    registerFallbackValue(const CountriesEvent.fetchAll());
    registerFallbackValue(const CountriesEvent.search(''));
    registerFallbackValue(const FavoritesEvent.loadFavorites());
    registerFallbackValue(
      FavoritesEvent.toggleFavorite(
        FavoriteCountry(
          cca2: 'ET',
          name: 'Ethiopia',
          capital: 'Addis Ababa',
          flagUrl: 'https://flagcdn.com/w320/et.png',
        ),
      ),
    );
  });
  
  late MockCountriesBloc mockCountriesBloc;
  late MockFavoritesBloc mockFavoritesBloc;
  
  final mockCountries = [
    CountrySummary(
      name: {'common': 'Ethiopia'},
      flags: {'png': 'https://flagcdn.com/w320/et.png'},
      population: 123456789,
      cca2: 'ET',
    ),
    CountrySummary(
      name: {'common': 'Kenya'},
      flags: {'png': 'https://flagcdn.com/w320/ke.png'},
      population: 53771296,
      cca2: 'KE',
    ),
  ];

  final mockFavorites = [
    FavoriteCountry(
      cca2: 'ET',
      name: 'Ethiopia',
      capital: 'Addis Ababa',
      flagUrl: 'https://flagcdn.com/w320/et.png',
    ),
  ];

  setUp(() {
    mockCountriesBloc = MockCountriesBloc();
    mockFavoritesBloc = MockFavoritesBloc();
  });

  tearDown(() {
    mockCountriesBloc.close();
    mockFavoritesBloc.close();
  });

  Widget createTestWidget(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CountriesBloc>.value(value: mockCountriesBloc),
        BlocProvider<FavoritesBloc>.value(value: mockFavoritesBloc),
      ],
      child: MaterialApp(
        home: child,
      ),
    );
  }

  group('HomePage', () {
    testWidgets('shows loading state when countries are loading', (tester) async {
      mockCountriesBloc.updateState(const CountriesState.loading());
      mockFavoritesBloc.updateState(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      await tester.pump();
      
      // Should show shimmer loader
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('shows countries when loaded', (tester) async {
      mockCountriesBloc.updateState(CountriesState.loaded(mockCountries));
      mockFavoritesBloc.updateState(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      await tester.pumpAndSettle();
      
      // Check for country names
      expect(find.text('Ethiopia'), findsOneWidget);
      expect(find.text('Kenya'), findsOneWidget);
    });

    testWidgets('shows error state when countries load fails', (tester) async {
      mockCountriesBloc.updateState(const CountriesState.error('Failed to load countries'));
      mockFavoritesBloc.updateState(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      await tester.pumpAndSettle();
      
      expect(find.text('Error: Failed to load countries'), findsOneWidget);
    });

    testWidgets('search bar is present', (tester) async {
      mockCountriesBloc.updateState(CountriesState.loaded(mockCountries));
      mockFavoritesBloc.updateState(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      await tester.pumpAndSettle();
      
      // Check search field exists
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);
    });

    testWidgets('bottom navigation bar has two items', (tester) async {
      mockCountriesBloc.updateState(CountriesState.loaded(mockCountries));
      mockFavoritesBloc.updateState(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      await tester.pumpAndSettle();
      
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
    });

    testWidgets('shows favorites when favorites tab is selected', (tester) async {
      mockCountriesBloc.updateState(CountriesState.loaded(mockCountries));
      mockFavoritesBloc.updateState(FavoritesState.loaded(mockFavorites));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      await tester.pumpAndSettle();
      
      // Tap favorites tab
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      
      expect(find.text('Ethiopia'), findsOneWidget);
      expect(find.text('Addis Ababa'), findsOneWidget);
    });

    testWidgets('shows empty state when no favorites', (tester) async {
      mockCountriesBloc.updateState(CountriesState.loaded(mockCountries));
      mockFavoritesBloc.updateState(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      await tester.pumpAndSettle();
      
      // Tap favorites tab
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      
      expect(find.text('No favorites yet.'), findsOneWidget);
    });

    testWidgets('theme toggle button is present', (tester) async {
      mockCountriesBloc.updateState(CountriesState.loaded(mockCountries));
      mockFavoritesBloc.updateState(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      await tester.pumpAndSettle();
      
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    });

    testWidgets('sort dropdown is present', (tester) async {
      mockCountriesBloc.updateState(CountriesState.loaded(mockCountries));
      mockFavoritesBloc.updateState(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      await tester.pumpAndSettle();
      
      expect(find.text('Sort by'), findsOneWidget);
    });
  });

  group('CountryListItem', () {
    testWidgets('displays country information correctly', (tester) async {
      final country = mockCountries[0];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                CountryListItem(
                  country: country,
                  isFavorite: false,
                  onTap: () {},
                  onFavoriteToggle: () {},
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.text('Ethiopia'), findsOneWidget);
      expect(find.text('Population: 123456789'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('shows filled heart when favorite', (tester) async {
      final country = mockCountries[0];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                CountryListItem(
                  country: country,
                  isFavorite: true,
                  onTap: () {},
                  onFavoriteToggle: () {},
                ),
              ],
            ),
          ),
        ),
      );
      
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });
  });
}