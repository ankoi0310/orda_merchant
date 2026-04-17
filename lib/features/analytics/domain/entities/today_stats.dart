import 'package:equatable/equatable.dart';

class TodayStats extends Equatable {
  const TodayStats({
    required this.totalOrders,
    required this.pendingOrders,
    required this.completedOrders,
    required this.totalRevenue,
  });

  final int totalOrders;
  final int pendingOrders;
  final int completedOrders;
  final int totalRevenue;

  @override
  List<Object?> get props => [
    totalOrders,
    pendingOrders,
    completedOrders,
    totalRevenue,
  ];
}
