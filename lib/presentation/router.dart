import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/bloc/auth_bloc.dart';
import '../../presentation/bloc/auth_state.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/login_screen.dart';

GoRouter buildRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: BlocChangeNotifier(authBloc),
    redirect: (context, state) {
      if (authBloc.state is AuthAuthenticated) return '/home';
      if (authBloc.state is AuthUnauthenticated) return '/login';
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) =>
            const Scaffold(body: Center(child: FlutterLogo())),
      ),
      GoRoute(path: '/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
    ],
  );
}

class BlocChangeNotifier<T> extends ChangeNotifier {
  final BlocBase<T> bloc;
  late final void Function() _subscription;

  BlocChangeNotifier(this.bloc) {
    _subscription = bloc.stream.listen((_) {
      notifyListeners();
    }).cancel;
  }

  @override
  void dispose() {
    _subscription();
    super.dispose();
  }
}
