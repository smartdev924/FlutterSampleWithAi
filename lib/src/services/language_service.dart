import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/language.dart';

class LanguageService {
  static const String _languageKey = 'app_language';
  final _secureStorage = const FlutterSecureStorage();

  Future<AppLanguage> getSavedLanguage() async {
    try {
      final code = await _secureStorage.read(key: _languageKey);
      if (code != null) {
        return AppLanguage.fromCode(code);
      }
    } catch (e) {
      // Error reading saved language
    }
    return AppLanguage.en;
  }

  Future<void> saveLanguage(AppLanguage language) async {
    try {
      await _secureStorage.write(key: _languageKey, value: language.code);
    } catch (e) {
      // Error saving language
    }
  }
}
