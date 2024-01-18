import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education/helpers/classes.dart';
import 'package:education/helpers/functions.dart';
import 'package:education/helpers/globals.dart';
import 'package:education/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class SignUpLeftSide extends StatefulWidget {
  const SignUpLeftSide({super.key});

  @override
  State<SignUpLeftSide> createState() => _SignUpLeftSideState();
}

class _SignUpLeftSideState extends State<SignUpLeftSide> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(text: formatCurrentDate());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _passwordStrenghtKey = GlobalKey();

  String _completePhoneNumber = "";

  bool _cheapPress = false;
  bool _agree = false;
  bool _hidePassword = true;

  @override
  void dispose() {
    _dateController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phonenumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 30),
          Text('Sign Up'.tr, style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold)).animate(onComplete: (AnimationController controller) => controller.repeat(reverse: true, period: const Duration(seconds: 2))).shimmer(color: grey, colors: <Color>[blue, grey]),
          const SizedBox(height: 30),
          Flexible(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _firstnameController,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'First-name'.tr,
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: black, width: 2), borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.people_alt_outlined),
                      ),
                      validator: fieldsValidator["username"],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lastnameController,
                      decoration: InputDecoration(
                        labelText: 'Last-name'.tr,
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: black, width: 2), borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.people_alt_outlined),
                      ),
                      validator: fieldsValidator["username"],
                    ),
                    const SizedBox(height: 10),
                    IntlPhoneField(
                      initialCountryCode: "TN",
                      cursorColor: blue,
                      decoration: InputDecoration(
                        hintText: 'Phone number',
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: black, width: 2), borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      dropdownTextStyle: GoogleFonts.roboto(fontSize: 16),
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[\d \+]'))],
                      invalidNumberMessage: 'Verify fields please'.tr,
                      textInputAction: TextInputAction.done,
                      onChanged: (PhoneNumber value) => _completePhoneNumber = value.completeNumber,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail'.tr,
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: black, width: 2), borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.email),
                      ),
                      validator: fieldsValidator["email"],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setS) {
                            return TextFormField(
                              controller: _passwordController,
                              obscureText: _hidePassword,
                              onChanged: (String value) => _passwordStrenghtKey.currentState!.setState(() {}),
                              decoration: InputDecoration(
                                labelText: 'Password'.tr,
                                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: black, width: 2), borderRadius: BorderRadius.circular(8)),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(onPressed: () => setS(() => _hidePassword = !_hidePassword), icon: Icon(_hidePassword ? Icons.visibility_off : Icons.visibility)),
                              ),
                              validator: fieldsValidator["password"],
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Flexible(child: Padding(padding: const EdgeInsets.only(right: 8.0), child: StatefulBuilder(key: _passwordStrenghtKey, builder: (BuildContext context, void Function(void Function()) _) => PasswordStrength(password: _passwordController.text.trim())))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _cinController,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'C.I.N'.tr,
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: black, width: 2), borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.perm_identity),
                      ),
                      validator: fieldsValidator["id"],
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'\d'))],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: black, width: 2), borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        prefixIcon: const Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        StatefulBuilder(
                          builder: (BuildContext context, void Function(void Function()) setS) => Checkbox(
                            activeColor: const Color.fromARGB(255, 255, 123, 167),
                            value: _agree,
                            onChanged: (bool? value) => setS(() => _agree = !_agree),
                          ),
                        ),
                        Text('I agree all statements in Term of Service'.tr),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setS) {
              return IgnorePointer(
                ignoring: _cheapPress,
                child: AnimatedButton(
                  animatedOn: AnimatedOn.onHover,
                  height: 40,
                  borderRadius: 80,
                  width: 150,
                  backgroundColor: const Color.fromARGB(255, 255, 123, 167),
                  text: "Register".tr,
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim()).then(
                          (UserCredential userCredential) async {
                            setS(() => _cheapPress = true);
                            await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
                            await FirebaseFirestore.instance.collection("students").doc(FirebaseAuth.instance.currentUser!.uid).set(
                              <String, dynamic>{
                                "uid": FirebaseAuth.instance.currentUser!.uid,
                                "first_name": _firstnameController.text.trim(),
                                "last_name": _lastnameController.text.trim(),
                                "email": _emailController.text.trim(),
                                "password": _passwordController.text.trim(),
                                "phone_number": _completePhoneNumber,
                                "cin": _cinController.text.trim(),
                                "date": _dateController.text.trim(),
                              },
                            );
                            setS(() => _cheapPress = false);
                            await goTo(const HomePage());
                          },
                        );
                      } catch (e) {
                        setS(() => _cheapPress = false);
                        showToast(text: e.toString());
                      }
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
