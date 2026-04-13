import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/domain/usecases/get_order_history_use_case.dart';

part 'history_orders_state.dart';

class HistoryOrdersCubit extends Cubit<HistoryOrdersState> {
  HistoryOrdersCubit({
    required GetOrderHistoryUseCase getOrderHistory,
  }) : _getOrderHistory = getOrderHistory,
       super(const HistoryOrdersState());

  final GetOrderHistoryUseCase _getOrderHistory;

  /// Move order from current tab to history tab, add complete status
  void confirmComplete(Order order) {
    final updateOrder = order.copyWith(status: OrderStatus.completed);
    final orders = [updateOrder, ...state.orders];
    emit(state.copyWith(orders: orders));
  }

  /// Update pagination later
  Future<void> getOrderHistory(String shopId) async {
    emit(state.copyWith(status: HistoryOrdersStatus.loading));

    final result = await _getOrderHistory(shopId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HistoryOrdersStatus.error,
          error: failure.message,
        ),
      ),
      (orders) => emit(
        state.copyWith(
          status: HistoryOrdersStatus.success,
          orders: orders,
        ),
      ),
    );
  }

  Future<void> refresh(String shopId) async {
    await getOrderHistory(shopId);
  }
}
