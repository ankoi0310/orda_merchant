import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/domain/repositories/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  ResultFuture<bool> createOrder() {
    // TODO: implement createOrder
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Order>> fetchOrders() {
    // TODO: implement fetchOrders
    throw UnimplementedError();
  }
}
