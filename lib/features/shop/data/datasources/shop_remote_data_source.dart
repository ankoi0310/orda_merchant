import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop/data/models/shop_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ShopRemoteDataSource {
  Future<List<ShopModel>> getShopList();

  Future<ShopModel> getShop({required String shopId});

  Future<ShopModel> updateShop({required String shopId});
}

class ShopRemoteDataSourceImpl implements ShopRemoteDataSource {
  const ShopRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<List<ShopModel>> getShopList() async {
    final shops = await client
        .from('shops')
        .select()
        .withConverter<List<ShopModel>>(
          (jsonList) => List<JsonData>.from(
            jsonList as List,
          ).map(ShopModel.fromJson).toList(),
        );

    return shops;
  }

  @override
  Future<ShopModel> getShop({required String shopId}) async {
    final json = await client
        .from('shops')
        .select('*, menu_categories(*, menu_items(*))')
        .eq('id', shopId)
        .maybeSingle();

    if (json == null) {
      throw const ServerException('Không tìm thấy cửa hàng');
    }

    return ShopModel.fromJson(json);
  }

  @override
  Future<ShopModel> updateShop({required String shopId}) async {
    throw UnimplementedError();
  }
}
