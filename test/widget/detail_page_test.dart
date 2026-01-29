import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:countries_app/presentation/pages/country_detail_page.dart';
import 'package:countries_app/logic/country_details/country_details_bloc.dart';
import 'package:countries_app/logic/country_details/country_details_state.dart';
import 'package:countries_app/data/models/country_details.dart';

class MockCountryDetailsBloc extends Mock implements CountryDetailsBloc {}

void main() {
  late MockCountryDetailsBloc mockBloc;
  
  final mockDetails = CountryDetails(
    name: {'common': 'Ethiopia'},
    flags: {'png': 'https://flagcdn.com/w320/et.png'},
    population: 123456789,
    area: 1104300.0,
    region: 'Africa',
    subregion: 'Eastern Africa',
    capital: ['Addis Ababa'],
    timezones: ['UTC+03:00'],
  );

  setUp(() {
    mockBloc = MockCountryDetailsBloc();
  });

  Widget createTestWidget() {
    return BlocProvider<CountryDetailsBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: CountryDetailPage(
          cca2: 'ET',
          flagUrl: 'https://flagcdn.com/w320/et.png',
          name: 'Ethiopia',
        ),
      ),
    );
  }

  group('CountryDetailPage', () {
    testWidgets('shows loading state initially', (tester) async {
      when(() => mockBloc.state).thenReturn(const CountryDetailsState.loading());

      await tester.pumpWidget(createTestWidget());
      
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows country details when loaded', (tester) async {
      when(() => mockBloc.state)
          .thenReturn(CountryDetailsState.loaded(mockDetails));

      await tester.pumpWidget(createTestWidget());
      
      expect(find.text('Key Statistics'), findsOneWidget);
      expect(find.text('Ethiopia'), findsOneWidget);
      expect(find.text('Africa'), findsOneWidget);
      expect(find.text('Eastern Africa'), findsOneWidget);
      expect(find.text('Addis Ababa'), findsOneWidget);
      expect(find.text('1104300.0 km²'), findsOneWidget);
      expect(find.text('123456789'), findsOneWidget);
      expect(find.text('Timezones'), findsOneWidget);
      expect(find.text('UTC+03:00'), findsOneWidget);
    });

    testWidgets('shows error state when load fails', (tester) async {
      when(() => mockBloc.state)
          .thenReturn(const CountryDetailsState.error('Failed to load'));

      await tester.pumpWidget(createTestWidget());
      
      expect(find.text('Failed to load details: Failed to load'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('retry button works', (tester) async {
      when(() => mockBloc.state)
          .thenReturn(const CountryDetailsState.error('Failed'));
      when(() => mockBloc.add(any())).thenReturn(null);

      await tester.pumpWidget(createTestWidget());
      
      await tester.tap(find.text('Retry'));
      
      verify(() => mockBloc.add(any())).called(1);
    });

    testWidgets('hero animation tag is set', (tester) async {
      when(() => mockBloc.state)
          .thenReturn(CountryDetailsState.loaded(mockDetails));

      await tester.pumpWidget(createTestWidget());
      
      final heroFinder = find.byType(Hero);
      expect(heroFinder, findsOneWidget);
    });

    testWidgets('displays flag image', (tester) async {
      when(() => mockBloc.state)
          .thenReturn(CountryDetailsState.loaded(mockDetails));

      await tester.pumpWidget(createTestWidget());
      
      expect(find.byType(Image), findsOneWidget);
    });
  });
}