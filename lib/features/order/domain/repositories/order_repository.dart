import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';

abstract class OrderRepository {
  ResultFuture<List<Order>> fetchOrders();
  ResultFuture<bool> createOrder();
}
