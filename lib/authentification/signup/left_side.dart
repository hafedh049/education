import 'package:education/classes.dart';
import 'package:education/functions.dart';
import 'package:education/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SignUpLeftSide extends StatefulWidget {
  const SignUpLeftSide({super.key});

  @override
  State<SignUpLeftSide> createState() => _SignUpLeftSideState();
}

class _SignUpLeftSideState extends State<SignUpLeftSide> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  bool _termAgreements = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _cinController.dispose();
    _repeatPasswordController.dispose();
    _usernameController.dispose();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomizedText(text: "Sign Up".tr),
          const SizedBox(height: 20),
          CustomTextField(controller: _usernameController, hint: "Student name".tr, prefix: FontAwesomeIcons.userGraduate, validator: fieldsValidator["username"]),
          const SizedBox(height: 10),
          CustomTextField(controller: _cinController, hint: "C.I.N".tr, prefix: FontAwesomeIcons.hashnode, validator: fieldsValidator["id"]),
          const SizedBox(height: 10),
          CustomTextField(controller: _emailController, hint: "E-mail".tr, prefix: FontAwesomeIcons.envelope, type: TextInputType.emailAddress, validator: fieldsValidator["email"]),
          const SizedBox(height: 10),
          CustomTextField(controller: _passwordController, hint: "Password".tr, prefix: FontAwesomeIcons.lock, obscured: true, validator: fieldsValidator["password"]),
          const SizedBox(height: 10),
          CustomTextField(controller: _repeatPasswordController, hint: "Repeat your password".tr, prefix: FontAwesomeIcons.schoolLock, validator: fieldsValidator["password"], obscured: true),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setS) {
                  return Checkbox(value: _termAgreements, onChanged: (bool? value) => setS(() => _termAgreements = value!));
                },
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      CustomizedText(text: "I agree all statements in ".tr, fontSize: 18),
                      CustomizedText(text: "Terms Of Service".tr, fontSize: 18, fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          AnimatedButton(
            text: "Register",
            animatedOn: AnimatedOn.onHover,
            backgroundColor: blue,
            borderRadius: 5,
            animationDuration: 300.ms,
            height: 40,
            width: 100,
            onPress: () {
              if (_formKey.currentState!.validate() && _repeatPasswordController.text == _passwordController.text) {
              } else {
                showToast(text: "Verify fields please".tr, color: red);
              }
            },
          ),
        ],
      ),
    );
  }
}
