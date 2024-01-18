import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ResizeScreen extends StatelessWidget {
  const ResizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(child: LottieBuilder.asset("assets/lottie/small_screen.json")),
            Text('Please adjust the width and the height of your browser.'.tr, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
