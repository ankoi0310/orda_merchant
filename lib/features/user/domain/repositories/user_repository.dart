import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/user/domain/entities/user_profile.dart';

abstract class UserRepository {
  ResultFuture<UserProfile> getUserProfile();
  VoidFuture signOut();
}
