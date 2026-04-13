import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/domain/usecases/watch_upcoming_orders_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'upcoming_orders_state.dart';

class UpcomingOrdersCubit extends Cubit<UpcomingOrdersState> {
  UpcomingOrdersCubit({
    required WatchUpcomingOrdersUseCase watchUpcomingOrders,
  }) : _watchUpcomingOrders = watchUpcomingOrders,
       super(const UpcomingOrdersState());

  final WatchUpcomingOrdersUseCase _watchUpcomingOrders;

  StreamSubscription<List<Order>>? _upcomingOrdersSubscription;

  Future<void> startWatchingUpcomingOrders(String shopId) async {
    emit(state.copyWith(status: UpcomingOrdersStatus.loading));

    await _upcomingOrdersSubscription?.cancel();

    _upcomingOrdersSubscription = _watchUpcomingOrders(shopId).listen(
      (orders) {
        emit(
          state.copyWith(
            status: UpcomingOrdersStatus.success,
            orders: orders,
          ),
        );
      },
      onError: (dynamic error) {
        print(error);
        if (error is PostgrestException) {
          print(error);
        }
        if (error is RealtimeSubscribeException) {
          print('Realtime error: ${error.details}');
        }
        emit(
          state.copyWith(
            status: UpcomingOrdersStatus.error,
            error: error.toString(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _upcomingOrdersSubscription?.cancel();
    return super.close();
  }
}
