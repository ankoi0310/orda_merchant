import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';

abstract class OrderRepository {
  Stream<List<Order>> watchUpcomingOrders(String shopId);

  ResultFuture<List<Order>> getOrderHistory(String shopId);

  ResultFuture<Order> updateOrderStatus({
    required String orderId,
    required String status,
  });
}
