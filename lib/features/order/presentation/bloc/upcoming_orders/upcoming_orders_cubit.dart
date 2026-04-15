import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/order/domain/entities/order.dart';
import 'package:orda_merchant/features/order/domain/usecases/confirm_order_complete_use_case.dart';
import 'package:orda_merchant/features/order/domain/usecases/watch_upcoming_orders_use_case.dart';
import 'package:orda_merchant/features/order/presentation/bloc/history_orders/history_orders_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'upcoming_orders_state.dart';

class UpcomingOrdersCubit extends Cubit<UpcomingOrdersState> {
  UpcomingOrdersCubit({
    required WatchUpcomingOrdersUseCase watchUpcomingOrders,
    required ConfirmOrderCompleteUseCase confirmOrderComplete,
    required HistoryOrdersCubit historyOrdersCubit,
  }) : _watchUpcomingOrders = watchUpcomingOrders,
       _confirmOrderComplete = confirmOrderComplete,
       _historyOrdersCubit = historyOrdersCubit,
       super(const UpcomingOrdersState());

  final WatchUpcomingOrdersUseCase _watchUpcomingOrders;
  final ConfirmOrderCompleteUseCase _confirmOrderComplete;

  final HistoryOrdersCubit _historyOrdersCubit;

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
          emit(
            state.copyWith(
              status: UpcomingOrdersStatus.error,
              error:
                  'Cơ sở dữ liệu đã ngắt kết nối. Vui lòng thử lại sau.',
            ),
          );
          print('Realtime error: $error');
        }
      },
    );
  }

  Future<void> confirmOrderComplete(String orderId) async {
    emit(state.copyWith(status: UpcomingOrdersStatus.updating));
    final result = await _confirmOrderComplete(orderId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: UpcomingOrdersStatus.error,
          error: failure.message,
        ),
      ),
      (order) {
        print('success');
        emit(state.copyWith(status: UpcomingOrdersStatus.success));
        _historyOrdersCubit.cacheUpdatedOrder(order);
      },
    );
  }

  @override
  Future<void> close() async {
    await _upcomingOrdersSubscription?.cancel();
    return super.close();
  }
}
