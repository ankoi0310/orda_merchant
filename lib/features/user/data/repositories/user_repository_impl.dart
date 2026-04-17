import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/user/data/datasource/user_remote_data_source.dart';
import 'package:orda_merchant/features/user/domain/entities/user_profile.dart';
import 'package:orda_merchant/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({required this.remoteDataSource});

  final UserRemoteDataSource remoteDataSource;

  @override
  ResultFuture<UserProfile> getUserProfile() async {
    try {
      final userProfile = await remoteDataSource.getUserProfile();
      return Right(userProfile);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  VoidFuture signOut() async {
    await remoteDataSource.signOut();
    return const Right(unit);
  }
}
