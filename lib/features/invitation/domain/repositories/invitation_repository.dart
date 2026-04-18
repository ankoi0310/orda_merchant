import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/usecases/create_invitation_use_case.dart';

abstract class InvitationRepository {
  ResultFuture<Invitation> createInvitation(InvitationParams params);
}
