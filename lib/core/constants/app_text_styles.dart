import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headlines (Noto Serif)
  static TextStyle get headline => GoogleFonts.notoSerif(
    fontWeight: FontWeight.w400,
  );
  
  static TextStyle get display => GoogleFonts.notoSerif(
    fontWeight: FontWeight.w700,
  );

  static TextStyle get titleLarge => GoogleFonts.notoSerif(
    fontWeight: FontWeight.w400,
  );

  // Body (Manrope)
  static TextStyle get body => GoogleFonts.manrope(
    fontWeight: FontWeight.w400,
  );
  
  static TextStyle get label => GoogleFonts.manrope(
    fontWeight: FontWeight.w600,
    letterSpacing: 2.0,
  );

  // --- Phase 4 Architecture Tokens ---
  static TextStyle get headingLarge => GoogleFonts.playfairDisplay(
        fontSize: 28,
        color: AppColors.goldAccent,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get headingMedium => GoogleFonts.playfairDisplay(
        fontSize: 22,
        color: AppColors.warmWhite,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyText => GoogleFonts.lato(
        fontSize: 14,
        color: AppColors.warmWhite,
      );

  static TextStyle get bodySmall => GoogleFonts.lato(
        fontSize: 12,
        color: AppColors.greyText,
      );

  static TextStyle get buttonText => GoogleFonts.lato(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get priceText => GoogleFonts.lato(
        fontSize: 18,
        color: AppColors.goldAccent,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get labelText => GoogleFonts.lato(
        fontSize: 13,
        color: AppColors.greyText,
      );
}
