import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

// Mock network images for tests
void mockNetworkImages() {
  // Mock image loading to prevent network calls in tests
  TestWidgetsFlutterBinding.ensureInitialized();
  
  // Mock network image loading
  const MethodChannel channel = MethodChannel('flutter/painting');
  
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    if (methodCall.method == 'load') {
      return Uint8List(0);
    }
    return null;
  });
}