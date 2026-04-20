import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/domain/usecases/cache_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/get_cached_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/get_shop_list_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/remove_cached_shop_use_case.dart';

part 'user_setup_state.dart';

class UserSetupCubit extends Cubit<UserSetupState> {
  UserSetupCubit({
    required GetShopListUseCase getShopList,
    required GetCachedShopUseCase getCachedShop,
    required CacheShopUseCase cacheShop,
    required RemoveCachedShopUseCase removeCachedShop,
  }) : _getShopList = getShopList,
       _getCachedShop = getCachedShop,
       _cacheShop = cacheShop,
       _removeCachedShop = removeCachedShop,
       super(UserSetupInitial());

  final GetShopListUseCase _getShopList;
  final GetCachedShopUseCase _getCachedShop;
  final CacheShopUseCase _cacheShop;
  final RemoveCachedShopUseCase _removeCachedShop;

  Future<void> loadUserData() async {
    emit(UserSetupLoading());

    final result = await _getShopList();

    result.fold((failure) => emit(UserSetupError(failure.message)), (
      shops,
    ) async {
      if (shops.isEmpty) {
        emit(UserSetupNoShop());
        return;
      }

      final cachedResult = await _getCachedShop();

      var selectedShop = shops.first; // Default to first shop
      cachedResult.fold(
        (failure) {
          // If getting cached shop fails, keep the default (first shop)
        },
        (cachedShop) {
          // If cached shop exists and is in the list, select it; otherwise keep default
          if (cachedShop != null) {
            final foundShop = shops
                .where((shop) => shop.id == cachedShop.id)
                .firstOrNull;
            if (foundShop != null) {
              selectedShop = foundShop;
            }
          }
        },
      );

      await _cacheShop(selectedShop);
      emit(UserSetupReady(selectedShop: selectedShop, shops: shops));
    });
  }

  Future<void> switchShop(Shop shop) async {
    final current = state;
    if (current is UserSetupReady) {
      await _cacheShop(shop);
      emit(UserSetupReady(selectedShop: shop, shops: current.shops));
    }
  }

  Future<void> reset() async {
    await _removeCachedShop();
    emit(UserSetupInitial());
  }
}
