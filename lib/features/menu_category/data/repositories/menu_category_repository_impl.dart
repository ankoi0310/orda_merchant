import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_category/data/datasources/menu_category_remote_data_source.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/repositories/menu_category_repository.dart';

class MenuCategoryRepositoryImpl implements MenuCategoryRepository {
  const MenuCategoryRepositoryImpl({required this.remoteDataSource});

  final MenuCategoryRemoteDataSource remoteDataSource;

  @override
  ResultFuture<List<MenuCategory>> getMenuCategoryList({
    required String shopId,
  }) async {
    try {
      final categories = await remoteDataSource.getMenuCategoryList(
        shopId: shopId,
      );
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(
        ServerFailure(
          'Xảy ra lỗi khi tải danh sách nhóm thực đơn: $e',
        ),
      );
    }
  }

  @override
  ResultFuture<MenuCategory> createMenuCategory({
    required String name,
    required String shopId,
  }) async {
    try {
      final category = await remoteDataSource.createMenuCategory(
        name: name,
        shopId: shopId,
      );
      return Right(category);
    } on ServerException {
      return const Left(ServerFailure('Tạo nhóm không thành công'));
    } catch (e) {
      return Left(
        ServerFailure('Xảy ra lỗi khi tạo nhóm thực đơn: $e'),
      );
    }
  }
}
