import 'package:education/helpers/globals.dart';
import 'package:education/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../helpers/functions.dart';

class SignInRightSide extends StatefulWidget {
  const SignInRightSide({super.key});

  @override
  State<SignInRightSide> createState() => _SignInRightSideState();
}

class _SignInRightSideState extends State<SignInRightSide> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _rememberMe = true;
  bool _hidePassword = true;
  bool _cheapPress = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sign In'.tr, style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold)).animate(onComplete: (AnimationController controller) => controller.repeat(reverse: true, period: const Duration(seconds: 2))).shimmer(color: grey, colors: <Color>[blue, grey]),
            const SizedBox(height: 30),
            SizedBox(
              width: 400,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "E-mail".tr,
                  enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2), borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2), borderRadius: BorderRadius.circular(8)),
                  errorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2), borderRadius: BorderRadius.circular(8)),
                  focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2), borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(FontAwesomeIcons.envelope, size: 25),
                ),
                validator: fieldsValidator["email"],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 400,
              child: StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setS) => TextFormField(
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  decoration: InputDecoration(
                    labelText: 'Password'.tr,
                    enabledBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2), borderRadius: BorderRadius.circular(8)),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2), borderRadius: BorderRadius.circular(8)),
                    errorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2), borderRadius: BorderRadius.circular(8)),
                    focusedErrorBorder: OutlineInputBorder(borderSide: const BorderSide(width: 2), borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.lock, size: 25),
                    suffixIcon: IconButton(onPressed: () => setS(() => _hidePassword = !_hidePassword), icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility)),
                  ),
                  validator: fieldsValidator["password"],
                ),
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StatefulBuilder(
                  builder: (BuildContext context, void Function(void Function()) setS) => Checkbox(
                    value: _rememberMe,
                    activeColor: const Color.fromARGB(255, 255, 123, 167),
                    onChanged: (bool? value) => setS(() => _rememberMe = !_rememberMe),
                  ),
                ),
                Text('Remember me'.tr),
              ],
            ),
            const SizedBox(height: 20),
            StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setS) {
              return IgnorePointer(
                ignoring: _cheapPress,
                child: AnimatedButton(
                  animatedOn: AnimatedOn.onHover,
                  height: 40,
                  borderRadius: 5,
                  width: 150,
                  backgroundColor: const Color.fromARGB(255, 255, 123, 167),
                  text: _cheapPress ? 'Wait...'.tr : "Login".tr,
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        setS(() => _cheapPress = true);
                        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
                        setS(() => _cheapPress = false);
                        await goTo(const HomePage());
                      } catch (e) {
                        setS(() => _cheapPress = false);
                        showToast(text: e.toString());
                      }
                    }
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Or login with             '.tr, style: const TextStyle(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: blue),
                      child: IconButton(
                        highlightColor: transparent,
                        splashColor: transparent,
                        hoverColor: transparent,
                        icon: const Icon(FontAwesomeIcons.facebookF, size: 25, color: white),
                        onPressed: () {
                          showToast(text: 'IconButton pressed ...');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blueAccent),
                      child: IconButton(
                        highlightColor: transparent,
                        splashColor: transparent,
                        hoverColor: transparent,
                        icon: const Icon(FontAwesomeIcons.twitter, size: 25, color: white),
                        onPressed: () {
                          showToast(text: 'IconButton pressed ...');
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: red),
                      child: IconButton(
                        highlightColor: transparent,
                        splashColor: transparent,
                        hoverColor: transparent,
                        icon: const Icon(FontAwesomeIcons.google, size: 25, color: white),
                        onPressed: () async {
                          await signInWithGoogle();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
