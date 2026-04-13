part of 'history_orders_cubit.dart';

enum HistoryOrdersStatus { initial, loading, success, error }

final class HistoryOrdersState extends Equatable {
  const HistoryOrdersState({
    this.status = HistoryOrdersStatus.initial,
    this.orders = const [],
    this.error,
  });

  final HistoryOrdersStatus status;
  final List<Order> orders;
  final String? error;

  HistoryOrdersState copyWith({
    HistoryOrdersStatus? status,
    List<Order>? orders,
    String? error,
  }) {
    return HistoryOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == HistoryOrdersStatus.loading;

  bool get isSuccess => status == HistoryOrdersStatus.success;

  bool get isError => status == HistoryOrdersStatus.error;

  @override
  List<Object?> get props => [status, orders, error];
}
