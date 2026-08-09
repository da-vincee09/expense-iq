import 'package:expense_iq/core/router/app_routes.dart';
import 'package:expense_iq/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Displays application settings.
///
/// Allows users to customize app preferences,
/// including switching between light and dark themes,
/// and accessing application information.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                secondary: const Icon(
                  Icons.dark_mode_outlined,
                ),
                title: const Text(
                  "Dark Mode",
                ),
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.setThemeMode(
                    value ? ThemeMode.dark : ThemeMode.light
                  );
                },
              );
            },
          ),

          const Divider(height: 1),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.push(AppRoutes.about);
            },
          )
        ],
      ),
    );
  }
}