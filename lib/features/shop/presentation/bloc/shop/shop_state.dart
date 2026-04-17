part of 'shop_bloc.dart';

enum ShopStatus {
  initial,
  loading,
  loaded,
  updating,
  updated,
  caching,
  cached,
  error,
}

final class ShopState extends Equatable {
  const ShopState({
    this.status = ShopStatus.initial,
    this.shop,
    this.error,
  });

  final Shop? shop;
  final ShopStatus status;
  final String? error;

  bool get isLoading => status == ShopStatus.loading;

  bool get isUpdating => status == ShopStatus.updating;

  bool get isCaching => status == ShopStatus.caching;

  bool get hasError => status == ShopStatus.error;

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

  @override
  List<Object?> get props => [status, shop, error];
}
