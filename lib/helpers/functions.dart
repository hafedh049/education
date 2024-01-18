import 'package:education/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import 'globals.dart';

void showToast({required String text, Color? color}) {
  Fluttertoast.showToast(msg: text, backgroundColor: color ?? blue.withOpacity(.3), fontSize: 14, gravity: ToastGravity.TOP, toastLength: Toast.LENGTH_LONG, textColor: white, timeInSecForIosWeb: 3, webBgColor: "rgb(0, 196, 255)", webShowClose: true);
}

void changeLanguage() {
  Get.updateLocale(locals[languages[(++language) % 3]]!);
  showToast(text: "${"Language Switched To".tr} ${languages[language % 3].toUpperCase()}", color: grey);
}

Future<void> goTo(Widget route) async {
  await Get.to(route);
}

String formatCurrentDate() {
  return DateFormat('dd MMMM yyyy').format(DateTime.now()).replaceAll(RegExp(r' '), ' - ');
}

Future<void> signInWithGoogle() async {
  try {
    await GoogleSignIn().signIn().then((GoogleSignInAccount? googleAccount) async {
      if (googleAccount != null) {
        List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(googleAccount.email);
        if (signInMethods.isEmpty) {
          showToast(text: 'nouserlinkedtothisaccountpleasecreateone'.tr);
        } else if (signInMethods.contains('google.com')) {
          await googleAccount.authentication.then((GoogleSignInAuthentication authentication) async {
            AuthCredential credential = GoogleAuthProvider.credential(idToken: authentication.idToken, accessToken: authentication.accessToken);
            await FirebaseAuth.instance.signInWithCredential(credential);
            await goTo(const HomePage());
          });
        } else {
          final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;
          final OAuthCredential googleCredential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
          showToast(text: 'signedWithGoogle'.tr);
          await FirebaseAuth.instance.currentUser!.linkWithCredential(googleCredential);
          await FirebaseAuth.instance.signInWithCredential(googleCredential);
          showToast(text: 'accountLinkedWithGoogle'.tr);
          await goTo(const HomePage());
        }
      }
    });
  } catch (_) {
    showToast(text: _.toString(), color: red);
  }
}
