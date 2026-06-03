// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Démarrage d\'Authentification Flutter';

  @override
  String get signIn => 'Se Connecter';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get loginButton => 'Se Connecter';

  @override
  String get home => 'Accueil';

  @override
  String get logout => 'Déconnexion';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get user => 'Utilisateur';

  @override
  String get displayName => 'Nom à Afficher';

  @override
  String get errorInvalidEmail => 'Format d\'e-mail invalide';

  @override
  String get errorPasswordRequired => 'Le mot de passe est obligatoire';

  @override
  String get errorEmailRequired => 'L\'e-mail est obligatoire';

  @override
  String get errorAuthFailed => 'L\'authentification a échoué';

  @override
  String get language => 'Langue';

  @override
  String get english => 'Anglais';

  @override
  String get spanish => 'Espagnol';

  @override
  String get french => 'Français';
}
