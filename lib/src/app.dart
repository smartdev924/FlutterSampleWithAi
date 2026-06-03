import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_event.dart';
import 'bloc/auth/auth_state.dart';
import 'bloc/language/language_bloc.dart';
import 'bloc/language/language_event.dart';
import 'bloc/language/language_state.dart';
import 'bloc/theme/theme_bloc.dart';
import 'bloc/theme/theme_event.dart';
import 'bloc/theme/theme_state.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'services/theme_service.dart';

import '../generated_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LanguageBloc()..add(const LanguageStarted()),
        ),
        BlocProvider(
          create: (_) => AuthBloc()..add(AuthStarted()),
        ),
        BlocProvider(
          create: (_) => ThemeBloc()..add(const ThemeStarted()),
        ),
      ],
      child: const _AppShell(),
    );
  }
}

class _AppShell extends StatelessWidget {
  const _AppShell();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, themeState) {
            final lightTheme = ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            );

            final darkTheme = ThemeData(
              brightness: Brightness.dark,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            );

            return MaterialApp(
              title: 'Flutter Auth Starter',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: switch (themeState.mode) {
                AppThemeMode.light => ThemeMode.light,
                AppThemeMode.dark => ThemeMode.dark,
                AppThemeMode.system => ThemeMode.system,
              },
              locale: languageState.language.locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('es'),
                Locale('fr'),
              ],
              home: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthAuthenticated) {
                    return const HomePage();
                  }

                  if (state is AuthLoadInProgress || state is AuthInitial) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return const LoginPage();
                },
              ),
            );
          },
        );
      },
    );
  }
}

