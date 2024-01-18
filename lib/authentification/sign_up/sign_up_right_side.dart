import 'package:education/authentification/sign_in/sign_in.dart';
import 'package:education/helpers/functions.dart';
import 'package:education/helpers/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignUpRightSide extends StatelessWidget {
  const SignUpRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(child: LottieBuilder.asset("assets/lottie/su.json") /*Image.asset('assets/signup.png', fit: BoxFit.cover).animate(onComplete: (AnimationController controller) => controller.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.03, 1.03), duration: const Duration(seconds: 2))*/),
          const SizedBox(width: 40),
          GestureDetector(
            onTap: () async => await goTo(const SignIn()),
            child: Text('Already a member'.tr, style: const TextStyle(decoration: TextDecoration.underline, fontSize: 20)).animate(onComplete: (AnimationController controller) => controller.repeat(reverse: true, period: const Duration(seconds: 2))).shimmer(color: grey, colors: <Color>[white, grey]),
          ),
        ],
      ),
    );
  }
}
