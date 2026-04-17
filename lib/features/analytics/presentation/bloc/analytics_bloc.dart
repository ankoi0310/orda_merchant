import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/analytics/domain/entities/today_stats.dart';
import 'package:orda_merchant/features/analytics/domain/usecases/get_today_stats_use_case.dart';

part 'analytics_event.dart';
part 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  AnalyticsBloc({required GetTodayStatsUseCase getTodayStats})
    : _getTodayStats = getTodayStats,
      super(AnalyticsInitial()) {
    on<GetTodayStats>(_onGetTodayStats);
  }

  final GetTodayStatsUseCase _getTodayStats;

  Future<void> _onGetTodayStats(
    GetTodayStats event,
    Emitter<AnalyticsState> emit,
  ) async {
    final result = await _getTodayStats(event.shopId);

    result.fold(
      (failure) => emit(AnalyticsError(failure.message)),
      (stats) => emit(GetTodayStatsSuccess(stats)),
    );
  }
}
