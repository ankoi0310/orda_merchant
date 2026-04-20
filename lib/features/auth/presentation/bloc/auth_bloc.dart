import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/auth/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:orda_merchant/features/auth/domain/usecases/sign_up_with_email_password_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required SignUpWithEmailPasswordUseCase signUpWithEmailPassword,
    required SignInWithEmailPasswordUseCase signInWithEmailPassword,
  }) : _signUpWithEmailPassword = signUpWithEmailPassword,
       _signInWithEmailPassword = signInWithEmailPassword,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<SignUpWithEmailPassword>(_onSignUpWithEmailPassword);
    on<SignInWithEmailPassword>(_onSignInWithEmailPassword);
  }

  final SignUpWithEmailPasswordUseCase _signUpWithEmailPassword;
  final SignInWithEmailPasswordUseCase _signInWithEmailPassword;

  Future<void> _onSignUpWithEmailPassword(
    SignUpWithEmailPassword event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signUpWithEmailPassword(
      SignUpWithEmailPasswordParams(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onSignInWithEmailPassword(
    SignInWithEmailPassword event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signInWithEmailPassword(
      SignInWithEmailPasswordParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
