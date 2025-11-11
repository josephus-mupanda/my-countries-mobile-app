import 'package:countries_app/core/di/service_locator.dart';
import 'package:countries_app/logic/country_details/country_details_bloc.dart';
import 'package:countries_app/presentation/pages/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => sl<CountryDetailsBloc>(),
            child: CountryDetailPage(
              cca2: args['cca2'],
              flagUrl: args['flagUrl'],
              name: args['name'],
            ),
          ),
        );

      case AppRoutes.favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesPage());

      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreen());
    }
  }
}
