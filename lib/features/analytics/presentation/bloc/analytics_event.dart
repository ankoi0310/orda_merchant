part of 'analytics_bloc.dart';

sealed class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object?> get props => [];
}

final class GetTodayStats extends AnalyticsEvent {
  const GetTodayStats(this.shopId);

  final String shopId;

  @override
  List<Object?> get props => [shopId];
}
