import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop_member/domain/entities/shop_member.dart';

abstract class ShopMemberRepository {
  ResultFuture<List<ShopMember>> loadShopMemberList(String shopId);
}
