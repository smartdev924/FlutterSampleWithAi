import 'package:equatable/equatable.dart';

import '../../services/theme_service.dart';

class ThemeState extends Equatable {
  final AppThemeMode mode;

  const ThemeState({required this.mode});

  @override
  List<Object> get props => [mode];
}

