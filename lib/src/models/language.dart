import 'package:flutter/material.dart';

enum AppLanguage {
  en('en', 'English', Locale('en')),
  es('es', 'Spanish', Locale('es')),
  fr('fr', 'French', Locale('fr'));

  final String code;
  final String label;
  final Locale locale;

  const AppLanguage(this.code, this.label, this.locale);

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.en,
    );
  }
}
