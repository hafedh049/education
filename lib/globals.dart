import 'package:flutter/material.dart';
import 'package:get/get.dart';

//colors
const Color white = Colors.white;
const Color black = Colors.black;
const Color transparent = Colors.transparent;
const Color blue = Color.fromARGB(255, 93, 172, 248);
const Color red = Color.fromARGB(255, 219, 15, 0);
const Color green = Colors.lightGreenAccent;
const Color grey = Colors.grey;

//global variables
int themeMode = 0;
String userToken = "";
int language = 0;

//Data Structures
final Map<String, Locale> locals = <String, Locale>{"Français": const Locale("fr", "FR"), "English": const Locale("en", "US"), "Deutsch": const Locale("de", "DE")};
final List<String> languages = <String>["English", "Français", "Deutsch"];
const List<Transition> animatedTransitions = Transition.values;

final Map<String, String? Function(String?)?> fieldsValidator = <String, String? Function(String?)?>{
  "email": (String? text) {
    if (text!.isEmpty) {
      return 'emailismandatory'.tr;
    } else if (!text.contains(RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$'))) {
      return 'pleaseverifyyourEmail'.tr;
    }
    return null;
  },
  "password": (String? text) {
    if (text!.isEmpty) {
      return 'passwordshouldnotbeempty'.tr;
    } else if (!text.contains(RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z0-9]{6,}$'))) {
      return 'passwordexpressionshouldbeatleastcharactersmustcontainatleastuppercaseletterlowercaseletterandnumberandcancontainspecialcharacters'.tr;
    }
    return null;
  },
  "username": (String? text) {
    if (text!.isEmpty) {
      return 'namefieldisempty'.tr;
    } else if (!text.contains(RegExp(r'^[a-zA-Z][\w ]+$'))) {
      return 'thisfieldmuststartwithanalphabeticcharacter'.tr;
    }
    return null;
  },
  "id": (String? text) {
    if (text!.isEmpty) {
      return 'iDmustnotbeempty'.tr;
    } else if (!text.contains(RegExp(r'^\d{8}$'))) {
      return 'wrongformatforIDItmuststartwithandcontainsalphanumericcaracters'.tr;
    }
    return null;
  },
};
