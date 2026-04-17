import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/domain/repositories/shop_repository.dart';

class CacheShopUseCase implements UseCase<void, Shop> {
  const CacheShopUseCase({required this.repository});

  final ShopRepository repository;

  @override
  ResultFuture<void> call(Shop shop) async {
    return repository.cacheShop(shop);
  }
}
