import 'package:equatable/equatable.dart';

enum ShopMemberRole {
  owner('Chủ cửa hàng'),
  manager('Quản lý'),
  staff('Nhân viên');

  const ShopMemberRole(this.label);

  final String label;
}

class ShopMember extends Equatable {
  const ShopMember({
    required this.id,
    required this.shopId,
    required this.userId,
    required this.role,
    required this.createdAt,
  });

  final String id;
  final String shopId;
  final String userId;
  final ShopMemberRole role;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, shopId, userId, role, createdAt];
}
