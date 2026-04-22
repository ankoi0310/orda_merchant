import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/invitation/data/datasources/invitation_remote_data_source.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/repositories/invitation_repository.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/create_invitation_use_case.dart';

class InvitationRepositoryImpl implements InvitationRepository {
  const InvitationRepositoryImpl({required this.remoteDataSource});

  final InvitationRemoteDataSource remoteDataSource;

  @override
  ResultFuture<Invitation?> getInvitation({
    InvitationStatus? status,
  }) async {
    try {
      final invitation = await remoteDataSource.getInvitation(
        status: status,
      );
      return Right(invitation);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  ResultFuture<Invitation> createInvitation(
    CreateInvitationParams params,
  ) async {
    try {
      final invitation = await remoteDataSource.createInvitation(
        params,
      );
      return Right(invitation);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  VoidFuture updateInvitationStatus({
    required String id,
    required InvitationStatus status,
  }) async {
    try {
      await remoteDataSource.updateInvitationStatus(
        id: id,
        status: status,
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
