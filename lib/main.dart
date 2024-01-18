import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:education/authentification/sign_in/sign_in.dart';
import 'package:education/error/error.dart';
import 'package:education/helpers/globals.dart';
import 'package:education/home/home_page.dart';
import 'package:education/languages/language_template.dart';
import 'package:education/themes/dark_theme.dart';
import 'package:education/themes/light_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  setPathUrlStrategy();
  ErrorWidget.builder = (FlutterErrorDetails details) => ErrorPage(error: details.exception.toString());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) => AdaptiveTheme(
        light: lightTheme_,
        dark: darkTheme_,
        initial: AdaptiveThemeMode.light,
        builder: (ThemeData light, ThemeData dark) => GetMaterialApp(
          title: "Education Platform",
          theme: light,
          darkTheme: dark,
          home: FutureBuilder<FirebaseApp>(
            future: Firebase.initializeApp(
              options: const FirebaseOptions(
                apiKey: "AIzaSyCS_0H7KAQyCMK4Jy1ftjI6EbIk2s0WUDI",
                authDomain: "education-9fb21.firebaseapp.com",
                projectId: "education-9fb21",
                storageBucket: "education-9fb21.appspot.com",
                messagingSenderId: "704929574805",
                appId: "1:704929574805:web:58eaecb5d2efd380cd109c",
                measurementId: "G-GN1WC700WM",
              ),
            ),
            builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
              if (snapshot.hasData) {
                return FirebaseAuth.instance.currentUser != null ? const HomePage() : const SignIn();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(body: Center(child: CircularProgressIndicator(color: blue)));
              } else {
                return ErrorPage(error: snapshot.error.toString());
              }
            },
          ),
          locale: const Locale('en', 'US'),
          translations: LanguageTranslation(),
          debugShowCheckedModeBanner: false,
        ),
      );
}
