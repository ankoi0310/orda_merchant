import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/domain/usecases/load_shop_use_case.dart';

part 'shop_event.dart';

part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc({required LoadShopUseCase loadShop})
    : _loadShop = loadShop,
      super(const ShopState()) {
    on<LoadShop>(_onLoadShop);
  }

  final LoadShopUseCase _loadShop;

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
}
