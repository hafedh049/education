import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:education/authentification/signin/sign_in.dart';
import 'package:education/globals.dart';
import 'package:education/themes/dark_theme.dart';
import 'package:education/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'languages/language_template.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Animate.restartOnHotReload = true;
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => AdaptiveTheme(
        light: lightTheme_,
        initial: themeMode == 1 ? AdaptiveThemeMode.light : AdaptiveThemeMode.dark,
        dark: darkTheme_,
        builder: (ThemeData light, ThemeData dark) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SignIn(),
          theme: light,
          darkTheme: dark,
          translations: LanguageTemplateTranslation(),
          locale: const Locale("en", "US"),
        ),
      );
}
