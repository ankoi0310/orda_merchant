import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/invitation/domain/repositories/invitation_repository.dart';
import 'package:orda_merchant/features/shop_member/domain/entities/shop_member.dart';

class CreateInvitationUseCase
    implements UseCase<Invitation, CreateInvitationParams> {
  const CreateInvitationUseCase({required this.repository});

  final InvitationRepository repository;

  @override
  ResultFuture<Invitation> call(CreateInvitationParams params) async {
    return repository.createInvitation(params);
  }
}

class CreateInvitationParams {
  const CreateInvitationParams({
    required this.shopId,
    required this.email,
    required this.role,
    required this.invitedBy,
  });

  final String shopId;
  final String email;
  final ShopMemberRole role;
  final String invitedBy;

  Map<String, dynamic> toJson() {
    return {
      'shop_id': shopId,
      'email': email,
      'role': role,
      'invited_by': invitedBy,
    };
  }
}
