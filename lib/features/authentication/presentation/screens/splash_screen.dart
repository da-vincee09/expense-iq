import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/features/authentication/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (!mounted) return;

    final authProvider = context.read<AuthProvider>();

    if (authProvider.isSignedIn) {
      context.go(
        AppRoutes.dashboard,
      );
    } else {
      context.go(
        AppRoutes.login
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 20,),

            Text(
              'ExpenseIQ',
              style: Theme.of(context).textTheme.headlineMedium
            ),

            const SizedBox(height: 20,),

            const CircularProgressIndicator(),

            
          ],
        ),
      ),
    );
  }
}