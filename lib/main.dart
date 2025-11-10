import 'package:countries_app/core/api/dio_client.dart';
import 'package:countries_app/core/di/service_locator.dart';
import 'package:countries_app/core/router/app_router.dart';
import 'package:countries_app/core/router/routes.dart';
import 'package:countries_app/core/themes/app_theme.dart';
import 'package:countries_app/core/utils/preferences.dart';
import 'package:countries_app/logic/theme/theme_bloc.dart';
import 'package:countries_app/logic/theme/theme_state';
import 'package:countries_app/logic/theme/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  await Preferences.init();
  await initServiceLocator();
  await DioClient().initDiskCache(); // This is a no-op but kept for compatibility

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc()..add(LoadThemeEvent()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Countries Mobile App',
            theme: state.isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRouter.generateRoute,
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}