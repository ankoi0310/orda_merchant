import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  const Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.imageUrl,
  });

  factory Shop.test({
    String? id,
    String? name,
    String? description,
    String? address,
    String? imageUrl,
  }) {
    return Shop(
      id: id ?? 'category_123',
      name: name ?? 'Appetizers',
      description: description ?? 'Mo ta',
      address: address ?? 'Dia chi cua quan',
      imageUrl:
          imageUrl ??
          'https://lzfesclzulylgfkqnhfy.supabase.co/storage/v1/object/public/images/default_shop.jpg',
    );
  }

  final String id;
  final String name;
  final String description;
  final String address;
  final String imageUrl;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    address,
    imageUrl,
  ];
}
