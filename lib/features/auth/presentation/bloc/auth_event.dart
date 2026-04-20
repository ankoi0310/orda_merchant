part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class SignUpWithEmailPassword extends AuthEvent {
  const SignUpWithEmailPassword({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  @override
  List<Object?> get props => [fullName, email, password];
}

final class SignInWithEmailPassword extends AuthEvent {
  const SignInWithEmailPassword({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
