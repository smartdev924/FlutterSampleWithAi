import 'package:equatable/equatable.dart';
import '../../models/language.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class LanguageStarted extends LanguageEvent {
  const LanguageStarted();
}

class LanguageChanged extends LanguageEvent {
  final AppLanguage language;

  const LanguageChanged(this.language);

  @override
  List<Object> get props => [language];
}
