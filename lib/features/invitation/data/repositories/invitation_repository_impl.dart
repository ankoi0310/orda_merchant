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
  ResultFuture<Invitation> createInvitation(
    InvitationParams params,
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
}
