import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'globals.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, this.readonly = false, this.func, this.type = TextInputType.text, required this.controller, this.validator, required this.hint, required this.prefix, this.obscured = false});
  final bool obscured;
  final TextEditingController controller;
  final String hint;
  final IconData prefix;
  final TextInputType type;
  final String? Function(String?)? validator;
  final bool readonly;
  final void Function(String)? func;

  @override
  Widget build(BuildContext context) {
    bool obscure = false;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) _) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: TextFormField(
            validator: validator,
            style: GoogleFonts.abel(fontSize: 16),
            controller: controller,
            cursorColor: blue,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            autocorrect: false,
            readOnly: readonly,
            onChanged: func,
            enabled: !readonly,
            cursorRadius: const Radius.circular(15),
            cursorWidth: 1,
            obscureText: obscured ? !obscure : false,
            keyboardType: type,
            decoration: InputDecoration(
              labelText: hint,
              labelStyle: GoogleFonts.abel(color: blue, fontSize: 16, fontWeight: FontWeight.bold),
              prefix: Padding(padding: const EdgeInsets.only(right: 8), child: Icon(prefix, size: 15, color: blue)),
              suffixIcon: obscured ? IconButton(splashColor: blue.withOpacity(.3), highlightColor: blue.withOpacity(.3), focusColor: blue.withOpacity(.3), onPressed: () => _(() => obscure = !obscure), icon: Icon(!obscure ? Icons.visibility_off : Icons.visibility, color: blue, size: 15)) : null,
              enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: blue)),
              disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: blue)),
              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: blue)),
              errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 255, 70, 70))),
              errorStyle: GoogleFonts.abel(color: const Color.fromARGB(255, 255, 70, 70), fontSize: 14),
            ),
          ),
        );
      },
    );
  }
}

class CustomizedText extends StatelessWidget {
  const CustomizedText({super.key, required this.text, this.color, this.fontSize = 35, this.fontWeight = FontWeight.normal});
  final String text;
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) => Text(text, style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight), softWrap: true, overflow: TextOverflow.fade);
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
