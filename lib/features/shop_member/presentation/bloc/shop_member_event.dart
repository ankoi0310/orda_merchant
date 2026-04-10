part of 'shop_member_bloc.dart';

sealed class ShopMemberEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoadShopMemberList extends ShopMemberEvent {
  LoadShopMemberList({this.shopId});

  final String? shopId;

  @override
  List<Object?> get props => [shopId];
}
