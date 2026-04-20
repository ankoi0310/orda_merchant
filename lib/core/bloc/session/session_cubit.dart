import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient,
      super(SessionInitial()) {
    _init();
  }

  final SupabaseClient _supabaseClient;

  StreamSubscription<AuthState>? _sub;

  void _init() {
    final user = _supabaseClient.auth.currentUser;

    if (user != null) {
      emit(Authenticated(user));
    }

    _sub = _supabaseClient.auth.onAuthStateChange.listen((
      data,
    ) async {
      final session = data.session;

      if (session != null) {
        emit(Authenticated(session.user));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
