part of 'menu_item_bloc.dart';

sealed class MenuItemState extends Equatable {
  const MenuItemState();

  @override
  List<Object> get props => [];
}

final class MenuItemInitial extends MenuItemState {}

final class MenuItemLoading extends MenuItemState {}

final class MenuItemSuccess extends MenuItemState {
  const MenuItemSuccess(this.item);
  final MenuItem item;

  @override
  List<Object> get props => [item];
}

final class MenuItemError extends MenuItemState {
  const MenuItemError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
