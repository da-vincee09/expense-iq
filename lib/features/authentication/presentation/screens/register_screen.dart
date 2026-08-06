import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/features/authentication/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {

    if(!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();

    await authProvider.signUp(
      name: _nameController.text.trim(), 
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  const SizedBox(height: 32,),

                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Name is required';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16,),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }

                      if (!value.contains('@')) {
                        return 'Enter valid email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                          return 'Password required';
                      }

                      if (value.length < 6) {
                        return 'Minimum 6 characters';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),


                    validator: (value) {
                      if (value !=_passwordController.text) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: authProvider.isLoading ? null : _register,
                      child: authProvider.isLoading
                      ?
                      const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                      :
                      const Text(
                        'Register',
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  if (authProvider.errorMessage != null)

                    Text(
                      authProvider.errorMessage!,
                      style: TextStyle(
                        color:
                        Theme.of(context).colorScheme.error,
                      ),
                    ),


                  TextButton(
                    onPressed: () {
                      context.read<AuthProvider>().clearError();
                      context.go(AppRoutes.login,);
                    },
                    child: const Text(
                      'Already have an account?',
                    ),
                  ),

                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}