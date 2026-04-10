import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/create_menu_category_use_case.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/get_menu_category_list_use_case.dart';

part 'menu_category_event.dart';

part 'menu_category_state.dart';

class MenuCategoryBloc
    extends Bloc<MenuCategoryEvent, MenuCategoryState> {
  MenuCategoryBloc({
    required GetMenuCategoryListUseCase getMenuCateogryList,
    required CreateMenuCategoryUseCase createMenuCategory,
  }) : _getMenuCategoryList = getMenuCateogryList,
       _createMenuCategory = createMenuCategory,
       super(MenuCategoryInitial()) {
    on<GetMenuCategoryList>(_onGetMenuCategoryList);
    on<CreateMenuCategory>(_onCreateMenuCategory);
  }

  final GetMenuCategoryListUseCase _getMenuCategoryList;
  final CreateMenuCategoryUseCase _createMenuCategory;

  Future<void> _onGetMenuCategoryList(
    GetMenuCategoryList event,
    Emitter<MenuCategoryState> emit,
  ) async {
    final result = await _getMenuCategoryList(event.shopId);

    result.fold(
      (failure) => emit(MenuCategoryError(failure.message)),
      (categories) => emit(MenuCategoryListFetched(categories)),
    );
  }

  Future<void> _onCreateMenuCategory(
    CreateMenuCategory event,
    Emitter<MenuCategoryState> emit,
  ) async {
    print(event.shopId);
    final result = await _createMenuCategory(
      CreateMenuCategoryParams(
        name: event.name,
        shopId: event.shopId,
      ),
    );

    result.fold(
      (failure) => emit(MenuCategoryError(failure.message)),
      (category) => emit(CreateMenuCategorySuccess(category)),
    );
  }
}
