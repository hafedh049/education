import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'globals.dart';

void showToast({required String text, Color? color}) {
  Fluttertoast.showToast(msg: text, backgroundColor: color ?? blue.withOpacity(.3), fontSize: 14, gravity: ToastGravity.TOP, toastLength: Toast.LENGTH_LONG, textColor: white, timeInSecForIosWeb: 3, webBgColor: "rgb(0, 196, 255)", webShowClose: true);
}

void changeLanguage() {
  Get.updateLocale(locals[languages[(++language) % 3]]!);
}

Future<void> goTo(Widget place) async {
  await Get.to(place, transition: animatedTransitions[Random().nextInt(animatedTransitions.length)], duration: 300.ms);
}
