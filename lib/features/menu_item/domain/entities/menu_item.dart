import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  const MenuItem({
    required this.id,
    required this.categoryId,
    required this.shopId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isAvailable,
    required this.createdAt,
  });

  factory MenuItem.test({
    String? id,
    String? categoryId,
    String? shopId,
    String? name,
    String? description,
    String? imageUrl,
    int? price,
    bool? isAvailable,
    DateTime? createdAt,
  }) {
    return MenuItem(
      id: id ?? 'item_123',
      categoryId: categoryId ?? 'category_123',
      shopId: shopId ?? 'shop_123',
      name: name ?? 'Spring Rolls',
      description:
          description ?? 'Crispy spring rolls with vegetables.',
      imageUrl: imageUrl ?? '',
      price: price ?? 20000,
      isAvailable: isAvailable ?? true,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  final String id;
  final String categoryId;
  final String shopId;
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  final bool isAvailable;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
    id,
    categoryId,
    name,
    description,
    imageUrl,
    price,
    isAvailable,
    createdAt,
  ];
}

final List<MenuItem> fakeMenuItems = [
  MenuItem.test(id: 'item_1', name: 'Spring Rolls'),
  MenuItem.test(id: 'item_2', name: 'Grilled Chicken'),
  MenuItem.test(id: 'item_3', name: 'Chocolate Cake'),
  MenuItem.test(id: 'item_4', name: 'Lemonade'),
  MenuItem.test(id: 'item_5', name: 'Caesar Salad'),
];
