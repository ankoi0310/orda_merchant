part of 'merchant_application_bloc.dart';

sealed class MerchantApplicationEvent extends Equatable {
  const MerchantApplicationEvent();

  @override
  List<Object?> get props => [];
}

final class RegisterMerchant extends MerchantApplicationEvent {
  const RegisterMerchant({
    required this.userId,
    required this.shopName,
    required this.address,
    required this.description,
  });

  final String userId;
  final String shopName;
  final String address;
  final String description;
}
