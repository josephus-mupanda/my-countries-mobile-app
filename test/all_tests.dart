import 'package:flutter_test/flutter_test.dart';

// Import all test files
import 'helpers/helpers_test.dart' as helpers_test;
import 'unit/models_test.dart' as models_test;
import 'unit/bloc_test.dart' as bloc_test;
import 'unit/favorites_bloc_test.dart' as favorites_bloc_test;
import 'widget/home_page_test.dart' as home_page_test;
import 'widget/detail_page_test.dart' as detail_page_test;
import 'widget/splash_page_test.dart' as splash_page_test;

void main() {
  // Run all test suites
  helpers_test.main();
  models_test.main();
  bloc_test.main();
  favorites_bloc_test.main();
  home_page_test.main();
  detail_page_test.main();
  splash_page_test.main();
  
  // You can also run specific groups
  group('Full Test Suite', () {
    helpers_test.main();
    models_test.main();
    bloc_test.main();
    favorites_bloc_test.main();
    home_page_test.main();
    detail_page_test.main();
    splash_page_test.main();
  });
}