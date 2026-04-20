import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop_member/data/models/shop_member_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ShopMemberRemoteDataSource {
  Future<List<ShopMemberModel>> getShopMemberList(String shopId);
}

class ShopMemberRemoteDataSourceImpl
    implements ShopMemberRemoteDataSource {
  const ShopMemberRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<List<ShopMemberModel>> getShopMemberList(
    String shopId,
  ) async {
    try {
      final query = client
          .from('shop_members')
          .select()
          .eq('shop_id', shopId);

      final shopMembers = await query
          .withConverter<List<ShopMemberModel>>(
            (jsonList) => List<JsonData>.from(
              jsonList as List,
            ).map(ShopMemberModel.fromJson).toList(),
          );

      return shopMembers;
    } catch (e) {
      throw const ServerException(
        'Lấy danh sách thành viên cửa hàng không thành công',
      );
    }
  }
}
