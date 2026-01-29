import 'package:countries_app/presentation/widgets/country_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:countries_app/presentation/pages/home_page.dart';
import 'package:countries_app/logic/countries/countries_bloc.dart';
import 'package:countries_app/logic/countries/countries_state.dart';
import 'package:countries_app/logic/favorites/favorites_bloc.dart';
import 'package:countries_app/logic/favorites/favorites_state.dart';
import 'package:countries_app/data/models/country_summary.dart';
import 'package:countries_app/data/models/favorites_model.dart';

class MockCountriesBloc extends Mock implements CountriesBloc {}
class MockFavoritesBloc extends Mock implements FavoritesBloc {}

void main() {
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
    
    when(() => mockCountriesBloc.state)
        .thenReturn(const CountriesState.loading());
    when(() => mockFavoritesBloc.state)
        .thenReturn(const FavoritesState.loaded([]));
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
      when(() => mockCountriesBloc.state)
          .thenReturn(const CountriesState.loading());

      await tester.pumpWidget(createTestWidget(const HomePage()));
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows countries when loaded', (tester) async {
      when(() => mockCountriesBloc.state)
          .thenReturn(CountriesState.loaded(mockCountries));
      when(() => mockFavoritesBloc.state)
          .thenReturn(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      
      expect(find.text('Ethiopia'), findsOneWidget);
      expect(find.text('Kenya'), findsOneWidget);
      expect(find.text('Population: 123456789'), findsOneWidget);
      expect(find.text('Population: 53771296'), findsOneWidget);
    });

    testWidgets('shows error state when countries load fails', (tester) async {
      when(() => mockCountriesBloc.state)
          .thenReturn(const CountriesState.error('Failed to load countries'));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      
      expect(find.text('Error: Failed to load countries'), findsOneWidget);
    });

    testWidgets('search bar is present', (tester) async {
      when(() => mockCountriesBloc.state)
          .thenReturn(CountriesState.loaded(mockCountries));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      
      // Check TextField exists
      final searchField = find.byType(TextField);
      expect(searchField, findsOneWidget);

      // Check hint text
      final textFieldWidget = tester.widget<TextField>(searchField);
      expect(textFieldWidget.decoration?.hintText, 'Search for a country');
    });

    testWidgets('bottom navigation bar has two items', (tester) async {
      when(() => mockCountriesBloc.state)
          .thenReturn(CountriesState.loaded(mockCountries));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      
      expect(find.byType(BottomNavigationBar), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget);
    });

    testWidgets('shows favorites when favorites tab is selected', (tester) async {
      when(() => mockCountriesBloc.state)
          .thenReturn(CountriesState.loaded(mockCountries));
      when(() => mockFavoritesBloc.state)
          .thenReturn(FavoritesState.loaded(mockFavorites));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      
      expect(find.text('Ethiopia'), findsOneWidget);
      expect(find.text('Addis Ababa'), findsOneWidget);
    });

    testWidgets('shows empty state when no favorites', (tester) async {
      when(() => mockCountriesBloc.state)
          .thenReturn(CountriesState.loaded(mockCountries));
      when(() => mockFavoritesBloc.state)
          .thenReturn(const FavoritesState.loaded([]));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      
      expect(find.text('No favorites yet.'), findsOneWidget);
    });

    testWidgets('theme toggle button is present', (tester) async {
      when(() => mockCountriesBloc.state)
          .thenReturn(CountriesState.loaded(mockCountries));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      
      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    });

    testWidgets('sort dropdown is present', (tester) async {
      when(() => mockCountriesBloc.state)
          .thenReturn(CountriesState.loaded(mockCountries));

      await tester.pumpWidget(createTestWidget(const HomePage()));
      
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