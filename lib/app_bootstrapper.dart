import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/bloc/session/session_cubit.dart';
import 'package:orda_merchant/core/bloc/user_setup/user_setup_cubit.dart';

class AppBootstrapper extends StatefulWidget {
  const AppBootstrapper({required this.child, super.key});

  final Widget child;

  @override
  State<AppBootstrapper> createState() => _AppBootstrapperState();
}

class _AppBootstrapperState extends State<AppBootstrapper> {
  late final StreamSubscription<SessionState> _sub;

  @override
  void initState() {
    super.initState();

    _sub = context.read<SessionCubit>().stream.listen((session) {
      if (session is Authenticated) {
        context.read<UserSetupCubit>().loadUserData();
      } else if (session is Unauthenticated) {
        context.read<UserSetupCubit>().reset();
      }
    });

    final currentSession = context.read<SessionCubit>().state;
    if (currentSession is Authenticated) {
      context.read<UserSetupCubit>().loadUserData();
    }
  }

  @override
  Future<void> dispose() async {
    await _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
