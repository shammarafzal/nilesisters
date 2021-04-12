import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class DemoLocalization{
  final Locale locale;
  DemoLocalization(this.locale);
  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }
  Map<String,String> _localizedValues;

  Future load() async{
    String jsonStringValues  =
    await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    Map<String,dynamic> mapppedJson = json.decode(jsonStringValues);
    _localizedValues = mapppedJson.map((key, value) => MapEntry(key, value.toString()));
  }
  String getTranslatedValue(String key){
    return _localizedValues[key];
  }
  static const LocalizationsDelegate<DemoLocalization> delegate = _DemoLocalizationDelagate();
}
class _DemoLocalizationDelagate extends LocalizationsDelegate<DemoLocalization>{
  const _DemoLocalizationDelagate();
  @override
  bool isSupported(Locale locale) {
    return ['en','fa','ar','hi','fr','am','sw'].contains(locale.languageCode);
  }
  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = new DemoLocalization(locale);
    await localization.load();
    return localization;
  }
  @override
  bool shouldReload(_DemoLocalizationDelagate old) => false;
}