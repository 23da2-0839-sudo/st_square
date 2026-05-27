import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF755B00),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFC9A84C),
      onPrimaryContainer: Color(0xFF503D00),
      secondary: Color(0xFF5F5E5E),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE2DFDE),
      onSecondaryContainer: Color(0xFF636262),
      tertiary: Color(0xFF5D5F5B),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFABACA8),
      onTertiaryContainer: Color(0xFF3E403D),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF93000A),
      surface: Color(0xFFFCF8F8),
      onSurface: Color(0xFF1C1B1B),
      surfaceContainerHighest: Color(0xFFE5E2E1),
      onSurfaceVariant: Color(0xFF4D4637),
      outline: Color(0xFF7E7665),
      outlineVariant: Color(0xFFD0C5B2),
      inverseSurface: Color(0xFF313030),
      onInverseSurface: Color(0xFFF3F0EF),
      inversePrimary: Color(0xFFE6C364),
      shadow: Colors.black,
      scrim: Colors.black,
      surfaceTint: Color(0xFF755B00),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: TextTheme(
        // Use Noto Serif for headlines and displays
        displayLarge: GoogleFonts.notoSerif(color: colorScheme.onSurface),
        displayMedium: GoogleFonts.notoSerif(color: colorScheme.onSurface),
        displaySmall: GoogleFonts.notoSerif(color: colorScheme.onSurface),
        headlineLarge: GoogleFonts.notoSerif(color: colorScheme.onSurface),
        headlineMedium: GoogleFonts.notoSerif(color: colorScheme.onSurface),
        headlineSmall: GoogleFonts.notoSerif(color: colorScheme.onSurface),
        titleLarge: GoogleFonts.notoSerif(color: colorScheme.onSurface),
        titleMedium: GoogleFonts.notoSerif(color: colorScheme.onSurface),
        titleSmall: GoogleFonts.notoSerif(color: colorScheme.onSurface),
        // Use Manrope for body text and labels
        bodyLarge: GoogleFonts.manrope(color: colorScheme.onSurface),
        bodyMedium: GoogleFonts.manrope(color: colorScheme.onSurface),
        bodySmall: GoogleFonts.manrope(color: colorScheme.onSurface),
        labelLarge: GoogleFonts.manrope(color: colorScheme.onSurface),
        labelMedium: GoogleFonts.manrope(color: colorScheme.onSurface),
        labelSmall: GoogleFonts.manrope(color: colorScheme.onSurface),
      ),
    );
  }
}
