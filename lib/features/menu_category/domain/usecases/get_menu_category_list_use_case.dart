import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/extensions/string_extension.dart';
import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu_category/domain/repositories/menu_category_repository.dart';

class GetMenuCategoryListUseCase
    implements UseCase<List<MenuCategory>, String?> {
  const GetMenuCategoryListUseCase({required this.repository});

  final MenuCategoryRepository repository;

  @override
  ResultFuture<List<MenuCategory>> call(String? shopId) async {
    if (shopId == null || !shopId.isValidUuid) {
      return const Left(
        ValidationFailure('Mã cửa hàng không hợp lệ'),
      );
    }

    return repository.getMenuCategoryList(shopId: shopId);
  }
}
