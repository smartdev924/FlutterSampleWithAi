import 'package:equatable/equatable.dart';
import '../../models/language.dart';

class LanguageState extends Equatable {
  final AppLanguage language;

  const LanguageState({required this.language});

  @override
  List<Object> get props => [language];
}
