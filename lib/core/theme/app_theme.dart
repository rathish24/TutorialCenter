import 'package:flutter/material.dart';
import 'package:tutorial_management/core/theme/design_tokens.dart';

/// Centralized Material 3 Design System configuring color schemes and component themes.
class AppTheme {
  AppTheme._();

  /// Light Color Scheme mapped from primitive color tokens.
  static final ColorScheme lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.textIcons,
    primaryContainer: AppColors.lightPrimary,
    secondary: AppColors.accent,
    surface: Colors.white,
    onSurface: AppColors.primaryText,
    onSurfaceVariant: AppColors.secondaryText,
    outline: AppColors.divider,
  );

  /// Dark Color Scheme mapped to provide optimal contrast in dark mode.
  static final ColorScheme darkColorScheme = ColorScheme.dark(
    primary: const Color(0xFFC5CAE9),
    onPrimary: AppColors.primaryText,
    primaryContainer: AppColors.darkPrimary,
    secondary: const Color(0xFFB094FF),
    surface: const Color(0xFF121212),
    onSurface: Colors.white,
    onSurfaceVariant: const Color(0xFFB0B0B0),
    outline: const Color(0xFF424242),
  );

  /// Getter for Light Theme configuration.
  static ThemeData get lightTheme => _buildTheme(lightColorScheme);

  /// Getter for Dark Theme configuration.
  static ThemeData get darkTheme => _buildTheme(darkColorScheme);

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      
      // ElevatedButton Component Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      
      // OutlinedButton Component Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Card Component Theme
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainerHighest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
      ),

      // Input Field (Text Field decoration) Component Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.outline.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        floatingLabelStyle: TextStyle(color: colorScheme.primary),
      ),

      // NavigationBar (Material 3 Tab Bar) Component Theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.primary);
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            );
          }
          return TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 12,
          );
        }),
      ),
    );
  }
}
