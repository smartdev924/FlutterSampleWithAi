import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/language.dart';
import '../../services/language_service.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageService _languageService;

  LanguageBloc({LanguageService? languageService})
      : _languageService = languageService ?? LanguageService(),
        super(LanguageState(language: AppLanguage.en)) {
    on<LanguageStarted>(_onStarted);
    on<LanguageChanged>(_onLanguageChanged);
  }

  Future<void> _onStarted(LanguageStarted event, Emitter<LanguageState> emit) async {
    final savedLanguage = await _languageService.getSavedLanguage();
    emit(LanguageState(language: savedLanguage));
  }

  Future<void> _onLanguageChanged(LanguageChanged event, Emitter<LanguageState> emit) async {
    await _languageService.saveLanguage(event.language);
    emit(LanguageState(language: event.language));
  }
}
