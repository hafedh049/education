import 'package:education/authentification/signin/sign_in.dart';
import 'package:education/classes.dart';
import 'package:education/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignUpRightSide extends StatelessWidget {
  const SignUpRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LottieBuilder.asset("assets/lottie/signup.json"),
          GestureDetector(onTap: () => goTo(const SignIn()), child: CustomizedText(text: "I am already member".tr, fontSize: 18)),
        ],
      ),
    );
  }
}
