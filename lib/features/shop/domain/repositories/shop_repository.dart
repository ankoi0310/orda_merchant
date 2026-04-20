import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';

abstract class ShopRepository {
  ResultFuture<List<Shop>> getShopList();
  ResultFuture<Shop> getShop({String? shopId});
  ResultFuture<Shop?> getCachedShop();
  VoidFuture cacheShop(Shop shop);
  VoidFuture removeCachedShop();
}
