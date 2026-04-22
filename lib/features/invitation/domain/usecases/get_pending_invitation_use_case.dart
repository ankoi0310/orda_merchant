import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/repositories/invitation_repository.dart';

class GetPendingInvitationUseCase
    implements UseCaseWithoutParams<Invitation?> {
  const GetPendingInvitationUseCase({required this.repository});

  final InvitationRepository repository;

  @override
  ResultFuture<Invitation?> call() async {
    return repository.getInvitation(status: InvitationStatus.pending);
  }
}
