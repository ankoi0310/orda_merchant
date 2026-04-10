import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/repositories/menu_item_repository.dart';

class CreateMenuItemUseCase
    implements UseCase<MenuItem, CreateMenuItemParams> {
  const CreateMenuItemUseCase({required this.repository});

  final MenuItemRepository repository;

  @override
  ResultFuture<MenuItem> call(CreateMenuItemParams params) async {
    return repository.createMenuItem(params);
  }
}

class CreateMenuItemParams {
  const CreateMenuItemParams({
    required this.categoryId,
    required this.shopId,
    required this.name,
    required this.description,
    required this.price,
  });

  final String? categoryId;
  final String? shopId;
  final String name;
  final String description;
  final int price;

  JsonData toJson() {
    return {
      'category_id': categoryId,
      'shop_id': shopId,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}
