import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/features/merchant_application/data/models/merchant_application_model.dart';
import 'package:orda_merchant/features/merchant_application/domain/usecases/register_merchant_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MerchantApplicationRemoteDataSource {
  Future<MerchantApplicationModel> registerMerchant(
    MerchantApplicationParams params,
  );
}

class MerchantApplicationRemoteDataSourceImpl
    implements MerchantApplicationRemoteDataSource {
  const MerchantApplicationRemoteDataSourceImpl({
    required this.client,
  });

  final SupabaseClient client;

  @override
  Future<MerchantApplicationModel> registerMerchant(
    MerchantApplicationParams params,
  ) async {
    try {
      return client
          .from('merchant_applications')
          .insert(params.toJson())
          .select()
          .single()
          .withConverter<MerchantApplicationModel>(
            MerchantApplicationModel.fromJson,
          );
    } catch (e) {
      throw ServerException('Đăng ký cửa hàng không thành công: $e');
    }
  }
}
