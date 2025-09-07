import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rr_task/presentation/router.dart';
import 'package:rr_task/presentation/bloc/auth_event.dart';

import '../bloc/auth_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = GetIt.instance<AuthBloc>();

    return BlocProvider.value(
      value: authBloc..add(AuthChecked()),
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            routerConfig: buildRouter(authBloc),
            debugShowCheckedModeBanner: false,
            title: 'Test task',
          );
        },
      ),
    );
  }
}
