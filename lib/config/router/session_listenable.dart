import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocListenable<S> extends ChangeNotifier {
  BlocListenable(BlocBase<S> cubit) : _cubit = cubit {
    _subscription = cubit.stream.listen((_) => notifyListeners());
  }

  final BlocBase<S> _cubit;
  late final StreamSubscription<S> _subscription;

  S get state => _cubit.state;

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
