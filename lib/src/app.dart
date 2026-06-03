import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/auth/auth_event.dart';
import 'bloc/auth/auth_state.dart';
import 'bloc/language/language_bloc.dart';
import 'bloc/language/language_event.dart';
import 'bloc/language/language_state.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
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
        return MaterialApp(
          title: 'Flutter Auth Starter',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
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

              return const LoginPage();
            },
          ),
        );
      },
    );
  }
}
