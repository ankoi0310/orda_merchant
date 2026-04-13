import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/domain/repositories/order_repository.dart';

class WatchUpcomingOrdersUseCase {
  WatchUpcomingOrdersUseCase({required this.repository});

  final OrderRepository repository;

  Stream<List<Order>> call(String shopId) {
    return repository.watchUpcomingOrders(shopId);
  }
}
