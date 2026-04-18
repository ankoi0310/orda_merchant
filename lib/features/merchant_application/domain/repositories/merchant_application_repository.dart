import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/merchant_application/domain/entities/merchant_application.dart';
import 'package:orda_merchant/features/merchant_application/domain/usecases/register_merchant_use_case.dart';

abstract class MerchantApplicationRepository {
  ResultFuture<MerchantApplication> registerMerchant(
    MerchantApplicationParams params,
  );
}
