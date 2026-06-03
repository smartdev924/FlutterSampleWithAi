import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _signOut(BuildContext context) {
    context.read<AuthBloc>().add(const AuthLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => _signOut(context),
                tooltip: 'Sign out',
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
                    'Welcome, ${user?.displayLabel ?? 'User'}!',
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
                      'Signed in as ${user.email}',
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
