import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/extensions/string_extension.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/shop/data/datasources/shop_local_data_source.dart';
import 'package:orda_merchant/features/shop/data/datasources/shop_remote_data_source.dart';
import 'package:orda_merchant/features/shop/data/models/shop_model.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/domain/repositories/shop_repository.dart';

class ShopRepositoryImpl implements ShopRepository {
  const ShopRepositoryImpl({required this.remoteDataSource, required this.localDataSource,});

  final ShopRemoteDataSource remoteDataSource;
  final ShopLocalDataSource localDataSource;

  @override
  ResultFuture<Shop> getShop({String? shopId}) async {
    if (shopId == null || !shopId.isValidUuid) {
      return const Left(
        ValidationFailure('Mã cửa hàng không hợp lệ'),
      );
    }

    try {
      final shop = await remoteDataSource.getShop(shopId: shopId);
      return right(shop);
    } on ServerException catch (e) {
      return left(ValidationFailure(e.message));
    }
  }

  @override
  ResultFuture<List<Shop>> getShopList() async {
    try {
      final shops = await remoteDataSource.getShopList();

      return Right(shops);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure('Xảy ra lỗi khi tải danh sách cửa hàng: $e'),
      );
    }
  }

  @override
  VoidFuture cacheShop(Shop shop) async {
    try {
    await localDataSource.cacheShop(ShopModel.fromEntity(shop));
    return const Right(unit);
  } on CacheException catch (e) {
    return Left(CacheFailure(e.message));
    }
  }

  @override
  ResultFuture<Shop?> getCachedShop() async {
    try {
      final shop = await localDataSource.getCachedShop();
      return Right(shop);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
