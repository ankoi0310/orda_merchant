import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/domain/usecases/cache_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/get_cached_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/load_shop_use_case.dart';
import 'package:orda_merchant/features/shop/domain/usecases/remove_cached_shop_use_case.dart';

part 'shop_event.dart';

part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc({
    required LoadShopUseCase loadShop,
    required GetCachedShopUseCase getCachedShop,
    required CacheShopUseCase cacheShop,
    required RemoveCachedShopUseCase removeCachedShop,
  }) : _loadShop = loadShop,
       _getCachedSHop = getCachedShop,
       _cacheShop = cacheShop,
       _removeCachedShop = removeCachedShop,
       super(const ShopState()) {
    on<LoadShop>(_onLoadShop);
    on<GetCachedShop>(_onGetCachedShop);
    on<CacheShop>(_onCacheShop);
    on<RemoveCachedShop>(_onRemoveCachedShop);
  }

  final LoadShopUseCase _loadShop;
  final GetCachedShopUseCase _getCachedSHop;
  final CacheShopUseCase _cacheShop;
  final RemoveCachedShopUseCase _removeCachedShop;

  Future<void> _onLoadShop(
    LoadShop event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(status: ShopStatus.loading));

    final result = await _loadShop(event.shopId);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ShopStatus.error,
          error: failure.message,
        ),
      ),
      (shop) =>
          emit(state.copyWith(status: ShopStatus.loaded, shop: shop)),
    );
  }

  Future<void> _onGetCachedShop(
    GetCachedShop event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(status: ShopStatus.loading));

    final result = await _getCachedSHop();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ShopStatus.error,
          error: failure.message,
        ),
      ),
      (shop) =>
          emit(state.copyWith(status: ShopStatus.loaded, shop: shop)),
    );
  }

  Future<void> _onCacheShop(
    CacheShop event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(status: ShopStatus.caching));

    final result = await _cacheShop(event.shop);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ShopStatus.error,
          error: failure.message,
        ),
      ),
      (_) => emit(
        state.copyWith(status: ShopStatus.cached, shop: event.shop),
      ),
    );
  }

  Future<void> _onRemoveCachedShop(
    RemoveCachedShop event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(status: ShopStatus.removing));

    final result = await _removeCachedShop();

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ShopStatus.error,
          error: failure.message,
        ),
      ),
      (_) => emit(
        const ShopState().copyWith(status: ShopStatus.removed),
      ),
    );
  }
}
