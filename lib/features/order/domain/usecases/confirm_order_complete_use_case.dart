import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/domain/repositories/order_repository.dart';

class ConfirmOrderCompleteUseCase implements UseCase<Order, String> {
  const ConfirmOrderCompleteUseCase({required this.repository});

  final OrderRepository repository;

  @override
  ResultFuture<Order> call(String orderId) async {
    return repository.updateOrderStatus(
      orderId: orderId,
      status: OrderStatus.completed.name,
    );
  }
}
