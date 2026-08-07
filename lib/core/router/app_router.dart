// Application route configuration.
//
// Defines all navigation paths using GoRouter and applies
// consistent page transitions through AppPageBuilder.
import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/core/router/app_page_builder.dart';
import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/features/authentication/presentation/screens/login_screen.dart';
import 'package:expense_iq/features/authentication/presentation/screens/register_screen.dart';
import 'package:expense_iq/features/authentication/presentation/screens/splash_screen.dart';
import 'package:expense_iq/features/category/presentation/screens/category_screen.dart';
import 'package:expense_iq/features/navigation/presentation/screens/main_screen.dart';
import 'package:expense_iq/features/profile/presentation/screens/profile_screen.dart';
import 'package:expense_iq/features/settings/presentation/about_screen.dart';
import 'package:expense_iq/features/settings/presentation/settings_screen.dart';
import 'package:expense_iq/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';
import 'package:expense_iq/features/transactions/presentation/screens/add_transaction_screen.dart';
import 'package:expense_iq/features/transactions/presentation/screens/transaction_history_screen.dart';
import 'package:go_router/go_router.dart';

// Central application router used for managing navigation
// between screens throughout the app.
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const SplashScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.login,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const LoginScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.register,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const RegisterScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.dashboard,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const MainScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.profile,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const ProfileScreen(),
        );
      },
    ),

   GoRoute(
      path: AppRoutes.addTransaction,
      pageBuilder: (context, state) {

        final extra = state.extra;

        final screen = extra is TransactionModel
        ? AddTransactionScreen(
            type: extra.type,
            transaction: extra,
          )
        : AddTransactionScreen(
            type: extra as TransactionType? ?? TransactionType.expense,
          );

        return AppPageBuilder.fade(
          child: screen,
        );
      },
    ),

    GoRoute(
      path: AppRoutes.transactionHistory,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const TransactionHistoryScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.categories,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const CategoryScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.statistics,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const StatisticsScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.settings,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const SettingsScreen(),
        );
      },
    ),

    GoRoute(
      path: AppRoutes.about,
      pageBuilder: (context, state) {
        return AppPageBuilder.fade(
          child: const AboutScreen(),
        );
      },
    ),
  ],
);