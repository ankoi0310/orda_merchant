import 'package:equatable/equatable.dart';
import 'package:orda_merchant/features/shop_member/domain/entities/shop_member.dart';

enum InvitationStatus { pending, accepted }

class Invitation extends Equatable {
  const Invitation({
    required this.id,
    required this.shopId,
    required this.email,
    required this.role,
    required this.invitedBy,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String shopId;
  final String email;
  final ShopMemberRole role;
  final String invitedBy;
  final InvitationStatus status;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
    id,
    shopId,
    email,
    role,
    invitedBy,
    status,
    createdAt,
  ];
}
