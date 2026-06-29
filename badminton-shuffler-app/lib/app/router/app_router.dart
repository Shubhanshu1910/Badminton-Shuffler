import 'package:go_router/go_router.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.home,
  routes: [
    GoRoute(
      path: RouteNames.home,
      builder: (_, __) => const HomeScreen(),
    ),
  ],
);