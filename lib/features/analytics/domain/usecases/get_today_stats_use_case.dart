import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/analytics/domain/entities/today_stats.dart';
import 'package:orda_merchant/features/analytics/domain/repositories/analytics_repository.dart';

class GetTodayStatsUseCase implements UseCase<TodayStats, String> {
  const GetTodayStatsUseCase({required this.repository});

  final AnalyticsRepository repository;

  @override
  ResultFuture<TodayStats> call(String shopId) async {
    return repository.getTodayStats(shopId);
  }
}
