import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/features/authentication/presentation/screens/login_screen.dart';
import 'package:expense_iq/features/authentication/presentation/screens/register_screen.dart';
import 'package:expense_iq/features/authentication/presentation/screens/splash_screen.dart';
import 'package:expense_iq/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:expense_iq/features/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),

    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) {
        return const LoginScreen();
      },
    ),

    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) {
        return const RegisterScreen();
      },
    ),

    GoRoute(
      path: AppRoutes.dashboard,
      builder: (context, state) {
        return const DashboardScreen();
      },
    ),

    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);