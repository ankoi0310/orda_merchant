import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/core/constant/pref_keys.dart';
import 'package:orda_merchant/core/service/shared_prefs_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit({
    required SupabaseClient supabaseClient,
    required SharedPrefsService sharedPrefsService,
  }) : _supabaseClient = supabaseClient,
       _sharedPrefsService = sharedPrefsService,
       super(const SessionState()) {
    _init();
  }

  final SupabaseClient _supabaseClient;
  final SharedPrefsService _sharedPrefsService;

  StreamSubscription<AuthState>? _sub;

  Future<void> _init() async {
    final currentUser = _supabaseClient.auth.currentUser;
    final savedShopId = await _sharedPrefsService.getString(
      shopIdKey,
    );

    if (currentUser != null) {
      emit(state.copyWith(user: currentUser, shopId: savedShopId));
    }

    _sub = _supabaseClient.auth.onAuthStateChange.listen((
      data,
    ) async {
      final session = data.session;

      if (session != null) {
        emit(state.copyWith(user: session.user));
      } else {
        await _sharedPrefsService.remove(shopIdKey);
        emit(const SessionState());
      }
    });
  }

  Future<void> selectShop(String shopId) async {
    await _sharedPrefsService.setString(shopIdKey, shopId);
    emit(state.copyWith(shopId: shopId));
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
