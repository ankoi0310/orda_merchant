import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpWithEmailPasswordUseCase
    implements UseCase<User?, SignUpWithEmailPasswordParams> {
  const SignUpWithEmailPasswordUseCase({required this.repository});

  final AuthRepository repository;

  @override
  ResultFuture<User?> call(
    SignUpWithEmailPasswordParams params,
  ) async {
    return repository.signUpWithEmailPassword(params);
  }
}

class SignUpWithEmailPasswordParams {
  const SignUpWithEmailPasswordParams({
    required this.fullName,
    required this.email,
    required this.password,
  });

  final String fullName;
  final String email;
  final String password;

  JsonData toJson() {
    return {'full_name': fullName};
  }
}
