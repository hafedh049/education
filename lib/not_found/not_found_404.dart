import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NotFound404 extends StatelessWidget {
  const NotFound404({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(child: LottieBuilder.asset("assets/lottie/not_found.json")),
            const Text('404 Page Not Found', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
