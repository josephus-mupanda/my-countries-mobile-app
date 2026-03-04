import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:countries_app/presentation/pages/country_detail_page.dart';
import 'package:countries_app/logic/country_details/country_details_bloc.dart';
import 'package:countries_app/logic/country_details/country_details_state.dart';
import 'package:countries_app/logic/country_details/country_details_event.dart';
import 'package:countries_app/data/models/country_details.dart';
import '../helpers/mock_network_images.dart';

// Mock BLoC with proper stream implementation
class MockCountryDetailsBloc extends Mock implements CountryDetailsBloc {
  final StreamController<CountryDetailsState> _streamController = 
      StreamController<CountryDetailsState>.broadcast();
  
  @override
  Stream<CountryDetailsState> get stream => _streamController.stream;
  
  CountryDetailsState _currentState = const CountryDetailsState.loading();
  
  @override
  CountryDetailsState get state => _currentState;
  
  // Helper method to update state for testing
  void updateState(CountryDetailsState newState) {
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
  // Mock network images BEFORE any tests
  setUpAll(() {
    mockNetworkImages(); // Add this line
    registerFallbackValue(const CountryDetailsEvent.fetchDetails(''));
  });
  
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

  tearDown(() {
    mockBloc.close();
  });

  // Helper function to create test widget
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
      mockBloc.updateState(const CountryDetailsState.loading());

      await tester.pumpWidget(createTestWidget());
      await tester.pump();
      
      // Should show shimmer loader
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('shows country details when loaded', (tester) async {
      mockBloc.updateState(CountryDetailsState.loaded(mockDetails));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      
      expect(find.text('Key Statistics'), findsOneWidget);
      expect(find.text('Africa'), findsOneWidget);
      expect(find.text('Eastern Africa'), findsOneWidget);
      expect(find.text('Addis Ababa'), findsOneWidget);
      expect(find.text('1104300.0 km²'), findsOneWidget);
      expect(find.text('123456789'), findsOneWidget);
      expect(find.text('Timezones'), findsOneWidget);
      expect(find.text('UTC+03:00'), findsOneWidget);
    });

    testWidgets('shows error state when load fails', (tester) async {
      mockBloc.updateState(const CountryDetailsState.error('Failed to load'));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      
      expect(find.text('Failed to load details: Failed to load'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('retry button works', (tester) async {
      mockBloc.updateState(const CountryDetailsState.error('Failed'));
      
      // Mock the add method - only mock it once
      when(() => mockBloc.add(any())).thenReturn(null);
      
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Retry'));
      
      // Verify BLoC add was called - only once
      verify(() => mockBloc.add(any(that: isA<CountryDetailsEvent>()))).called(1);
    });

    testWidgets('hero animation tag is set', (tester) async {
      mockBloc.updateState(CountryDetailsState.loaded(mockDetails));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      
      // Find Hero widget
      expect(find.byType(Hero), findsOneWidget);
    });

    testWidgets('displays flag image', (tester) async {
      mockBloc.updateState(CountryDetailsState.loaded(mockDetails));

      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();
      
      // Find image - don't check URL, just find Image widget
      expect(find.byType(Image), findsOneWidget);
    });
  });
}