import 'package:orda_merchant/core/usecase/usecase.dart';
import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/user/domain/repositories/user_repository.dart';

class SignOutUseCase implements UseCaseWithoutParams<void> {
  const SignOutUseCase({required this.repository});

  final UserRepository repository;

  @override
  ResultFuture<void> call() async {
    return repository.signOut();
  }
}
