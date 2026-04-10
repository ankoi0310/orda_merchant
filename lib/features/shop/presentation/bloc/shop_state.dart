part of 'shop_bloc.dart';

enum ShopStatus { initial, loading, loaded, updating, updated, error }

final class ShopState extends Equatable {
  const ShopState({
    this.status = ShopStatus.initial,
    this.shop,
    this.error,
  });

  final Shop? shop;
  final ShopStatus status;
  final String? error;

  @override
  List<Object?> get props => [status, shop, error];

  ShopState copyWith({
    Shop? shop,
    ShopStatus? status,
    String? error,
  }) {
    return ShopState(
      shop: shop ?? this.shop,
      status: status ?? this.status,
      error: error,
    );
  }
}
