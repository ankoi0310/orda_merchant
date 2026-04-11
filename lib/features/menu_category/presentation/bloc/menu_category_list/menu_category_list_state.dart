part of 'menu_category_list_cubit.dart';

enum MenuCategoryStatus { initial, loading, loaded, error }

class MenuCategoryListState extends Equatable {
  const MenuCategoryListState({
    this.status = MenuCategoryStatus.initial,
    this.categories = const [],
    this.error,
  });

  final MenuCategoryStatus status;
  final List<MenuCategory> categories;
  final String? error;

  bool get isLoading => status == MenuCategoryStatus.loading;
  bool get isLoaded => status == MenuCategoryStatus.loaded;
  bool get isError => status == MenuCategoryStatus.error;

  MenuCategoryListState copyWith({
    MenuCategoryStatus? status,
    List<MenuCategory>? categories,
    String? error,
  }) {
    return MenuCategoryListState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, categories, error];
}
