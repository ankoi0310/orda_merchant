import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/watch_menu_items_use_case.dart';

part 'menu_item_list_state.dart';

class MenuItemListCubit extends Cubit<MenuItemListState> {
  MenuItemListCubit({required WatchMenuItemsUseCase watchMenuItems})
    : _watchMenuItems = watchMenuItems,
      super(const MenuItemListState());

  final WatchMenuItemsUseCase _watchMenuItems;

  StreamSubscription<List<MenuItem>>? _menuItemSubscription;

  Future<void> startWatchingMenuItems(String shopId) async {
    emit(state.copyWith(status: MenuItemStatus.loading));

    // await _menuItemSubscription?.cancel();

    _menuItemSubscription = _watchMenuItems(shopId).listen(
      (items) {
        print('Got new updated');
        emit(
          state.copyWith(status: MenuItemStatus.loaded, items: items),
        );
      },
      onError: (dynamic error) {
        print(error);
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
    // BẮT BUỘC: Hủy lắng nghe realtime khi thoát màn hình
    await _menuItemSubscription?.cancel();
    return super.close();
  }
}
