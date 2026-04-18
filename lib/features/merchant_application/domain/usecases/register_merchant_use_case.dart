import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/merchant_application/domain/entities/merchant_application.dart';
import 'package:orda_merchant/features/merchant_application/domain/repositories/merchant_application_repository.dart';

class RegisterMerchantUseCase
    implements
        UseCase<MerchantApplication, MerchantApplicationParams> {
  const RegisterMerchantUseCase({required this.repository});

  final MerchantApplicationRepository repository;

  @override
  ResultFuture<MerchantApplication> call(
    MerchantApplicationParams params,
  ) async {
    return repository.registerMerchant(params);
  }
}

class MerchantApplicationParams {
  const MerchantApplicationParams({
    required this.userId,
    required this.shopName,
    required this.address,
    required this.description,
  });

  final String userId;
  final String shopName;
  final String description;
  final String address;

  JsonData toJson() {
    return {
      'user_id': userId,
      'shop_name': shopName,
      'description': description,
      'address': address,
    };
  }
}
