import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/analytics/domain/entities/today_stats.dart';

abstract class AnalyticsRepository {
  ResultFuture<TodayStats> getTodayStats(String shopId);
}
