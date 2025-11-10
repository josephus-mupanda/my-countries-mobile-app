import 'package:countries_app/presentation/pages/not_found_page.dart';
import 'package:flutter/material.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/country_detail_page.dart';
import '../../presentation/pages/favorites_page.dart';
import 'routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.detail:
        final code = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => CountryDetailPage(cca2: code));
      case AppRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());
      
      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundScreen ()
        );
    }
  }
}
