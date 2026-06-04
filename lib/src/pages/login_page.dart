import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import '../bloc/language/language_bloc.dart';
import '../bloc/language/language_event.dart';
import '../models/language.dart';
import '../bloc/theme/theme_bloc.dart';
import '../bloc/theme/theme_event.dart';
import '../../generated_l10n/app_localizations.dart';
import '../services/theme_service.dart';



class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    context.read<AuthBloc>().add(
          AuthLoginRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.signIn),
actions: [
          PopupMenuButton<AppThemeMode>(
            onSelected: (mode) {
              context.read<ThemeBloc>().add(ThemeChanged(mode));
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: AppThemeMode.light,
                child: Text('Light'),
              ),
              PopupMenuItem(
                value: AppThemeMode.dark,
                child: Text('Dark'),
              ),
              PopupMenuItem(
                value: AppThemeMode.system,
                child: Text('System'),
              ),
            ],
            icon: const Icon(Icons.brightness_6),
          ),
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
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      final errorMessage = state is AuthFailure ? state.message : null;
                      final isLoading = state is AuthLoadInProgress;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email_outlined),
                            ).copyWith(labelText: loc.email),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_outline),
                            ).copyWith(labelText: loc.password),
                          ),
                          const SizedBox(height: 24),
                          if (errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.error_outline, color: Colors.red),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      errorMessage,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          FilledButton.icon(
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(48),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            onPressed: isLoading ? null : _login,
                            icon: isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.login_outlined),
                            label: Text(
                              loc.loginButton,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
