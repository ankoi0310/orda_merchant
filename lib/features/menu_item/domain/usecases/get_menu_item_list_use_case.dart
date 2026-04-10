import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/repositories/menu_item_repository.dart';

class GetMenuItemListUseCase
    implements UseCase<List<MenuItem>, String> {
  const GetMenuItemListUseCase({required this.repository});

  final MenuItemRepository repository;

  @override
  ResultFuture<List<MenuItem>> call(String shopId) async {
    return repository.getMenuItemList(shopId: shopId);
  }
}
