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
  ResultFuture<List<Order>> fetchOrders(String shopId) async {
    // TODO: implement fetchOrders
    throw UnimplementedError();
  }
}
