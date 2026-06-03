import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/language/language_bloc.dart';
import '../bloc/language/language_event.dart';
import '../models/language.dart';
import '../../generated_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _signOut(BuildContext context) {
    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;

        return Scaffold(
          appBar: AppBar(
            title: Text(loc.home),
            actions: [
              PopupMenuButton<AppLanguage>(
                onSelected: (language) {
                  context.read<LanguageBloc>().add(LanguageChanged(language));
                },
                itemBuilder: (context) => AppLanguage.values
                    .map((lang) => PopupMenuItem(
                          value: lang,
                          child: Text(lang.label),
                        ))
                    .toList(),
                icon: const Icon(Icons.language),
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => _signOut(context),
                tooltip: loc.logout,
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${loc.welcome}, ${user?.displayLabel ?? loc.user}!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'The app is prepared for authentication and future API integration.',
                    textAlign: TextAlign.center,
                  ),
                  if (user != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      '${loc.user}: ${user.email}',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
