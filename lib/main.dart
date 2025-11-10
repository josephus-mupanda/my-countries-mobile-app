import 'package:countries_app/core/api/dio_client.dart';
import 'package:countries_app/core/di/service_locator.dart';
import 'package:countries_app/core/router/app_router.dart';
import 'package:countries_app/core/router/routes.dart';
import 'package:countries_app/core/themes/app_theme.dart';
import 'package:countries_app/core/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(); 
  await Preferences.init();
  await initServiceLocator();
  await DioClient().initDiskCache();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Todo App - Manage Your Tasks',
      theme: themeProvider.isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: navigatorKey,
    );
  }
}
