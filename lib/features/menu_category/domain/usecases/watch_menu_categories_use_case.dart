import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/repositories/menu_category_repository.dart';

class WatchMenuCategoriesUseCase {
  WatchMenuCategoriesUseCase({required this.repository});

  final MenuCategoryRepository repository;

  Stream<List<MenuCategory>> call(String shopId) {
    return repository.watchMenuCategories(shopId);
  }
}
