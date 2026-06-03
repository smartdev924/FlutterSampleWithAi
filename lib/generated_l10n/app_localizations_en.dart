// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Auth Starter';

  @override
  String get signIn => 'Sign In';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get loginButton => 'Sign In';

  @override
  String get home => 'Home';

  @override
  String get logout => 'Logout';

  @override
  String get welcome => 'Welcome';

  @override
  String get user => 'User';

  @override
  String get displayName => 'Display Name';

  @override
  String get errorInvalidEmail => 'Invalid email format';

  @override
  String get errorPasswordRequired => 'Password is required';

  @override
  String get errorEmailRequired => 'Email is required';

  @override
  String get errorAuthFailed => 'Authentication failed';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Spanish';

  @override
  String get french => 'French';
}
