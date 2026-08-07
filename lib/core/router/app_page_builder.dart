import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Provides reusable page builders for GoRouter navigation.
///
/// Centralizes page transition behavior to keep navigation
/// consistent throughout the application.
class AppPageBuilder {
  static Page<T> fade<T>({
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      child: child,
      transitionsBuilder:
          (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}