import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/domain/repositories/order_repository.dart';

class GetOrderHistoryUseCase implements UseCase<List<Order>, String> {
  const GetOrderHistoryUseCase({required this.repository});

  final OrderRepository repository;

  @override
  ResultFuture<List<Order>> call(String shopId) async {
    return repository.getOrderHistory(shopId);
  }
}
