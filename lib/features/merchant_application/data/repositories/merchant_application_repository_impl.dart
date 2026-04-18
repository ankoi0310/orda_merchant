import 'package:fpdart/fpdart.dart';
import 'package:orda_merchant/core/error/exceptions.dart';
import 'package:orda_merchant/core/error/failure.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/merchant_application/data/datasources/merchant_application_remote_data_source.dart';
import 'package:orda_merchant/features/merchant_application/domain/entities/merchant_application.dart';
import 'package:orda_merchant/features/merchant_application/domain/repositories/merchant_application_repository.dart';
import 'package:orda_merchant/features/merchant_application/domain/usecases/register_merchant_use_case.dart';

class MerchantApplicationRepositoryImpl
    implements MerchantApplicationRepository {
  const MerchantApplicationRepositoryImpl({required this.remoteDataSource});

  final MerchantApplicationRemoteDataSource remoteDataSource;

  @override
  ResultFuture<MerchantApplication> registerMerchant(
    MerchantApplicationParams params,
  ) async {
    try {
      final application = await remoteDataSource.registerMerchant(
        params,
      );
      return Right(application);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
