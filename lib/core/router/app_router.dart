import 'package:expense_iq/core/enums/transaction_type.dart';
import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/features/authentication/presentation/screens/login_screen.dart';
import 'package:expense_iq/features/authentication/presentation/screens/register_screen.dart';
import 'package:expense_iq/features/authentication/presentation/screens/splash_screen.dart';
import 'package:expense_iq/features/category/presentation/screens/category_screen.dart';
import 'package:expense_iq/features/navigation/presentation/screens/main_screen.dart';
import 'package:expense_iq/features/profile/presentation/screens/profile_screen.dart';
import 'package:expense_iq/features/transactions/data/models/transaction_model.dart';
import 'package:expense_iq/features/transactions/presentation/screens/add_transcation_screen.dart';
import 'package:expense_iq/features/transactions/presentation/screens/transaction_history_screen.dart';
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
        return const MainScreen();
      },
    ),

    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),

   GoRoute(
      path: AppRoutes.addTransaction,
      builder: (context, state) {

        final extra = state.extra;

        if (extra is TransactionModel) {
          return AddTransactionScreen(
            type: extra.type,
            transaction: extra,
          );
        }

        return AddTransactionScreen(
          type: extra as TransactionType,
        );
      },
    ),

    GoRoute(
      path: AppRoutes.transactionHistory,
      builder: (context, state) =>
          const TransactionHistoryScreen(),
    ),

    GoRoute(
      path: AppRoutes.categories,
      builder: (context, state) => const CategoryScreen(),
    ),
  ],
);