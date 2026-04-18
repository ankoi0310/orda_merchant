import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/invitation/domain/entities/invitation.dart';
import 'package:orda_merchant/features/shop_member/domain/entities/shop_member.dart';

class InvitationModel extends Invitation {
  const InvitationModel({
    required super.id,
    required super.shopId,
    required super.email,
    required super.role,
    required super.invitedBy,
    required super.status,
    required super.createdAt,
  });

  factory InvitationModel.fromJson(JsonData json) {
    return InvitationModel(
      id: json['id'] as String,
      shopId: json['shop_id'] as String,
      email: json['email'] as String,
      role: _parseRole(json['role'] as String),
      invitedBy: json['invitedBy'] as String,
      status: _parseStatus(json['status'] as String),
      createdAt: json['createdAt'] as DateTime,
    );
  }

  static ShopMemberRole _parseRole(String role) => switch (role) {
    'owner' => .owner,
    'manager' => .manager,
    _ => .staff,
  };

  static InvitationStatus _parseStatus(String status) =>
      switch (status) {
        'pending' => .pending,
        _ => .accepted,
      };
}
