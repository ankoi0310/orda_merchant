part of 'shop_list_bloc.dart';

sealed class ShopListState extends Equatable {
  const ShopListState();

  @override
  List<Object?> get props => [];
}

final class ShopListInitial extends ShopListState {}

final class ShopListLoading extends ShopListState {}

final class ShopListLoaded extends ShopListState {
  const ShopListLoaded(this.shops);

  final List<Shop> shops;

  @override
  List<Object?> get props => [shops];
}

final class ShopListError extends ShopListState {
  const ShopListError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
