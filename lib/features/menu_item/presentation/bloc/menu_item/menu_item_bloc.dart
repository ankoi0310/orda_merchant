import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/create_menu_item_use_case.dart';
import 'package:orda_merchant/features/menu_item/domain/usecases/update_menu_item_use_case.dart';

part 'menu_item_event.dart';

part 'menu_item_state.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  MenuItemBloc({
    required CreateMenuItemUseCase createMenuItem,
    required UpdateMenuItemUseCase updateMenuItem,
  }) : _createMenuItem = createMenuItem,
       _updateMenuItem = updateMenuItem,
       super(MenuItemInitial()) {
    on<MenuItemEvent>((event, emit) => emit(MenuItemLoading()));
    on<CreateMenuItem>(_onCreateMenuItem);
    on<UpdateMenuItem>(_onUpdateMenuItem);
  }

  final CreateMenuItemUseCase _createMenuItem;
  final UpdateMenuItemUseCase _updateMenuItem;

  Future<void> _onCreateMenuItem(
    CreateMenuItem event,
    Emitter<MenuItemState> emit,
  ) async {
    final result = await _createMenuItem(event.params);

    result.fold(
      (failure) => emit(MenuItemError(failure.message)),
      (category) => emit(MenuItemSuccess(category)),
    );
  }

  Future<void> _onUpdateMenuItem(
    UpdateMenuItem event,
    Emitter<MenuItemState> emit,
  ) async {
    final result = await _updateMenuItem(event.params);

    result.fold(
      (failure) => emit(MenuItemError(failure.message)),
      (category) => emit(MenuItemSuccess(category)),
    );
  }
}
