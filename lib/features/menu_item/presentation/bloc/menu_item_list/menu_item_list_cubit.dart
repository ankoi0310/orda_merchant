import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/watch_menu_items_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'menu_item_list_state.dart';

class MenuItemListCubit extends Cubit<MenuItemListState> {
  MenuItemListCubit({required WatchMenuItemsUseCase watchMenuItems})
    : _watchMenuItems = watchMenuItems,
      super(const MenuItemListState());

  final WatchMenuItemsUseCase _watchMenuItems;

  StreamSubscription<List<MenuItem>>? _menuItemSubscription;

  Future<void> startWatchingMenuItems(String shopId) async {
    emit(state.copyWith(status: MenuItemStatus.loading));

    await _menuItemSubscription?.cancel();

    _menuItemSubscription = _watchMenuItems(shopId).listen(
      (items) {
        emit(
          state.copyWith(status: MenuItemStatus.loaded, items: items),
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
            status: MenuItemStatus.error,
            error: error.toString(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _menuItemSubscription?.cancel();
    return super.close();
  }
}
