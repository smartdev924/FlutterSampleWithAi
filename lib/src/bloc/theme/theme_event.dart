import 'package:equatable/equatable.dart';

import '../../services/theme_service.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ThemeStarted extends ThemeEvent {
  const ThemeStarted();
}

class ThemeChanged extends ThemeEvent {
  final AppThemeMode mode;

  const ThemeChanged(this.mode);

  @override
  List<Object?> get props => [mode];
}

