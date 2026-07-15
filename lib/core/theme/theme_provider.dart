import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier to manage the active ThemeMode of the application.
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  /// Changes the theme mode of the application.
  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

/// Provider for the ThemeNotifier to watch and modify the theme mode.
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
