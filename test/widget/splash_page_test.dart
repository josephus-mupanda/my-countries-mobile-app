import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:countries_app/presentation/pages/splash_page.dart';

void main() {
  group('SplashPage', () {
    testWidgets('shows logo and progress indicator', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashPage()));
      
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('progress indicator animates', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashPage()));
      
      await tester.pump(const Duration(milliseconds: 500));
      
      final progressFinder = find.byType(LinearProgressIndicator);
      expect(progressFinder, findsOneWidget);
    });
  });
}