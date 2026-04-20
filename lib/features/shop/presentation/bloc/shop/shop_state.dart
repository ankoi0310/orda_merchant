part of 'shop_bloc.dart';

enum ShopStatus {
  initial,
  loading,
  loaded,
  updating,
  updated,
  caching,
  cached,
  removing,
  removed,
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

  bool get isRemoving => status == ShopStatus.removing;

  bool get hasError => status == ShopStatus.error;

  ShopState copyWith({
    ShopStatus? status,
    Shop? shop,
    String? error,
  }) {
    return ShopState(
      status: status ?? this.status,
      shop: shop ?? this.shop,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, shop, error];
}
