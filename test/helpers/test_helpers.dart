import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void mockNetworkImages() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock network image loading
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/image_picker'),
    (MethodCall methodCall) async {
      return '';
    },
  );
}

void mockSvgLoading() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock SVG loading
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('flutter_svg'),
    (MethodCall methodCall) async {
      return '';
    },
  );
}

// Helper to pump widget and wait for animations
Future<void> pumpAndSettleWithDuration(WidgetTester tester,
    [Duration duration = const Duration(seconds: 1)]) async {
  await tester.pump();
  await tester.pump(duration);
}
