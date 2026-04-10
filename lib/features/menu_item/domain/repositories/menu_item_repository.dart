import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';

abstract class MenuItemRepository {
  ResultFuture<List<MenuItem>> getMenuItemList();

  ResultFuture<MenuItem> createMenuItem({required String name});
}
