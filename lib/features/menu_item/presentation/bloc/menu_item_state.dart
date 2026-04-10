part of 'menu_item_bloc.dart';

sealed class MenuItemState extends Equatable {
  const MenuItemState();

  @override
  List<Object> get props => [];
}

final class MenuItemInitial extends MenuItemState {}

final class MenuItemListFetching extends MenuItemState {}

final class MenuItemListFetched extends MenuItemState {
  const MenuItemListFetched(this.items);

  final List<MenuItem> items;

  @override
  List<Object> get props => [items];
}
