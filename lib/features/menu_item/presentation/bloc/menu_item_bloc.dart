import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu_item/domain/entities/menu_item.dart';

part 'menu_item_event.dart';
part 'menu_item_state.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  MenuItemBloc() : super(MenuItemInitial()) {
    on<MenuItemEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
