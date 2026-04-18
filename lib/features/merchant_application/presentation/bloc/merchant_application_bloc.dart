import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/merchant_application/domain/entities/merchant_application.dart';
import 'package:orda_merchant/features/merchant_application/domain/usecases/register_merchant_use_case.dart';

part 'merchant_application_event.dart';

part 'merchant_application_state.dart';

class MerchantApplicationBloc
    extends Bloc<MerchantApplicationEvent, MerchantApplicationState> {
  MerchantApplicationBloc({
    required RegisterMerchantUseCase registerMerchant,
  }) : _registerMerchant = registerMerchant,
       super(MerchantApplicationInitial()) {
    on<RegisterMerchant>(_onRegiserMerchant);
  }

  final RegisterMerchantUseCase _registerMerchant;

  Future<void> _onRegiserMerchant(
    RegisterMerchant event,
    Emitter<MerchantApplicationState> emit,
  ) async {
    emit(RegisteringMerchant());

    final result = await _registerMerchant(
      MerchantApplicationParams(
        userId: event.userId,
        shopName: event.shopName,
        address: event.address,
        description: event.description,
      ),
    );

    result.fold(
      (failure) => emit(MerchantApplicationError(failure.message)),
      (application) => emit(RegisterMerchantSuccess(application)),
    );
  }
}
