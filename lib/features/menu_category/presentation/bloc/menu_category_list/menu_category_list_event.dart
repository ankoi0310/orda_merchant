part of 'menu_category_list_bloc.dart';

sealed class MenuCategoryListEvent extends Equatable {
  const MenuCategoryListEvent();

  @override
  List<Object?> get props => [];
}

final class EnsureCategoriesLoaded extends MenuCategoryListEvent {
  const EnsureCategoriesLoaded({required this.shopId});

  final String shopId;

  @override
  List<Object?> get props => [shopId];
}
