import 'package:education/authentification/signup/sign_up.dart';
import 'package:education/classes.dart';
import 'package:education/functions.dart';
import 'package:education/test.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignInLeftSide extends StatelessWidget {
  const SignInLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LottieBuilder.asset("assets/lottie/signin.json"),
        GestureDetector(
            onTap: () async {
              goTo(const HomePage());
              //  goTo(const SignUp());
            },
            child: CustomizedText(text: "Create an account".tr, fontSize: 18)),
      ],
    );
  }
}
