import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Bool darkMode
final darkModeProvider = StateProvider<bool>((ref) => false);

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

// ThemeNotifier
class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toogleDarkMode() {
    state = state.copywith(isDarkMode: !state.isDarkMode);
  }

}
