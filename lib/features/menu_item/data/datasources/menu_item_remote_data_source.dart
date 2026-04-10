import 'package:orda_merchant/features/menu_item/data/models/menu_item_model.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/create_menu_item_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MenuItemRemoteDataSource {
  Future<List<MenuItemModel>> getMenuItemList({
    required String shopId,
    String? categoryId,
  });

  Future<MenuItemModel> createMenuItem(CreateMenuItemParams params);
}

class MenuItemRemoteDataSourceImpl
    implements MenuItemRemoteDataSource {
  const MenuItemRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<List<MenuItemModel>> getMenuItemList({
    required String shopId,
    String? categoryId,
  }) async {
    final menuItems = await client
        .from('menu_items')
        .select()
        .eq('shop_id', shopId)
        .withConverter<List<MenuItemModel>>((jsonList) {
          return List.of(
            jsonList,
          ).map(MenuItemModel.fromJson).toList();
        });

    return menuItems;
  }

  @override
  Future<MenuItemModel> createMenuItem(
    CreateMenuItemParams params,
  ) async {
    final menuItem = await client
        .from('menu_items')
        .insert(params.toJson())
        .select()
        .single()
        .withConverter<MenuItemModel>(MenuItemModel.fromJson);
    return menuItem;
  }
}
