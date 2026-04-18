part of 'merchant_application_bloc.dart';

sealed class MerchantApplicationState extends Equatable {
  const MerchantApplicationState();

  @override
  List<Object?> get props => [];
}

final class MerchantApplicationInitial
    extends MerchantApplicationState {}

final class RegisteringMerchant extends MerchantApplicationState {}

final class RegisterMerchantSuccess extends MerchantApplicationState {
  const RegisterMerchantSuccess(this.application);

  final MerchantApplication application;

  @override
  List<Object?> get props => [application];
}

final class MerchantApplicationError
    extends MerchantApplicationState {
  const MerchantApplicationError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
