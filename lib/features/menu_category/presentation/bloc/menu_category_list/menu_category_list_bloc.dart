import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/get_menu_category_list_use_case.dart';

part 'menu_category_list_event.dart';

part 'menu_category_list_state.dart';

class MenuCategoryListBloc
    extends Bloc<MenuCategoryListEvent, MenuCategoryListState> {
  MenuCategoryListBloc({
    required GetMenuCategoryListUseCase getMenuCateogryList,
  }) : _getMenuCategoryList = getMenuCateogryList,
       super(const MenuCategoryListState()) {
    on<EnsureCategoriesLoaded>((event, emit) async {
      if (state.isLoaded && state.categories.isNotEmpty) return;

      if (state.isLoading) return;

      emit(state.copyWith(status: MenuCategoryStatus.loading));

      final result = await _getMenuCategoryList(event.shopId);

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: MenuCategoryStatus.error,
            error: failure.message,
          ),
        ),
        (categories) => emit(
          state.copyWith(
            status: MenuCategoryStatus.loaded,
            categories: categories,
          ),
        ),
      );
    });
  }

  final GetMenuCategoryListUseCase _getMenuCategoryList;
}
