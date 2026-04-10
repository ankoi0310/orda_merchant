import 'package:equatable/equatable.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';

class MenuCategory extends Equatable {
  const MenuCategory({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdAt,
  });

  factory MenuCategory.test({
    String? id,
    String? name,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return MenuCategory(
      id: id ?? 'category_123',
      name: name ?? 'Appetizers',
      isActive: isActive ?? true,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  final String id;
  final String name;
  final bool isActive;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, isActive, createdAt];
}

class MenuCategoryWithItems extends MenuCategory {
  const MenuCategoryWithItems({
    required super.id,
    required super.name,
    required super.isActive,
    required super.createdAt,
    required this.items,
  });

  factory MenuCategoryWithItems.test({
    String? id,
    String? name,
    bool? isActive,
    DateTime? createdAt,
    List<MenuItem>? items,
  }) {
    return MenuCategoryWithItems(
      id: id ?? MenuCategory.test().id,
      name: name ?? MenuCategory.test().name,
      isActive: isActive ?? MenuCategory.test().isActive,
      createdAt: createdAt ?? MenuCategory.test().createdAt,
      items: items ?? fakeMenuItems,
    );
  }

  final List<MenuItem> items;
}

final List<MenuCategoryWithItems> fakeCategories = [
  MenuCategoryWithItems.test(id: 'category_1', name: 'Appetizers'),
  MenuCategoryWithItems.test(id: 'category_2', name: 'Main Courses'),
  MenuCategoryWithItems.test(id: 'category_3', name: 'Desserts'),
  MenuCategoryWithItems.test(id: 'category_4', name: 'Beverages'),
  MenuCategoryWithItems.test(id: 'category_5', name: 'Salads'),
];
