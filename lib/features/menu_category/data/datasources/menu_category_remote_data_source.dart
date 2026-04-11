import 'package:orda_merchant/features/menu_category/data/models/menu_category_model.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/create_menu_category_use_case.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/update_menu_category_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MenuCategoryRemoteDataSource {
  Stream<List<MenuCategoryModel>> streamMenuCategories(String shopId);

  Future<MenuCategoryModel> createMenuCategory(
    CreateMenuCategoryParams params,
  );

  Future<MenuCategoryModel> updateMenuCategory(
    UpdateMenuCategoryParams params,
  );
}

class MenuCategoryRemoteDataSourceImpl
    implements MenuCategoryRemoteDataSource {
  const MenuCategoryRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Stream<List<MenuCategoryModel>> streamMenuCategories(
    String shopId,
  ) {
    return client
        .from('menu_categories')
        .stream(primaryKey: ['id'])
        .eq('shop_id', shopId)
        .map((jsonList) {
          return List.of(
            jsonList,
          ).map(MenuCategoryModel.fromJson).toList();
        });
  }

  @override
  Future<MenuCategoryModel> createMenuCategory(
    CreateMenuCategoryParams params,
  ) async {
    final menuCategory = await client
        .from('menu_categories')
        .insert(params.toJson())
        .select()
        .single()
        .withConverter<MenuCategoryModel>(MenuCategoryModel.fromJson);
    return menuCategory;
  }

  @override
  Future<MenuCategoryModel> updateMenuCategory(
    UpdateMenuCategoryParams params,
  ) async {
    final menuCategory = await client
        .from('menu_categories')
        .update(params.toJson())
        .select()
        .single()
        .withConverter<MenuCategoryModel>(MenuCategoryModel.fromJson);
    return menuCategory;
  }
}
