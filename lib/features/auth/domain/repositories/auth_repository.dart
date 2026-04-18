import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/auth/domain/usecases/sign_up_with_email_password_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  ResultFuture<User?> signUpWithEmailPassword(
    SignUpWithEmailPasswordParams params,
  );

  ResultFuture<User?> signInWithPassword({
    required String email,
    required String password,
  });
}
