import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_category/data/datasources/menu_category_remote_data_source.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/repositories/menu_category_repository.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/create_menu_category_use_case.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/update_menu_category_use_case.dart';

class MenuCategoryRepositoryImpl implements MenuCategoryRepository {
  const MenuCategoryRepositoryImpl({required this.remoteDataSource});

  final MenuCategoryRemoteDataSource remoteDataSource;

  @override
  Stream<List<MenuCategory>> watchMenuCategories(String shopId) {
    return remoteDataSource.streamMenuCategories(shopId);
  }

  @override
  ResultFuture<MenuCategory> createMenuCategory(
    CreateMenuCategoryParams params,
  ) async {
    try {
      final category = await remoteDataSource.createMenuCategory(
        params,
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

  @override
  ResultFuture<MenuCategory> updateMenuCategory(
    UpdateMenuCategoryParams params,
  ) async {
    try {
      final category = await remoteDataSource.updateMenuCategory(
        params,
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
