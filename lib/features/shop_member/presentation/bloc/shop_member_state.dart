part of 'shop_member_bloc.dart';

sealed class ShopMemberState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ShopMemberInitial extends ShopMemberState {}

final class ShopMemberLoading extends ShopMemberState {}

final class ShopMemberSuccess extends ShopMemberState {
  ShopMemberSuccess(this.shopMembers);

  final List<ShopMemberSuccess> shopMembers;

  @override
  List<Object?> get props => [shopMembers];
}

final class ShopMemberError extends ShopMemberState {
  ShopMemberError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
