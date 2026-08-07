import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [

            const Icon(
              Icons.account_balance_wallet,
              size: 80,
            ),

            const SizedBox(height: 16),

            Text(
              "ExpenseIQ",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium,
            ),

            const SizedBox(height: 8),

            Text(
              "Version 1.0.0",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),

            const SizedBox(height: 24),

            Text(
              "ExpenseIQ helps you manage your "
              "income, expenses, budgets, and "
              "financial insights easily.",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge,
            ),

            const SizedBox(height: 32),

            const ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: Text("Track transactions"),
            ),

            const ListTile(
              leading: Icon(Icons.category_outlined),
              title: Text("Manage categories"),
            ),

            const ListTile(
              leading: Icon(Icons.analytics_outlined),
              title: Text("View statistics"),
            ),

            const Spacer(),

            Text(
              "© 2026 ExpenseIQ",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}