import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/repositories/invitation_repository.dart';

class AcceptInvitationUseCase implements UseCase<void, String> {
  const AcceptInvitationUseCase({required this.repository});

  final InvitationRepository repository;

  @override
  VoidFuture call(String id) async {
    return repository.updateInvitationStatus(
      id: id,
      status: InvitationStatus.accepted,
    );
  }
}
