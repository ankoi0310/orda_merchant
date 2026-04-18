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
    required SignInWithPasswordUseCase signInWithPassword,
  }) : _signUpWithEmailPassword = signUpWithEmailPassword,
       _signInWithPassword = signInWithPassword,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<SignUpWithEmailPassword>(_onSignUpWithEmailPassword);
    on<SignInWithPassword>(_onSignInWithPassword);
  }

  final SignUpWithEmailPasswordUseCase _signUpWithEmailPassword;
  final SignInWithPasswordUseCase _signInWithPassword;

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

  Future<void> _onSignInWithPassword(
    SignInWithPassword event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _signInWithPassword(
      SignInWithPasswordParams(
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
