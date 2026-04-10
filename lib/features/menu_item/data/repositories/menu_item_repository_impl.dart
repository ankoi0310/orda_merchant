import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_item/data/datasources/menu_item_remote_data_source.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/repositories/menu_item_repository.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/create_menu_item_use_case.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/update_menu_item_use_case.dart';

class MenuItemRepositoryImpl implements MenuItemRepository {
  const MenuItemRepositoryImpl({required this.remoteDataSource});

  final MenuItemRemoteDataSource remoteDataSource;

  @override
  Stream<List<MenuItem>> watchMenuItems(String shopId) {
    return remoteDataSource.streamMenuItems(shopId);
  }

  @override
  ResultFuture<MenuItem> createMenuItem(
    CreateMenuItemParams params,
  ) async {
    try {
      final menuItem = await remoteDataSource.createMenuItem(params);
      return Right(menuItem);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Tạo món không thành công: $e'));
    }
  }

  @override
  ResultFuture<MenuItem> updateMenuItem(
    UpdateMenuItemParams params,
  ) async {
    try {
      final menuItem = await remoteDataSource.updateMenuItem(params);
      return Right(menuItem);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Cập nhật món không thành công: $e'));
    }
  }
}
