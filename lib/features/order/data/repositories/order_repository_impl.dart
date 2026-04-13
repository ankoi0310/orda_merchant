import 'package:fpdart/fpdart.dart' hide Order;
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/order/data/datasources/order_remote_data_source.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  const OrderRepositoryImpl({required this.remoteDataSource});

  final OrderRemoteDataSource remoteDataSource;

  @override
  Stream<List<Order>> watchUpcomingOrders(String shopId) {
    return remoteDataSource.watchUpcomingOrders(shopId);
  }

  @override
  ResultFuture<List<Order>> getOrderHistory(String shopId) async {
    try {
      final orders = await remoteDataSource.getOrderHistory(shopId);
      return Right(orders);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          'Lấy lịch sử đơn hàng không thành công: ${e.message}',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure('Xảy ra lỗi khi lấy lịch sử đơn hàng: $e')
      );
    }
  }
}
