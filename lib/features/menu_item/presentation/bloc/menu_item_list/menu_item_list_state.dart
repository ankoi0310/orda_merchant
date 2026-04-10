part of 'menu_item_list_bloc.dart';

enum MenuItemStatus { initial, loading, loaded, error }

class MenuItemListState extends Equatable {
  const MenuItemListState({
    this.status = MenuItemStatus.initial,
    this.items = const [],
    this.error,
  });

  final MenuItemStatus status;
  final List<MenuItem> items;
  final String? error;

  bool get isLoading => status == MenuItemStatus.loading;
  bool get isLoaded => status == MenuItemStatus.loaded;
  bool get isError => status == MenuItemStatus.error;

  MenuItemListState copyWith({
    MenuItemStatus? status,
    List<MenuItem>? items,
    String? error,
  }) {
    return MenuItemListState(
      status: status ?? this.status,
      items: items ?? this.items,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isLoading, items, error];
}
