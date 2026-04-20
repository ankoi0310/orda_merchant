import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop_member/domain/entities/shop_member.dart';
import 'package:orda_merchant/features/shop_member/domain/repositories/shop_member_repository.dart';

class LoadShopMemberListUseCase
    implements UseCase<List<ShopMember>, String> {
  const LoadShopMemberListUseCase({required this.repository});

  final ShopMemberRepository repository;

  @override
  ResultFuture<List<ShopMember>> call(String shopId) async {
    return repository.loadShopMemberList(shopId);
  }
}
