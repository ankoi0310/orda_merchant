import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/domain/repositories/shop_repository.dart';

class GetCachedShopUseCase implements UseCaseWithoutParams<Shop?> {
  const GetCachedShopUseCase({required this.repository});

  final ShopRepository repository;

  @override
  ResultFuture<Shop?> call() async {
    return repository.getCachedShop();
  }
}
