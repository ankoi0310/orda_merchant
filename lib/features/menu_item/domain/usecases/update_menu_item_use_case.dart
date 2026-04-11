import 'dart:io';

import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/repositories/menu_item_repository.dart';

class UpdateMenuItemUseCase
    implements UseCase<MenuItem, UpdateMenuItemParams> {
  const UpdateMenuItemUseCase({required this.repository});

  final MenuItemRepository repository;

  @override
  ResultFuture<MenuItem> call(UpdateMenuItemParams params) async {
    return repository.updateMenuItem(params);
  }
}

class UpdateMenuItemParams {
  const UpdateMenuItemParams({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    this.file,
  });

  final String id;
  final String? categoryId;
  final String name;
  final String description;
  final int price;
  final File? file;

  JsonData toJson() {
    return {
      'category_id': categoryId,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}
