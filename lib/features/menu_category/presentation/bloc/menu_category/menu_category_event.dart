part of 'menu_category_bloc.dart';

sealed class MenuCategoryEvent extends Equatable {
  const MenuCategoryEvent();

  @override
  List<Object?> get props => [];
}

final class CreateMenuCategory extends MenuCategoryEvent {
  const CreateMenuCategory({required this.name, this.shopId});

  final String? shopId;
  final String name;

  @override
  List<Object?> get props => [name];
}
