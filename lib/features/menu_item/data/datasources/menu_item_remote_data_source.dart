import 'package:orda_merchant/features/menu_item/data/models/menu_item_model.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/create_menu_item_use_case.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/update_menu_item_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MenuItemRemoteDataSource {
  Stream<List<MenuItemModel>> streamMenuItems(String shopId);

  Future<MenuItemModel> createMenuItem(CreateMenuItemParams params);

  Future<MenuItemModel> updateMenuItem(UpdateMenuItemParams params);
}

class MenuItemRemoteDataSourceImpl
    implements MenuItemRemoteDataSource {
  const MenuItemRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Stream<List<MenuItemModel>> streamMenuItems(String shopId) {
    return client
        .from('menu_items')
        .stream(primaryKey: ['id'])
        .eq('shop_id', shopId)
        .map((jsonList) {
          return List.of(
            jsonList,
          ).map(MenuItemModel.fromJson).toList();
        });
  }

  @override
  Future<MenuItemModel> createMenuItem(
    CreateMenuItemParams params,
  ) async {
    final menuItem = await client
        .from('menu_items')
        .insert(params.toJson())
        .select('*, category:menu_categories!inner(*)')
        .single()
        .withConverter<MenuItemModel>(MenuItemModel.fromJson);
    return menuItem;
  }

  @override
  Future<MenuItemModel> updateMenuItem(
    UpdateMenuItemParams params,
  ) async {
    final menuItem = await client
        .from('menu_items')
        .update(params.toJson())
        .eq('id', params.id)
        .select('*, category:menu_categories!inner(*)')
        .single()
        .withConverter<MenuItemModel>(MenuItemModel.fromJson);
    return menuItem;
  }
}
