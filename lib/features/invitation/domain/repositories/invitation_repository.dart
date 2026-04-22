import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/create_invitation_use_case.dart';

abstract class InvitationRepository {
  ResultFuture<Invitation?> getInvitation({InvitationStatus? status});
  ResultFuture<Invitation> createInvitation(
    CreateInvitationParams params,
  );

  VoidFuture updateInvitationStatus({
    required String id,
    required InvitationStatus status,
  });
}
