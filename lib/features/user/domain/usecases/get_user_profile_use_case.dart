import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/user/domain/entities/user_profile.dart';
import 'package:orda_merchant/features/user/domain/repositories/user_repository.dart';

class GetUserProfileUseCase
    implements UseCaseWithoutParams<UserProfile> {
  const GetUserProfileUseCase({required this.repository});

  final UserRepository repository;

  @override
  ResultFuture<UserProfile> call() async {
    return repository.getUserProfile();
  }
}
