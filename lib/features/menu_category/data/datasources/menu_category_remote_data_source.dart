import 'package:orda_merchant/features/menu_category/data/models/menu_category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MenuCategoryRemoteDataSource {
  Future<List<MenuCategoryModel>> getMenuCategoryList({
    required String shopId,
  });

  Future<MenuCategoryModel> createMenuCategory({
    required String name,
    required String shopId,
  });
}

class MenuCategoryRemoteDataSourceImpl
    implements MenuCategoryRemoteDataSource {
  const MenuCategoryRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<List<MenuCategoryModel>> getMenuCategoryList({
    required String shopId,
  }) async {
    final menuCategories = await client
        .from('menu_categories')
        .select()
        .eq('shop_id', shopId)
        .withConverter<List<MenuCategoryModel>>((jsonList) {
          return List.of(
            jsonList,
          ).map(MenuCategoryModel.fromJson).toList();
        });

    return menuCategories;
  }

  @override
  Future<MenuCategoryModel> createMenuCategory({
    required String shopId,
    required String name,
  }) async {
    final menuCategory = await client
        .from('menu_categories')
        .insert({'name': name, 'shop_id': shopId})
        .select()
        .single()
        .withConverter<MenuCategoryModel>(MenuCategoryModel.fromJson);
    return menuCategory;
  }
}
