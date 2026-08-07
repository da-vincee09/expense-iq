// ignore_for_file: use_build_context_synchronously

import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/features/authentication/presentation/providers/auth_provider.dart';
import 'package:expense_iq/features/profile/presentation/providers/profile_provider.dart';
import 'package:expense_iq/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = context.read<ProfileProvider>();

      if (provider.profile == null) {
        provider.loadProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (provider.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Center(
          child: Text(provider.errorMessage!),
        ),
      );
    }

    final profile = provider.profile;

    if (profile == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: const Center(
          child: Text('Profile not found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                profile.name.isNotEmpty
                    ? profile.name[0].toUpperCase()
                    : '?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),

            const SizedBox(height: 24),

            Text(
              profile.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            Text(
              profile.email,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 32),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet_outlined),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Monthly Budget',
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '₱${profile.monthlyBudget.toStringAsFixed(2)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );

                      if (!mounted) return;

                      context.read<ProfileProvider>().loadProfile();
                    },
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.category_outlined),
                    title: const Text('Manage Categories'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                     context.push(AppRoutes.categories);
                    },
                  ),
                ],
              ),
            ),


            const SizedBox(height: 16),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      
                    },
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Colors.red,
                    ),
                    onTap: () async {
                      final shouldLogout = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content: const Text(
                              'Are you sure you want to logout?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Logout'),
                              ),
                            ],
                          );
                        },
                      );

                      if (shouldLogout != true) return;

                      context.read<AuthProvider>().signOut();

                      if (!mounted) return;

                      context.go(AppRoutes.login);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}