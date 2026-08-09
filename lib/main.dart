import 'package:expense_iq/core/constants/supabase_config.dart';
import 'package:expense_iq/core/router/app_router.dart';
import 'package:expense_iq/core/theme/app_theme.dart';
import 'package:expense_iq/core/theme/theme_provider.dart';
import 'package:expense_iq/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:expense_iq/features/authentication/domain/repositories/auth_repository.dart';
import 'package:expense_iq/features/authentication/presentation/providers/auth_provider.dart';
import 'package:expense_iq/features/category/data/repositories/category_repository_impl.dart';
import 'package:expense_iq/features/category/domain/repositories/category_repository.dart';
import 'package:expense_iq/features/category/presentation/providers/category_provider.dart';
import 'package:expense_iq/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:expense_iq/features/profile/domain/repositories/profile_repository.dart';
import 'package:expense_iq/features/profile/presentation/providers/profile_provider.dart';
import 'package:expense_iq/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:expense_iq/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:expense_iq/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Initializes the ExpenseIQ application.
/// 
/// Configures Supabase, registers dependency injection,
/// sets up state management providers, and launches the app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.publishableKey,
  );

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(
            supabase: Supabase.instance.client,
          )
        ),

        ChangeNotifierProvider(
          create: (context) => AuthProvider(
            authRepository: context.read<AuthRepository>(),
          )
        ),

        Provider<ProfileRepository>(
          create: (_) => ProfileRepositoryImpl(
            supabase: Supabase.instance.client,
          ),
        ),

        ChangeNotifierProvider(
          create: (context) => ProfileProvider(
            context.read<ProfileRepository>(),
          )..loadProfile(),
        ),

        Provider<TransactionRepository>(
          create: (_) => TransactionRepositoryImpl(
            supabase: Supabase.instance.client,
          ),
        ),

        ChangeNotifierProvider(
          create: (context) => TransactionProvider(
            context.read<TransactionRepository>(),
          ),
        ),

        Provider<CategoryRepository>(
          create: (_) => CategoryRepositoryImpl(
            supabase: Supabase.instance.client,
          ),
        ),

        ChangeNotifierProvider(
          create: (context) => CategoryProvider(
            context.read<CategoryRepository>(),
          ),
        ),

        ChangeNotifierProvider.value(
          value:ThemeProvider(),
        )
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp.router(
      title: 'ExpenseIQ',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
    );
  }
}

