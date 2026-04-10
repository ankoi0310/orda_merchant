import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/create_menu_category_use_case.dart';

part 'menu_category_event.dart';

part 'menu_category_state.dart';

class MenuCategoryBloc
    extends Bloc<MenuCategoryEvent, MenuCategoryState> {
  MenuCategoryBloc({
    required CreateMenuCategoryUseCase createMenuCategory,
  }) : _createMenuCategory = createMenuCategory,
       super(MenuCategoryInitial()) {
    on<MenuCategoryEvent>(
      (state, emit) => emit(MenuCategoryLoading()),
    );
    on<CreateMenuCategory>(_onCreateMenuCategory);
  }

  final CreateMenuCategoryUseCase _createMenuCategory;

  Future<void> _onCreateMenuCategory(
    CreateMenuCategory event,
    Emitter<MenuCategoryState> emit,
  ) async {
    final result = await _createMenuCategory(
      CreateMenuCategoryParams(
        name: event.name,
        shopId: event.shopId,
      ),
    );

    result.fold(
      (failure) => emit(MenuCategoryError(failure.message)),
      (category) => emit(MenuCategorySuccess(category)),
    );
  }
}
