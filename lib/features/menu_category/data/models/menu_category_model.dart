import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_item/data/models/menu_item_model.dart';

class MenuCategoryModel extends MenuCategory {
  const MenuCategoryModel({
    required super.id,
    required super.name,
    required super.isActive,
    required super.createdAt,
  });

  factory MenuCategoryModel.fromJson(JsonData json) {
    return MenuCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

class MenuCategoryModelWithItems extends MenuCategoryWithItems {
  const MenuCategoryModelWithItems({
    required super.id,
    required super.name,
    required super.isActive,
    required super.createdAt,
    required super.items,
  });

  factory MenuCategoryModelWithItems.fromJson(JsonData json) {
    return MenuCategoryModelWithItems(
      id: json['id'] as String,
      name: json['name'] as String,
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      items: List.of(
        json['items'] as List<JsonData>,
      ).map(MenuItemModel.fromJson).toList(),
    );
  }
}
