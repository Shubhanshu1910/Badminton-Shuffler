import 'package:flutter/material.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';
import 'constants/app_constants.dart';

class BadmintonShufflerApp extends StatelessWidget {
  const BadmintonShufflerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
  routerConfig: appRouter,
  theme: AppTheme.lightTheme,
  debugShowCheckedModeBanner: false,
);
  }
}