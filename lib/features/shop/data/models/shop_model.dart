import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';

class ShopModel extends Shop {
  const ShopModel({
    required super.id,
    required super.name,
    required super.description,
    required super.address,
    required super.imageUrl,
  });

  factory ShopModel.fromJson(JsonData json) {
    return ShopModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      imageUrl: json['image_url'] as String,
    );
  }
}
