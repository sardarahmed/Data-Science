import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const background = Color(0xFF10111B);
  static const surface = Color(0xFF191B29);
  static const elevated = Color(0xFF222438);
  static const primary = Color(0xFF8057FF);
  static const secondary = Color(0xFFFF795E);
  static const success = Color(0xFF5BE0B0);
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFFA5A8BA);
}

abstract final class AppTheme {
  static ThemeData dark() => _theme(Brightness.dark);
  static ThemeData light() => _theme(Brightness.light);

  static ThemeData _theme(Brightness brightness) {
    final dark = brightness == Brightness.dark;
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
      surface: dark ? AppColors.surface : const Color(0xFFF7F7FC),
    );
    final textTheme = GoogleFonts.manropeTextTheme(
      ThemeData(brightness: brightness).textTheme,
    );
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: dark
          ? AppColors.background
          : const Color(0xFFF7F7FC),
      textTheme: textTheme.copyWith(
        headlineLarge: textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -1.2,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
      ),
      cardTheme: CardThemeData(
        color: dark ? AppColors.elevated : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? AppColors.elevated : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: .4,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
