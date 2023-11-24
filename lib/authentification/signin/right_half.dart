import 'package:education/classes.dart';
import 'package:education/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignInRightSide extends StatefulWidget {
  const SignInRightSide({super.key});

  @override
  State<SignInRightSide> createState() => _SignInRightSideState();
}

class _SignInRightSideState extends State<SignInRightSide> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomizedText(text: "Sign In".tr),
          const SizedBox(height: 20),
          CustomTextField(controller: _emailController, hint: "E-mail".tr, prefix: FontAwesomeIcons.envelope, type: TextInputType.emailAddress, validator: fieldsValidator["email"]),
          const SizedBox(height: 10),
          CustomTextField(controller: _passwordController, hint: "Password".tr, prefix: FontAwesomeIcons.lock, obscured: true, validator: fieldsValidator["password"]),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setS) {
                  return Checkbox(value: _rememberMe, onChanged: (bool? value) => setS(() => _rememberMe = value!));
                },
              ),
              const SizedBox(width: 10),
              CustomizedText(text: "Remember me".tr, fontSize: 18),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          AnimatedButton(
            text: "Login",
            animatedOn: AnimatedOn.onHover,
            backgroundColor: blue,
            borderRadius: 5,
            animationDuration: 300.ms,
            height: 40,
            width: 100,
            onPress: () {},
          ),
          const SizedBox(height: 30),
          Row(
            children: <Widget>[
              CustomizedText(text: "Or login with".tr, fontSize: 18),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 35, 63), borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () {},
                  splashColor: transparent,
                  hoverColor: transparent,
                  highlightColor: transparent,
                  splashRadius: 25,
                  icon: const Icon(FontAwesomeIcons.facebookF, size: 15, color: white),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () {},
                  splashColor: transparent,
                  hoverColor: transparent,
                  highlightColor: transparent,
                  splashRadius: 25,
                  icon: const Icon(FontAwesomeIcons.twitter, size: 15, color: white),
                ),
              ),
              const SizedBox(width: 5),
              Container(
                decoration: BoxDecoration(color: red, borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  splashColor: transparent,
                  hoverColor: transparent,
                  highlightColor: transparent,
                  splashRadius: 25,
                  icon: const Icon(FontAwesomeIcons.google, size: 15, color: white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
