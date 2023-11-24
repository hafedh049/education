import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:education/authentification/signup/left_side.dart';
import 'package:education/authentification/signup/right_side.dart';
import 'package:education/classes.dart';
import 'package:education/functions.dart';
import 'package:education/globals.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const Row(
                children: <Widget>[
                  Expanded(child: SignUpLeftSide()),
                  SizedBox(width: 40),
                  Expanded(child: SignUpRightSide()),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) _) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(radius: 15, backgroundColor: blue.withOpacity(.2), child: const Icon(FontAwesomeIcons.moon, color: blue, size: 15)),
                        const SizedBox(width: 10),
                        CustomizedText(text: 'Dark Mode'.tr, fontSize: 16),
                        const SizedBox(width: 10),
                        CustomizedText(text: themeMode == 1 ? 'On'.tr : 'Off'.tr, fontSize: 12, color: grey.withOpacity(.6)),
                        const SizedBox(width: 10),
                        Switch(
                          activeThumbImage: const AssetImage("assets/icon/moon.png"),
                          inactiveThumbImage: const AssetImage("assets/icon/sun.png"),
                          value: themeMode == 1 ? true : false,
                          onChanged: (bool value) async {
                            themeMode = themeMode == 1 ? 0 : 1;
                            _(() => themeMode == 1 ? AdaptiveTheme.of(context).setDark() : AdaptiveTheme.of(context).setLight());
                          },
                          activeTrackColor: blue,
                          activeColor: white,
                          inactiveTrackColor: grey,
                        ),
                      ],
                    );
                  },
                ),
                StatefulBuilder(builder: (BuildContext context, void Function(void Function()) _) {
                  return GestureDetector(
                    onTap: () => _(() => changeLanguage()),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(width: 20),
                        CircleAvatar(radius: 15, backgroundColor: Colors.blue.shade900.withOpacity(.2), child: Icon(FontAwesomeIcons.language, color: Colors.blue.shade900, size: 15)),
                        const SizedBox(width: 10),
                        CustomizedText(text: 'Language'.tr, fontSize: 16),
                        const SizedBox(width: 10),
                        CustomizedText(text: languages[language % 3].tr, fontSize: 12, color: grey.withOpacity(.6)),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
