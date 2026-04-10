part of 'menu_item_bloc.dart';

sealed class MenuItemEvent extends Equatable {
  const MenuItemEvent();

  @override
  List<Object?> get props => [];
}

final class CreateMenuItem extends MenuItemEvent {
  const CreateMenuItem(this.params);

  final CreateMenuItemParams params;

  @override
  List<Object?> get props => [params];
}
