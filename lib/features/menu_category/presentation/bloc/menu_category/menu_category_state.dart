part of 'menu_category_bloc.dart';

sealed class MenuCategoryState extends Equatable {
  const MenuCategoryState();
  @override
  List<Object> get props => [];
}

final class MenuCategoryInitial extends MenuCategoryState {}

final class MenuCategoryListFetching extends MenuCategoryState {}

final class CreatingMenuCategory extends MenuCategoryState {}

final class CreateMenuCategorySuccess extends MenuCategoryState {
  const CreateMenuCategorySuccess(this.category);
  final MenuCategory category;

  @override
  List<Object> get props => [category];
}

final class MenuCategoryError extends MenuCategoryState {
  const MenuCategoryError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
