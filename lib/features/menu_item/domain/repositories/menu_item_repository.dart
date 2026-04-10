import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/create_menu_item_use_case.dart';

abstract class MenuItemRepository {
  ResultFuture<List<MenuItem>> getMenuItemList({
    required String shopId,
    String? categoryId,
  });

  ResultFuture<MenuItem> createMenuItem(CreateMenuItemParams params);
}
