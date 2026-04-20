import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:orda_merchant/features/auth/domain/repositories/auth_repository.dart';
import 'package:orda_merchant/features/auth/domain/usecases/sign_in_with_password_use_case.dart';
import 'package:orda_merchant/features/auth/domain/usecases/sign_up_with_email_password_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.remoteDataSource});

  final AuthRemoteDataSource remoteDataSource;

  @override
  ResultFuture<User?> signUpWithEmailPassword(
    SignUpWithEmailPasswordParams params,
  ) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        params,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  ResultFuture<User?> SignInWithEmailPassword(
    SignInWithEmailPasswordParams params,
  ) async {
    try {
      final user = await remoteDataSource.signInWithEmailPassword(
        params,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
