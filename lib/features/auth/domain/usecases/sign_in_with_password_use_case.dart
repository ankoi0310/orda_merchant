import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInWithPasswordUseCase
    implements UseCase<User?, SignInWithPasswordParams> {
  const SignInWithPasswordUseCase({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<User?> call(SignInWithPasswordParams params) async {
    return repository.signInWithPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInWithPasswordParams {
  const SignInWithPasswordParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
