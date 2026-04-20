part of 'user_setup_cubit.dart';

sealed class UserSetupState extends Equatable {
  const UserSetupState();

  @override
  List<Object?> get props => [];
}

final class UserSetupInitial extends UserSetupState {}

final class UserSetupLoading extends UserSetupState {}

final class UserSetupNoShop
    extends UserSetupState {} // → trang đăng ký

final class UserSetupReady extends UserSetupState {
  const UserSetupReady({
    required this.selectedShop,
    required this.shops,
  });

  final Shop? selectedShop;
  final List<Shop> shops;

  @override
  List<Object?> get props => [selectedShop, shops];
}

final class UserSetupError extends UserSetupState {
  const UserSetupError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
