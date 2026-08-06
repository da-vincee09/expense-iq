import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/router/app_routes.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text('ExpenseIQ'),

        actions: [

          IconButton(

            icon: const Icon(Icons.logout),

            onPressed: () async {

              await context
                  .read<AuthProvider>()
                  .signOut();


              if (!context.mounted) return;


              context.go(
                AppRoutes.login,
              );

            },

          ),

        ],

      ),


      body: Center(
        child: FilledButton(
          onPressed: () {
            context.go(AppRoutes.profile);
          },
          child: const Text('Go to Profile'),
        )
      ),

    );

  }

}