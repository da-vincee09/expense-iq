import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  static TextTheme get textTheme {
    final base = GoogleFonts.teachersTextTheme();

    return base.copyWith(
      // Large display (rarely used)
      displayLarge: GoogleFonts.teachers(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.teachers(
        fontSize: 45,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: GoogleFonts.teachers(
        fontSize: 36,
        fontWeight: FontWeight.w700,
      ),

      // Screen titles
      headlineLarge: GoogleFonts.teachers(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: GoogleFonts.teachers(
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: GoogleFonts.teachers(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),

      // Card titles, section headers
      titleLarge: GoogleFonts.teachers(
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: GoogleFonts.teachers(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: GoogleFonts.teachers(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),

      // Normal body text
      bodyLarge: GoogleFonts.teachers(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.teachers(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.teachers(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),

      // Buttons, chips, labels
      labelLarge: GoogleFonts.teachers(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: GoogleFonts.teachers(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: GoogleFonts.teachers(
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}