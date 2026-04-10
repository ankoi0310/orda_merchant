import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/get_menu_item_list_use_case.dart';

part 'menu_item_list_event.dart';

part 'menu_item_list_state.dart';

class MenuItemListBloc
    extends Bloc<MenuItemListEvent, MenuItemListState> {
  MenuItemListBloc({required GetMenuItemListUseCase getMenuItemList})
    : _getMenuItemList = getMenuItemList,
      super(const MenuItemListState()) {
    on<EnsureItemsLoaded>((event, emit) async {
      if (state.isLoaded && state.items.isNotEmpty) return;

      if (state.isLoading) return;

      emit(state.copyWith(status: MenuItemStatus.loading));

      final result = await _getMenuItemList(event.shopId);

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: MenuItemStatus.error,
            error: failure.message,
          ),
        ),
        (items) => emit(
          state.copyWith(status: MenuItemStatus.loaded, items: items),
        ),
      );
    });
  }

  final GetMenuItemListUseCase _getMenuItemList;
}
