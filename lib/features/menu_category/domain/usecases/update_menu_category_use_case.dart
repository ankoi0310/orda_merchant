import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/repositories/menu_category_repository.dart';

class UpdateMenuCategoryUseCase
    implements UseCase<MenuCategory, UpdateMenuCategoryParams> {
  const UpdateMenuCategoryUseCase({required this.repository});

  final MenuCategoryRepository repository;

  @override
  ResultFuture<MenuCategory> call(
    UpdateMenuCategoryParams params,
  ) async {
    return repository.updateMenuCategory(params);
  }
}

class UpdateMenuCategoryParams {
  const UpdateMenuCategoryParams({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  JsonData toJson() {
    return {'name': name};
  }
}
