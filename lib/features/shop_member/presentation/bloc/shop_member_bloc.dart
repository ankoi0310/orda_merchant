import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orda_merchant/features/shop_member/domain/usecases/load_shop_member_list_use_case.dart';

part 'shop_member_event.dart';

part 'shop_member_state.dart';

class ShopMemberBloc extends Bloc<ShopMemberEvent, ShopMemberState> {
  ShopMemberBloc({
    required LoadShopMemberListUseCase loadShopMemberList,
  }) : _loadShopMemberList = loadShopMemberList,
       super(ShopMemberInitial()) {
    on<ShopMemberEvent>((event, emit) => emit(ShopMemberLoading()));
    on<LoadShopMemberList>(_onLoadShopMemberList);
  }

  final LoadShopMemberListUseCase _loadShopMemberList;

  Future<void> _onLoadShopMemberList(
    LoadShopMemberList event,
    Emitter<ShopMemberState> emit,
  ) async {}
}
