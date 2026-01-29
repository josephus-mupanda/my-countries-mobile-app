import 'package:flutter_test/flutter_test.dart';
import 'unit/models_test.dart' as models_test;
import 'unit/bloc_test.dart' as bloc_test;
import 'unit/favorites_bloc_test.dart' as favorites_bloc_test;
import 'widget/home_page_test.dart' as home_page_test;
import 'widget/detail_page_test.dart' as detail_page_test;
import 'widget/splash_page_test.dart' as splash_page_test;

void main() {
  group('Model Tests', models_test.main);
  group('Bloc Tests', bloc_test.main);
  group('Favorites Bloc Tests', favorites_bloc_test.main);
  group('Home Page Widget Tests', home_page_test.main);
  group('Detail Page Widget Tests', detail_page_test.main);
  group('Splash Page Widget Tests', splash_page_test.main);
}