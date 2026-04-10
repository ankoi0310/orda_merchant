import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/repositories/menu_item_repository.dart';

class CreateMenuItemUseCase
    implements UseCase<MenuItem, MenuItemCreateParams> {
  const CreateMenuItemUseCase({required this.repository});

  final MenuItemRepository repository;

  @override
  ResultFuture<MenuItem> call(MenuItemCreateParams params) async {
    return repository.createMenuItem(name: params.name);
  }
}

class MenuItemCreateParams {
  const MenuItemCreateParams({
    required this.categoryId,
    required this.shopId,
    required this.name,
  });

  final String categoryId;
  final String shopId;
  final String name;
}
