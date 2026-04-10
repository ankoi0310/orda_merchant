enum ShopMemberRole {
  owner('Chủ cửa hàng'),
  manager('Quản lý'),
  staff('Nhân viên');

  const ShopMemberRole(this.label);

  final String label;

  static ShopMemberRole fromString(String role) {
    return ShopMemberRole.values.firstWhere((e) => e.name == role);
  }
}
