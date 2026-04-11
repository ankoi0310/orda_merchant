import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/usecases/watch_menu_categories_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'menu_category_list_state.dart';

class MenuCategoryListCubit extends Cubit<MenuCategoryListState> {
  MenuCategoryListCubit({
    required WatchMenuCategoriesUseCase watchMenuCategories,
  }) : _watchMenuCategories = watchMenuCategories,
       super(const MenuCategoryListState());

  final WatchMenuCategoriesUseCase _watchMenuCategories;

  StreamSubscription<List<MenuCategory>>? _menuCategorySubscription;

  Future<void> startWatchingMenuCategories(String shopId) async {
    emit(state.copyWith(status: MenuCategoryStatus.loading));

    await _menuCategorySubscription?.cancel();

    _menuCategorySubscription = _watchMenuCategories(shopId).listen(
      (categories) {
        emit(
          state.copyWith(
            status: MenuCategoryStatus.loaded,
            categories: categories,
          ),
        );
      },
      onError: (dynamic error) {
        print(error);
        if (error is PostgrestException) {
          print(error);
        }
        if (error is RealtimeSubscribeException) {
          print('Realtime error: ${error.details}');
        }
        emit(
          state.copyWith(
            status: MenuCategoryStatus.error,
            error: error.toString(),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _menuCategorySubscription?.cancel();
    return super.close();
  }
}
