import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';

class MenuItemModel extends MenuItem {
  const MenuItemModel({
    required super.id,
    required super.categoryId,
    required super.shopId,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.price,
    required super.isAvailable,
    required super.createdAt,
  });

  factory MenuItemModel.fromJson(JsonData json) {
    return MenuItemModel(
      id: json['id'] as String,
      categoryId: json['category_id'] as String,
      shopId: json['shop_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      price: json['price'] as int,
      isAvailable: json['is_available'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
