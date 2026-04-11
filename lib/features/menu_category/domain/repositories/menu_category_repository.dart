import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/create_menu_category_use_case.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/update_menu_category_use_case.dart';

abstract class MenuCategoryRepository {
  Stream<List<MenuCategory>> watchMenuCategories(String shopId);

  ResultFuture<MenuCategory> createMenuCategory(
    CreateMenuCategoryParams params,
  );

  ResultFuture<MenuCategory> updateMenuCategory(
    UpdateMenuCategoryParams params,
  );
}
