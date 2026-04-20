import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop/domain/repositories/shop_repository.dart';

class RemoveCachedShopUseCase implements UseCaseWithoutParams<void> {
  const RemoveCachedShopUseCase({required this.repository});

  final ShopRepository repository;

  @override
  VoidFuture call() async {
    return repository.removeCachedShop();
  }
}
