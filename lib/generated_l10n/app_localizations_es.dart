// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Iniciador de Autenticación Flutter';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get email => 'Correo Electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get loginButton => 'Iniciar Sesión';

  @override
  String get home => 'Inicio';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get welcome => 'Bienvenido';

  @override
  String get user => 'Usuario';

  @override
  String get displayName => 'Nombre Mostrado';

  @override
  String get errorInvalidEmail => 'Formato de correo electrónico inválido';

  @override
  String get errorPasswordRequired => 'La contraseña es obligatoria';

  @override
  String get errorEmailRequired => 'El correo electrónico es obligatorio';

  @override
  String get errorAuthFailed => 'Falló la autenticación';

  @override
  String get language => 'Idioma';

  @override
  String get english => 'Inglés';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Francés';
}
