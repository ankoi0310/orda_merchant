import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';

abstract class MenuCategoryRepository {
  ResultFuture<List<MenuCategory>> getMenuCategoryList({
    required String shopId,
  });

  ResultFuture<MenuCategory> createMenuCategory({
    required String shopId,
    required String name,
  });
}
