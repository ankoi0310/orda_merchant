import 'package:orda_merchant/features/analytics/data/models/today_stats_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AnalyticsRemoteDataSource {
  Future<TodayStatsModel> getTodayStats(String shopId);
}

class AnalyticsRemoteDataSourceImpl
    implements AnalyticsRemoteDataSource {
  const AnalyticsRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<TodayStatsModel> getTodayStats(String shopId) async {
    return client
        .rpc<TodayStatsModel>(
          'get_today_stats',
          params: {'p_shop_id': shopId},
        )
        .single()
        .withConverter(TodayStatsModel.fromJson);
  }
}
