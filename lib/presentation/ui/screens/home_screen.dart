import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rr_task/presentation/ui/widgets/loading_indicator.dart';

import '../../../core/utils/ui_constants.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';
import '../../bloc/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AuthBloc>().state;

    String username = (state as AuthAuthenticated).user.username;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, $username',
              style: const TextStyle(fontSize: UIConstants.titleFontSize),
            ),
            const SizedBox(height: UIConstants.buttonSpacing),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                final isLoading = state is AuthLoading;
                return ElevatedButton(
                  onPressed: !isLoading
                      ? () {
                          context.read<AuthBloc>().add(AuthLogoutRequested());
                        }
                      : null,
                  child: isLoading ? LoadingIndicator() : const Text('Logout'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
