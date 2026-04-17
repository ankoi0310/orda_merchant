import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/analytics/data/datasources/analytics_remote_data_source.dart';
import 'package:orda_merchant/features/analytics/domain/entities/today_stats.dart';
import 'package:orda_merchant/features/analytics/domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  const AnalyticsRepositoryImpl({required this.remoteDataSource});

  final AnalyticsRemoteDataSource remoteDataSource;

  @override
  ResultFuture<TodayStats> getTodayStats(String shopId) async {
    try {
      final stats = await remoteDataSource.getTodayStats(shopId);
      return Right(stats);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
