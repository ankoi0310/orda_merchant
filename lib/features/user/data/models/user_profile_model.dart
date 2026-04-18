import 'package:orda_merchant/core/utils/typedefs.dart';
import 'package:orda_merchant/features/user/domain/entities/user_profile.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.id,
    required super.fullName,
    required super.email,
  });

  factory UserProfileModel.fromJson(User user, JsonData json) {
    return UserProfileModel(
      id: user.id,
      fullName: json['full_name'] as String,
      email: user.email ?? '',
    );
  }
}
