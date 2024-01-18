import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:education/authentification/sign_in/sign_in.dart';
import 'package:education/helpers/classes.dart';
import 'package:education/helpers/functions.dart';
import 'package:education/helpers/globals.dart';
import 'package:education/small_screen/small_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _carouselController = CarouselController();
  final GlobalKey _smoothKey = GlobalKey();

  final List<Map<String, dynamic>> _menus = <Map<String, dynamic>>[
    <String, dynamic>{"title": "News".tr, "color": const Color(0xFFE57373)},
    <String, dynamic>{"title": "Presentation".tr, "color": const Color(0xFF4CAF50)},
    <String, dynamic>{"title": "Training & Study".tr, "color": const Color(0xFF2196F3)},
    <String, dynamic>{"title": "Search", "color".tr: const Color(0xFFFFC107)},
    <String, dynamic>{"title": "Student Space".tr, "color": const Color(0xFF9C27B0)},
    <String, dynamic>{"title": "Contact".tr, "color": const Color(0xFF607D8B)},
  ];

  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return constraints.maxHeight < 600 || constraints.maxWidth < 900
          ? const ResizeScreen()
          : Scaffold(
              body: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35))),
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider(
                            carouselController: _carouselController,
                            items: <Widget>[for (int index = 1; index <= 10; index++) Image.asset('assets/$index.jpg', fit: BoxFit.cover)],
                            options: CarouselOptions(
                              onPageChanged: (int index, CarouselPageChangedReason reason) => _smoothKey.currentState!.setState(() => _activeIndex = index),
                              autoPlay: true,
                              autoPlayAnimationDuration: 300.ms,
                              viewportFraction: 1,
                              disableCenter: true,
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              decoration: const BoxDecoration(color: white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(8),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                children: _menus
                                    .map(
                                      (Map<String, dynamic> item) => Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                        child: MenuItem(item: item["title"], color: item["color"]),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  highlightColor: transparent,
                                  hoverColor: transparent,
                                  splashColor: transparent,
                                  onPressed: () => _carouselController.previousPage(),
                                  icon: const Icon(FontAwesomeIcons.chevronLeft, size: 25),
                                ),
                                const SizedBox(width: 10),
                                StatefulBuilder(
                                  key: _smoothKey,
                                  builder: (BuildContext context, void Function(void Function()) _) {
                                    return AnimatedSmoothIndicator(
                                      onDotClicked: (int index) => _carouselController.animateToPage(index),
                                      activeIndex: _activeIndex % 6,
                                      count: 6,
                                      effect: CustomizableEffect(
                                        spacing: 5,
                                        activeColorOverride: (int index) => _menus[index]["color"],
                                        inActiveColorOverride: (int index) => _menus[index]["color"],
                                        dotDecoration: DotDecoration(borderRadius: BorderRadius.circular(2), color: blue, height: 15, width: 20),
                                        activeDotDecoration: DotDecoration(borderRadius: BorderRadius.circular(2), color: blue, height: 15, width: 20, dotBorder: const DotBorder(color: white), rotationAngle: 45),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  highlightColor: transparent,
                                  hoverColor: transparent,
                                  splashColor: transparent,
                                  onPressed: () => _carouselController.nextPage(),
                                  icon: const Icon(FontAwesomeIcons.chevronRight, size: 25),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
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
                                Text(themeMode == 1 ? 'Dark Mode'.tr : 'Light Mode'.tr, style: const TextStyle(fontSize: 12, color: white)),
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
                                  Text('Language'.tr, style: const TextStyle(fontSize: 16, color: white)),
                                  const SizedBox(width: 10),
                                  Text(languages[language % 3].tr, style: TextStyle(fontSize: 12, color: grey.withOpacity(.6))),
                                ],
                              ),
                            );
                          },
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            await goTo(const SignIn());
                          },
                          child: Text('Sign Out'.tr, style: const TextStyle(fontSize: 16, color: white)),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
