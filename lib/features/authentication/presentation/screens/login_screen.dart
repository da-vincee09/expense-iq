import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/features/authentication/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {

    if(!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();

    await authProvider.signIn(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim(),
    );

    if(!mounted) return;

    if(authProvider.errorMessage == null) {
      context.go(
        AppRoutes.dashboard,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.headlineMedium
                ),

                const SizedBox(height: 8),

                Text(
                  'Login to continue tracking your expenses',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 32,),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (value) {

                    if(value == null || value.isEmpty) {
                      return 'Email is required'; 
                    }

                    if(!value.contains('@')) {
                      return 'Enter a valid email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 16,),

                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  validator: (value) {

                    if(value == null || value.isEmpty) {
                      return 'Password is required';
                    }

                    if(value.length < 6) {
                      return 'Password must be 6 characters';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: authProvider.isLoading ? null : _login,
                    child: authProvider.isLoading ?
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )
                      )
                      :
                      const Text('Login'),
                  )
                ),

                const SizedBox(height: 16),

                if(authProvider.errorMessage != null)
                  Text(
                    authProvider.errorMessage!,
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .error,
                    ),
                  ),

                TextButton(
                  onPressed: () {
                    context.read<AuthProvider>().clearError();
                    context.go(AppRoutes.register);
                  },

                  child: const Text('Create an account'),
                )
              ],  
            )
          )
        )
      )
    );
  }
}