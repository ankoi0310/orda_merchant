import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/merchant_application/domain/entities/merchant_application.dart';

class MerchantApplicationModel extends MerchantApplication {
  const MerchantApplicationModel({
    required super.id,
    required super.userId,
    required super.shopName,
    required super.description,
    required super.address,
    required super.status,
  });

  factory MerchantApplicationModel.fromJson(JsonData json) {
    return MerchantApplicationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      shopName: json['shop_name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      status: _parseStatus(json['status'] as String),
    );
  }

  static ApplicationStatus _parseStatus(String status) =>
      switch (status) {
        'pending' => .pending,
        'approved' => .approved,
        _ => .rejected,
      };
}
