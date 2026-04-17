part of 'analytics_bloc.dart';

sealed class AnalyticsState extends Equatable {
  const AnalyticsState();

  @override
  List<Object> get props => [];
}

final class AnalyticsInitial extends AnalyticsState {}

final class GettingTodayStats extends AnalyticsState {}

final class GetTodayStatsSuccess extends AnalyticsState {
  const GetTodayStatsSuccess(this.stats);

  final TodayStats stats;

  @override
  List<Object> get props => [stats];
}

final class AnalyticsError extends AnalyticsState {
  const AnalyticsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
