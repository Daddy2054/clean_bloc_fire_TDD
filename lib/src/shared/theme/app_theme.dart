import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'app_text_theme.dart';

class AppTheme {
  static final ThemeData theme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: AppColorScheme.appColorSchemeLight,
    textTheme: appTextThemeLight,
  );

  static final ThemeData darkTheme =
      ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: AppColorScheme.appColorSchemeDark,
    textTheme: appTextThemeDark,
  );
}
