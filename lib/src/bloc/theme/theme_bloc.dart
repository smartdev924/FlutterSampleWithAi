import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/theme_service.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeService _themeService;

  ThemeBloc({ThemeService? themeService})
      : _themeService = themeService ?? ThemeService(),
        super(const ThemeState(mode: AppThemeMode.system)) {
    on<ThemeStarted>(_onStarted);
    on<ThemeChanged>(_onThemeChanged);
  }

  Future<void> _onStarted(ThemeStarted event, Emitter<ThemeState> emit) async {
    final saved = await _themeService.getSavedThemeMode();
    emit(ThemeState(mode: saved));
  }

  Future<void> _onThemeChanged(
    ThemeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    await _themeService.saveThemeMode(event.mode);
    emit(ThemeState(mode: event.mode));
  }
}

