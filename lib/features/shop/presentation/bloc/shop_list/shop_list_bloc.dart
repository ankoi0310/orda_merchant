import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/shop/domain/entities/shop.dart';
import 'package:orda_merchant/features/shop/domain/usecases/get_shop_list_use_case.dart';

part 'shop_list_event.dart';

part 'shop_list_state.dart';

class ShopListBloc extends Bloc<ShopListEvent, ShopListState> {
  ShopListBloc({required GetShopListUseCase getShopList})
    : _getShopList = getShopList,
      super(ShopListInitial()) {
    on<FetchShopList>(_onFetchShopList);
  }

  final GetShopListUseCase _getShopList;

  Future<void> _onFetchShopList(
    FetchShopList event,
    Emitter<ShopListState> emit,
  ) async {
    emit(ShopListLoading());
    final result = await _getShopList();

    result.fold((failure) {
      emit(ShopListError(failure.message));
    }, (shops) => emit(ShopListLoaded(shops)));
  }
}
