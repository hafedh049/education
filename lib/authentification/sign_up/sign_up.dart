import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:education/authentification/sign_up/sign_up_left_side.dart';
import 'package:education/authentification/sign_up/sign_up_right_side.dart';
import 'package:education/helpers/functions.dart';
import 'package:education/helpers/globals.dart';
import 'package:education/small_screen/small_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return constraints.maxHeight < 600 || constraints.maxWidth < 1050
          ? const ResizeScreen()
          : Scaffold(
              body: Stack(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Row(
                      children: <Widget>[
                        Expanded(child: SignUpLeftSide()),
                        Expanded(child: SignUpRightSide()),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) _) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CircleAvatar(radius: 15, backgroundColor: blue.withOpacity(.2), child: const Icon(FontAwesomeIcons.moon, color: blue, size: 15)),
                                const SizedBox(width: 10),
                                Text(themeMode == 1 ? 'Dark Mode'.tr : 'Light Mode'.tr, style: const TextStyle(fontSize: 12)),
                                const SizedBox(width: 10),
                                Text(themeMode == 1 ? 'On'.tr : 'Off'.tr, style: TextStyle(fontSize: 12, color: grey.withOpacity(.6))),
                                const SizedBox(width: 10),
                                Switch(
                                  activeThumbImage: const AssetImage("assets/moon.png"),
                                  inactiveThumbImage: const AssetImage("assets/sun.png"),
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
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) _) {
                            return GestureDetector(
                              onTap: () => _(() => changeLanguage()),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const SizedBox(width: 20),
                                  CircleAvatar(radius: 15, backgroundColor: Colors.blue.shade900.withOpacity(.2), child: Icon(FontAwesomeIcons.language, color: Colors.blue.shade900, size: 15)),
                                  const SizedBox(width: 10),
                                  Text('Language'.tr, style: const TextStyle(fontSize: 16)),
                                  const SizedBox(width: 10),
                                  Text(languages[language % 3].tr, style: TextStyle(fontSize: 12, color: grey.withOpacity(.6))),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
