import 'package:get/get.dart';
import 'package:education/languages/de.dart';
import 'package:education/languages/en.dart';
import 'package:education/languages/fr.dart';

class LanguageTemplateTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {"en_US": english, "fr_FR": french, "de_DE": german};
}
