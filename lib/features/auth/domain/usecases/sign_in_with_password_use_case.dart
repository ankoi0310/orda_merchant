import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInWithEmailPasswordUseCase
    implements UseCase<User?, SignInWithEmailPasswordParams> {
  const SignInWithEmailPasswordUseCase({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<User?> call(
    SignInWithEmailPasswordParams params,
  ) async {
    return repository.SignInWithEmailPassword(params);
  }
}

class SignInWithEmailPasswordParams {
  const SignInWithEmailPasswordParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
