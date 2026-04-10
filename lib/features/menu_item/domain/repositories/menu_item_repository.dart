import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/create_menu_item_use_case.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/update_menu_item_use_case.dart';

abstract class MenuItemRepository {
  Stream<List<MenuItem>> watchMenuItems(String shopId);

  ResultFuture<MenuItem> createMenuItem(CreateMenuItemParams params);

  ResultFuture<MenuItem> updateMenuItem(UpdateMenuItemParams params);
}
