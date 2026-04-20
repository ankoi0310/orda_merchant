import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop_member/data/datasources/shop_member_remote_data_source.dart';
import 'package:orda_merchant/features/shop_member/domain/entities/shop_member.dart';
import 'package:orda_merchant/features/shop_member/domain/repositories/shop_member_repository.dart';

class ShopMemberRepositoryImpl implements ShopMemberRepository {
  const ShopMemberRepositoryImpl({required this.remoteDataSource});

  final ShopMemberRemoteDataSource remoteDataSource;

  @override
  ResultFuture<List<ShopMember>> loadShopMemberList(
    String shopId,
  ) async {
    try {
      final shopMembers = await remoteDataSource.getShopMemberList(
        shopId,
      );

      return Right(shopMembers);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Lỗi khi tải danh sách thành viên $e'),
      );
    }
  }
}
