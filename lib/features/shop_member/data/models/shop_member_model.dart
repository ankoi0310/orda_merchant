import 'package:orda_merchant/core/enum/shop_member_role.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop_member/domain/entities/shop_member.dart';

class ShopMemberModel extends ShopMember {
  const ShopMemberModel({
    required super.id,
    required super.shopId,
    required super.userId,
    required super.role,
    required super.createdAt,
  });

  factory ShopMemberModel.fromJson(JsonData json) {
    return ShopMemberModel(
      id: json['id'] as String,
      shopId: json['shop_id'] as String,
      userId: json['user_id'] as String,
      role: ShopMemberRole.fromString(json['role'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
