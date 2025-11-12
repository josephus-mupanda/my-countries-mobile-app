import 'dart:async';

import 'package:countries_app/core/router/routes.dart';
import 'package:countries_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/images.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState()  {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

  _navigateToHome();
  }


  void _navigateToHome() async {
  await Future.delayed(const Duration(seconds: 1));
  if (!mounted) return;
  Navigator.pushReplacementNamed(context, AppRoutes.home);
}


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: MobileSplashScreen(controller: _controller),
        tablet: TabletSplashScreen(controller: _controller),
        desktop: DesktopSplashScreen(controller: _controller),
      ),
    );
  }
}

class MobileSplashScreen extends StatelessWidget {
  final AnimationController controller;
  const MobileSplashScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar( backgroundColor: Colors.white, child: Image.asset(ImagePath.companyLogo)),
            const SizedBox(height: Constants.kDefaultPadding),
            SizedBox(
              width: 250,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: controller.value,
                    valueColor: AlwaysStoppedAnimation<Color>(
                       IconTheme.of(context).color!,
                    ),
                    backgroundColor: Theme.of(context).cardColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabletSplashScreen extends StatelessWidget {
  final AnimationController controller;
  const TabletSplashScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(
                ImagePath.companyLogo,
                width: 200,
              ),
     
            ), 
            const SizedBox(height: Constants.kDefaultPadding * 1.5),
            SizedBox(
              width: 250,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: controller.value,
                    valueColor: AlwaysStoppedAnimation<Color>(
                       IconTheme.of(context).color!,
                    ),
                    backgroundColor: Theme.of(context).cardColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DesktopSplashScreen extends StatelessWidget {
  final AnimationController controller;
  const DesktopSplashScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
               backgroundColor: Colors.white,
              child: Image.asset(
                ImagePath.companyLogo,
                width: 300,
              ),
             
            ),
            const SizedBox(height: Constants.kDefaultPadding),
            Text(
              "Countries Mobile App",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface, 
              ),
            ),
            const SizedBox(height: Constants.kDefaultPadding / 2),
            Text(
              "Explore countries, view their details, and mark your favorites easily.",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withValues(
                  alpha: 0.6,
                ), 
              ),
            ),
            const SizedBox(height: Constants.kDefaultPadding * 1.5),
            SizedBox(
              width: 250,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: controller.value,
                    valueColor: AlwaysStoppedAnimation<Color>(
                       IconTheme.of(context).color!,
                    ),
                    backgroundColor: Theme.of(context).cardColor,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
