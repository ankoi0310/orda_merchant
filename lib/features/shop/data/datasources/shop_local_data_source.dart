import 'package:orda_merchant/core/constant/pref_keys.dart';
import 'package:orda_merchant/core/service/shared_prefs_service.dart';
import 'package:orda_merchant/features/shop/data/models/shop_model.dart';

abstract class ShopLocalDataSource {
  Future<ShopModel?> getCachedShop();

  Future<void> cacheShop(ShopModel shop);
}

class ShopLocalDataSourceImpl implements ShopLocalDataSource {
  const ShopLocalDataSourceImpl({required this.sharedPrefsService});

  final SharedPrefsService sharedPrefsService;

  @override
  Future<ShopModel?> getCachedShop() {
    return sharedPrefsService.getObject<ShopModel>(
      shopKey,
      ShopModel.fromJson,
    );
  }

  @override
  Future<void> cacheShop(ShopModel shop) {
    return sharedPrefsService.setObject(shopKey, shop.toJson());
  }
}
