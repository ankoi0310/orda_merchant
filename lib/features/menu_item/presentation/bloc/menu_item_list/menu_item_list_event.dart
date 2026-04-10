part of 'menu_item_list_bloc.dart';

sealed class MenuItemListEvent extends Equatable {
  const MenuItemListEvent();

  @override
  List<Object?> get props => [];
}

final class EnsureItemsLoaded extends MenuItemListEvent {
  const EnsureItemsLoaded({required this.shopId});

  final String shopId;

  @override
  List<Object?> get props => [shopId];
}
