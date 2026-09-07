import 'package:flutter/material.dart';
import 'app/routes.dart';
import 'app/theme/app_theme.dart';

void main() {
  runApp(const HireGridApp());
}

class HireGridApp extends StatelessWidget {
  const HireGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HireGrid Student Portal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
