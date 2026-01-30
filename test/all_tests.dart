import 'package:flutter_test/flutter_test.dart';

// Import helpers first
import 'helpers/mock_network_images.dart';
import 'helpers/test_setup.dart';

// Import all test files
import 'helpers/helpers_test.dart' as helpers_test;
import 'unit/models_test.dart' as models_test;
import 'unit/bloc_test.dart' as bloc_test;
import 'unit/favorites_bloc_test.dart' as favorites_bloc_test;
import 'widget/home_page_test.dart' as home_page_test;
import 'widget/detail_page_test.dart' as detail_page_test;
import 'widget/splash_page_test.dart' as splash_page_test;

void main() {
  // Setup test environment
  setUpAll(() {
    mockNetworkImages(); // Mock network images
    setupTestFallbacks(); // Setup mocktail fallbacks
  });

  // Run all test suites in groups
  group('Helpers Tests', helpers_test.main);
  group('Model Tests', models_test.main);
  // group('Bloc Tests', bloc_test.main);
  // group('Favorites Bloc Tests', favorites_bloc_test.main);
  // group('Home Page Widget Tests', home_page_test.main);
  group('Detail Page Widget Tests', detail_page_test.main);
  group('Splash Page Widget Tests', splash_page_test.main);
}