import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/repositories/menu_item_repository.dart';

class WatchMenuItemsUseCase {
  WatchMenuItemsUseCase({required this.repository});

  final MenuItemRepository repository;

  Stream<List<MenuItem>> call(String shopId) {
    return repository.watchMenuItems(shopId);
  }
}
