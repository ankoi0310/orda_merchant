import 'package:orda_merchant/core/constant/pref_keys.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/service/shared_prefs_service.dart';
import 'package:orda_merchant/features/shop/data/models/shop_model.dart';

abstract class ShopLocalDataSource {
  Future<ShopModel?> getCachedShop();

  Future<void> cacheShop(ShopModel shop);
  Future<void> removeCachedShop();
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

  @override
  Future<void> removeCachedShop() async {
    if (!sharedPrefsService.keyExists(shopKey)) {
      throw const CacheException(
        'Cửa hàng không tồn tại trong bộ nhớ tạm',
      );
    }

    return sharedPrefsService.remove(shopKey);
  }
}
