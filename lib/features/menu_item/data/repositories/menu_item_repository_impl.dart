import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/data/datasources/menu_item_remote_data_source.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/repositories/menu_item_repository.dart';

class MenuItemRepositoryImpl implements MenuItemRepository {
  const MenuItemRepositoryImpl({required this.remoteDataSource});

  final MenuItemRemoteDataSource remoteDataSource;

  @override
  ResultFuture<List<MenuItem>> getMenuItemList() async {
    // TODO: implement getMenuItemList
    throw UnimplementedError();
  }

  @override
  ResultFuture<MenuItem> createMenuItem({
    required String name,
  }) async {
    // TODO: implement createMenuItem
    throw UnimplementedError();
  }
}
