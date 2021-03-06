import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:superapp_my_bloc/src/core/theme/design_system/colors/app_colors.dart';

class AppExtension {
  AppExtension._();

  //Colors
  static const Color primary = AppColors.neutral600;
  static const Color primaryDark = AppColors.neutral800;
  static const Color primaryLight = AppColors.neutral200;
  static const Color secondary = AppColors.neutral;
  static const Color background = AppColors.neutral100;

  //Text Color
  static const Color textColor = AppColors.neutral800;
  static const Color textLightColor = AppColors.neutral600;

  //Font
  static String? fontFamily = GoogleFonts.montserrat().fontFamily;
}
