import 'package:orda_merchant/features/menu_item/data/models/menu_item_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MenuItemRemoteDataSource {
  Future<List<MenuItemModel>> getMenuItemList();

  Future<MenuItemModel> createMenuItem({required String name});
}

class MenuItemRemoteDataSourceImpl
    implements MenuItemRemoteDataSource {
  const MenuItemRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<List<MenuItemModel>> getMenuItemList() async {
    final menuItems = await client
        .from('menu_items')
        .select()
        .withConverter<List<MenuItemModel>>((jsonList) {
          return List.of(
            jsonList,
          ).map(MenuItemModel.fromJson).toList();
        });

    return menuItems;
  }

  @override
  Future<MenuItemModel> createMenuItem({required String name}) async {
    final menuItem = await client
        .from('menu_items')
        .insert({'name': name})
        .select()
        .single()
        .withConverter<MenuItemModel>(MenuItemModel.fromJson);
    return menuItem;
  }
}
