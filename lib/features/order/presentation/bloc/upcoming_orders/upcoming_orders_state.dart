part of 'upcoming_orders_cubit.dart';

enum UpcomingOrdersStatus {
  initial,
  loading,
  updating,
  success,
  error,
}

final class UpcomingOrdersState extends Equatable {
  const UpcomingOrdersState({
    this.status = UpcomingOrdersStatus.initial,
    this.orders = const [],
    this.error,
  });

  final UpcomingOrdersStatus status;
  final List<Order> orders;
  final String? error;

  UpcomingOrdersState copyWith({
    UpcomingOrdersStatus? status,
    List<Order>? orders,
    String? error,
  }) {
    return UpcomingOrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      error: error ?? this.error,
    );
  }

  bool get isLoading => status == UpcomingOrdersStatus.loading;

  bool get isUpdating => status == UpcomingOrdersStatus.updating;

  bool get isSuccess => status == UpcomingOrdersStatus.success;

  bool get isError => status == UpcomingOrdersStatus.error;

  @override
  List<Object?> get props => [status, orders, error];
}
