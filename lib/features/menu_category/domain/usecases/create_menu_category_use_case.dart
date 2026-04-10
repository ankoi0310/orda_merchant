import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/extensions/string_extension.dart';
import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/repositories/menu_category_repository.dart';

class CreateMenuCategoryUseCase
    implements UseCase<MenuCategory, CreateMenuCategoryParams> {
  const CreateMenuCategoryUseCase({required this.repository});

  final MenuCategoryRepository repository;

  @override
  ResultFuture<MenuCategory> call(
    CreateMenuCategoryParams params,
  ) async {
    if (params.shopId == null || !params.shopId!.isValidUuid) {
      return const Left(
        ValidationFailure('Mã cửa hàng không hợp lệ'),
      );
    }

    return repository.createMenuCategory(
      shopId: params.shopId!,
      name: params.name,
    );
  }
}

class CreateMenuCategoryParams {
  const CreateMenuCategoryParams({required this.name, this.shopId});

  final String? shopId;
  final String name;
}
