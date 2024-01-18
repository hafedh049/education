import 'package:education/authentification/sign_up/sign_up.dart';
import 'package:education/helpers/functions.dart';
import 'package:education/helpers/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class SignInLeftSide extends StatelessWidget {
  const SignInLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 30),
          Flexible(child: LottieBuilder.asset("assets/lottie/si.json") /*Image.asset('assets/signin.png').animate(onComplete: (AnimationController controller) => controller.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.03, 1.03), duration: 2.seconds)*/),
          const SizedBox(width: 40),
          GestureDetector(
            onTap: () async {
              await goTo(const SignUp());
            },
            child: const Text('Create an account', style: TextStyle(decoration: TextDecoration.underline, fontSize: 20)).animate(onComplete: (AnimationController controller) => controller.repeat(reverse: true, period: const Duration(seconds: 2))).shimmer(color: grey, colors: <Color>[blue, grey]),
          ),
        ],
      ),
    );
  }
}
