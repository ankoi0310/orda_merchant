part of 'shop_list_bloc.dart';

sealed class ShopListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class FetchShopList extends ShopListEvent {}
