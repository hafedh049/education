import 'package:education/helpers/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'globals.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, required this.item, required this.color});
  final String item;
  final Color color;

  @override
  Widget build(BuildContext context) {
    bool isHovered = false;
    return Tooltip(
      message: item,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setS) {
              return InkWell(
                onTap: () => showToast(text: "${item.toUpperCase()} MENU IS PRESSED."),
                onHover: (bool value) => setS(() => isHovered = value),
                child: AnimatedContainer(
                  duration: 300.ms,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: isHovered ? blue : white, borderRadius: BorderRadius.circular(5)),
                  child: Text(item, style: const TextStyle(fontSize: 25, color: black)),
                ),
              );
            },
          ),
          const SizedBox(height: 5),
          Container(height: 2, width: item.length * 13, color: color),
        ],
      ),
    );
  }
}

class ListTileShimmer extends StatelessWidget {
  const ListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(width: 48, height: 48, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: grey)),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: <Widget>[Container(width: double.infinity, height: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: grey)), const SizedBox(height: 10)]),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(width: double.infinity, height: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: grey)),
          const SizedBox(height: 10),
          Container(width: 40, height: 8, decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: grey)),
        ],
      ),
      horizontalTitleGap: 8,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    ).animate(onComplete: (AnimationController controller) => controller.repeat(period: const Duration(seconds: 2))).shimmer(color: grey, colors: <Color>[white, grey]);
  }
}

class PasswordStrength extends StatelessWidget {
  final String password;

  const PasswordStrength({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> criteria = <String, bool>{"contains_uppercase": false, "contains_lowercase": false, "contains_digit": false, "length": false};

    if (password.contains(RegExp(r'[A-Z]'))) {
      criteria['contains_uppercase'] = true;
    }
    if (password.contains(RegExp(r'[a-z]'))) {
      criteria['contains_lowercase'] = true;
    }
    if (password.contains(RegExp(r'[0-9]'))) {
      criteria['contains_digit'] = true;
    }
    if (password.length >= 6) {
      criteria['length'] = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(criteria['contains_uppercase']! ? Icons.check_circle : Icons.cancel_outlined, color: criteria['contains_uppercase']! ? Colors.green : red),
            const SizedBox(width: 8),
            Text('Contains at least one uppercase letter'.tr, style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Icon(criteria['contains_lowercase']! ? Icons.check_circle : Icons.cancel_outlined, color: criteria['contains_lowercase']! ? Colors.green : red),
            const SizedBox(width: 8),
            Text('Contains at least one lowercase letter'.tr, style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Icon(criteria['contains_digit']! ? Icons.check_circle : Icons.cancel_outlined, color: criteria['contains_digit']! ? Colors.green : red),
            const SizedBox(width: 8),
            Text('Contains at least one digit'.tr, style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: <Widget>[
            Icon(criteria['length']! ? Icons.check_circle : Icons.cancel_outlined, color: criteria['length']! ? Colors.green : red),
            const SizedBox(width: 8),
            Text('Contains more than 5 characters'.tr, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
