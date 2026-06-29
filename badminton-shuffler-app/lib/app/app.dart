import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'constants/app_constants.dart';

class BadmintonShufflerApp extends StatelessWidget {
  const BadmintonShufflerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      routerConfig: appRouter,
      theme: AppTheme.lightTheme,
    );
  }
}