import 'package:orda_merchant/core/error/auth_error_mapper.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/features/auth/domain/usecases/sign_up_with_email_password_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<User?> signUpWithEmailPassword(
    SignUpWithEmailPasswordParams params,
  );

  Future<User?> signInWithPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<User?> signUpWithEmailPassword(
    SignUpWithEmailPasswordParams params,
  ) async {
    try {
      final response = await client.auth.signUp(
        email: params.email,
        password: params.password,
        data: params.toJson(),
      );

      return response.user;
    } on AuthException catch (e) {
      final errorMapper = AuthErrorMapper.map(e);
      throw ServerException(errorMapper.message);
    }
  }

  @override
  Future<User?> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response.user;
    } on AuthException catch (e) {
      final errorMapper = AuthErrorMapper.map(e);
      throw ServerException(errorMapper.message);
    }
  }
}
