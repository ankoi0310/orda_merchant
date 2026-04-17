import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/analytics/domain/entities/today_stats.dart';

class TodayStatsModel extends TodayStats {
  const TodayStatsModel({
    required super.totalOrders,
    required super.pendingOrders,
    required super.completedOrders,
    required super.totalRevenue,
  });

  factory TodayStatsModel.fromJson(JsonData json) {
    return TodayStatsModel(
      totalOrders: json['total_orders'] as int,
      pendingOrders: json['pending_orders'] as int,
      completedOrders: json['completed_orders'] as int,
      totalRevenue: json['total_revenue'] as int,
    );
  }
}
